import 'dart:convert';

import '../../configs/constants.dart';
import '../../interfaces/iusuarios.dart';
import '../../models/sessao/login_model.dart';
import '../../models/sessao/novo_usuario_model.dart';
import '../../models/sessao/sessao_model.dart';
import '../../repository/usuarios/usuarios_repository.dart';
import '../../services/secure_storage_service.dart';
import '../../services/service_locator.dart';
import '../../utils/request_utils.dart';

class UsuariosController implements IUsuarios {
  @override
  Future<SessaoModel> login(LoginModel login) async {
    try {
      final response = await UsuarioRepository.login(login);

      validaResponse(response);

      final sessao = SessaoModel.fromMap(response['data']);

      await SecureStorageService.delete(SharedKeys.DADOS_USER);
      await SecureStorageService.save(SharedKeys.DADOS_USER, jsonEncode(response['data']));

      if (!getIt.isRegistered<SessaoModel>() || getIt<SessaoModel>().cpfCnpj != sessao.cpfCnpj) {
        getIt.registerSingleton<SessaoModel>(sessao);
      } else {
        getIt.unregister<SessaoModel>();
        getIt.registerSingleton<SessaoModel>(sessao);
      }

      return sessao;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> registrar(NovoUsuarioModel novoUsuario) async {
    try {
      final response = await UsuarioRepository.registrar(novoUsuario);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
