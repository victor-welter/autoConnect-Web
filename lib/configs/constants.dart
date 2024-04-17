// ignore_for_file: constant_identifier_names

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
}

class CadOptions {
  static const SIM = 1;

  static const NAO = 0;
}
