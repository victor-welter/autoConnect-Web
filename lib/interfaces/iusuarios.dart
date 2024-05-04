import '../models/sessao/login_model.dart';
import '../models/sessao/novo_usuario_model.dart';

abstract class IUsuarios {
  ///Efetua o login do usuário
  Future<void> login(LoginModel login);

  Future<void> registrar(NovoUsuarioModel novoUsuario);
}
