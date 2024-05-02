
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveOption(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getOption(String key) async {
    return await _storage.read(key: key);
  }
}
