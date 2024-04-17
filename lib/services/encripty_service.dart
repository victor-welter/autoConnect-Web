import 'package:encrypt/encrypt.dart';

class EncriptyService {
  final _key = Key.fromLength(32);
  final _iv = IV.fromLength(16);

  String encryptString(String text) {
    final encrypter = Encrypter(AES(_key));

    final encrypted = encrypter.encrypt(text, iv: _iv);

    return encrypted.base64;
  }

  String decryptString(String text) {
    final encrypter = Encrypter(AES(_key));

    final encrypted = Encrypted.fromBase64(text);
    final decrypted = encrypter.decrypt(encrypted, iv: _iv);

    return decrypted;
  }
}
