import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _s = const FlutterSecureStorage();

  // existing method (keep for backwards compatibility)
  Future<void> save(String access, String refresh) async {
    try {
      await _s.write(key: 'access_token', value: access);
      await _s.write(key: 'refresh_token', value: refresh);
    } catch (e) {
      rethrow;
    }
  }

  // convenience / compatibility methods
  Future<void> writeAccess(String access) => _s.write(key: 'access_token', value: access);
  Future<void> writeRefresh(String refresh) => _s.write(key: 'refresh_token', value: refresh);

  Future<String?> readAccess() => _s.read(key: 'access_token');
  Future<String?> readRefresh() => _s.read(key: 'refresh_token');

  Future<void> clear() async {
    await _s.delete(key: 'access_token');
    await _s.delete(key: 'refresh_token');
  }

  Future<void> clearAccess() => _s.delete(key: 'access_token');
  Future<void> clearRefresh() => _s.delete(key: 'refresh_token');
}
