import '../models/sessao/login_model.dart';

abstract class IUsuarios {
  ///Efetua o login do usuário
  Future<void> login(LoginModel login);
}
