import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage storage;
  final Dio authless;
  bool _refreshing = false;
  final _queue = <RequestOptions>[];

  AuthInterceptor(this.storage, this.authless);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.readAccess();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_refreshing) {
      _refreshing = true;
      try {
        final refresh = await storage.readRefresh();
        if (refresh == null) return handler.next(err);

        final res = await authless.post('/auth/refresh', data: {'refresh_token': refresh});
        final data = res.data['data'];
        await storage.save(data['access_token'], data['refresh_token']);

        for (final req in _queue) {
          req.headers['Authorization'] = 'Bearer ${data['access_token']}';
          handler.resolve(await authless.fetch(req));
        }
        _queue.clear();
        _refreshing = false;

        final req = err.requestOptions;
        req.headers['Authorization'] = 'Bearer ${data['access_token']}';
        return handler.resolve(await authless.fetch(req));
      } catch (_) {
        _refreshing = false;
        _queue.clear();
        return handler.next(err);
      }
    } else if (err.response?.statusCode == 401 && _refreshing) {
      _queue.add(err.requestOptions);
      return;
    }
    handler.next(err);
  }
}

Dio buildDio(String baseUrl, TokenStorage storage) {
  final authless = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 20)));
  final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 20)));
  dio.interceptors.add(AuthInterceptor(storage, authless));
  return dio;
}
