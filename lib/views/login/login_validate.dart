import '../../utils/functions_utils.dart';

class LoginValidate {
  static String? usuario(String? usuario) {
    if (isNullOrEmpty(usuario)) {
      return 'Informe o seu usuário';
    }

    return null;
  }

  static String? senha(String? senha) {
    if (isNullOrEmpty(senha)) {
      return 'Informe uma senha';
    }

    return null;
  }
}
