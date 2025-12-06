import 'dart:async';
import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage storage;
  final Dio authless;
  bool _refreshing = false;

  final List<_QueuedRequest> _queue = [];

  AuthInterceptor(this.storage, this.authless);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await storage.readAccess();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    final reqOptions = err.requestOptions;

    // Jika bukan 401, lanjutkan error biasa
    if (status != 401) {
      handler.next(err);
      return;
    }

    // coba ambil refresh token
    final refresh = await storage.readRefresh();
    if (refresh == null) {
      // tidak ada refresh -> tidak bisa refresh, lanjutkan error
      handler.next(err);
      return;
    }

    if (_refreshing) {
      final completer = Completer<Response>();
      _queue.add(_QueuedRequest(reqOptions, completer));
      try {
        final response = await completer.future;
        handler.resolve(response);
      } catch (e) {
        handler.next(err); // forward original error jika gagal
      }
      return;
    }

    // Mulai proses refresh
    _refreshing = true;
    try {
      final res = await authless.post(
        '/auth/refresh', // <-- pastikan ini path yang benar di backendmu
        data: {'refresh_token': refresh},
      );

      final data = res.data['data'];
      final newAccess = data['access_token'] as String?;
      final newRefresh = data['refresh_token'] as String?;

      if (newAccess == null || newRefresh == null) {
        // refresh gagal
        await storage.clear();
        _failQueued(err);
        handler.next(err);
        _refreshing = false;
        return;
      }

      await storage.save(newAccess, newRefresh);

      final opts = reqOptions;
      opts.headers['Authorization'] = 'Bearer $newAccess';

      final retried = await authless.fetch(opts);

      handler.resolve(retried);

      for (final queued in _queue) {
        try {
          queued.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
          final r = await authless.fetch(queued.requestOptions);
          queued.completer.complete(r);
        } catch (e) {
          queued.completer.completeError(e);
        }
      }
      _queue.clear();
    } catch (e) {
      await storage.clear();
      _failQueued(err);
      handler.next(err);
    } finally {
      _refreshing = false;
    }
  }

  void _failQueued(DioException originalErr) {
    for (final q in _queue) {
      q.completer.completeError(originalErr);
    }
    _queue.clear();
  }
}

class _QueuedRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;
  _QueuedRequest(this.requestOptions, this.completer);
}


