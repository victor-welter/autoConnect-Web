import '../../interfaces/iusuarios.dart';
import '../../models/sessao/login_model.dart';
import '../../models/sessao/novo_usuario_model.dart';

class UsuariosController implements IUsuarios {
  @override
  Future<void> login(LoginModel login) async {
    // TODO implementar login
  }

  @override
  Future<void> registrar(NovoUsuarioModel novoUsuario) {
    // TODO implementar registrar
    throw UnimplementedError();
  }
}
