import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _s = const FlutterSecureStorage();
  Future<void> save(String access, String refresh) async {
    await _s.write(key: 'access_token', value: access);
    await _s.write(key: 'refresh_token', value: refresh);
  }

  Future<String?> readAccess() => _s.read(key: 'access_token');
  Future<String?> readRefresh() => _s.read(key: 'refresh_token');
  Future<void> clear() async {
    await _s.deleteAll();
  }
}
