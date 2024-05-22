import 'package:shared_preferences/shared_preferences.dart';

///Armazena informações confidenciais de forma segura
class SecureStorageService {
  static final _storage = SharedPreferences.getInstance();

  static Future<String?> read(String key, {String suffix = ''}) async {
    SharedPreferences pref = await _storage;

    if (!pref.containsKey(key + suffix.toUpperCase())) {
      return null;
    }

    String value = pref.getString(key + suffix.toUpperCase())!;

    return value;
  }

  static Future<void> save(String key, String value, {String suffix = ''}) async {
    SharedPreferences pref = await _storage;

    await pref.setString(key + suffix.toUpperCase(), value);
  }

  static Future<void> delete(String key, {String suffix = ''}) async {
    SharedPreferences pref = await _storage;

    if (pref.containsKey(key + suffix.toUpperCase())) {
      await pref.remove(key + suffix.toUpperCase());
    }
  }

  static Future<bool> hasKey(String key, {String suffix = ''}) async {
    SharedPreferences pref = await _storage;

    return pref.containsKey(key + suffix.toUpperCase());
  }
}
