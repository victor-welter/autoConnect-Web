// ignore_for_file: constant_identifier_names

import 'routes/local_routes.dart';

///Armazena dados constantes
class App {
  static const NAME = 'Auto Connect';

  static const VERSION = '1.0.1';

  static const DATA_ATUALIZACAO = '21/08/2023';
}

enum ErrorType {
  generic,
  login,
  http_request,
  session,
  expiredToken,
  cadastro,
}

enum DialogAction { ok, sim_nao, none }

class SharedKeys {
  static const SECURE_TOKEN = 'secure_token';

  static const DADOS_USER = 'dados_user';
}

class CadOptions {
  static const SIM = 1;

  static const NAO = 0;

  static const MANUTENCAO_PREVENTIVA = 0;

  static const MANUTENCAO_CORRETIVA = 1;
}

class RoutesOptions {
  static const LIVRE_ACESSO = [LocalRoutes.CADASTRO_USUARIO];
}

class ValidationPattern {
  static const PATTERN = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.,]).{8,}\$";

  static const LENGTH_SENHA = ".{8,}";

  static const MAIUSCULA = "(?=.*[A-Z])";

  static const MINUSCULA = "(?=.*[a-z])";

  static const NUMEROS = "(?=.*?[0-9])";

  static const CARACTERE_ESPECIAL = "(?=.*?[!@#\$&*~.,])";
}
