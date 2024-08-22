import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../configs/constants.dart';
import '../../interfaces/iusuarios.dart';
import '../../models/erros/error_model.dart';
import '../../models/sessao/login_model.dart';
import '../../models/sessao/novo_usuario_model.dart';
import '../../models/sessao/sessao_model.dart';
import '../../services/secure_storage_service.dart';
import '../../services/service_locator.dart';
import '../../services/supabase_service.dart';

class UsuariosController implements IUsuarios {
  @override
  Future<SessaoModel> login(LoginModel login) async {
    try {
      // Criptografar a senha usando SHA-256
      final bytes = utf8.encode(login.senha!);
      final digest = sha256.convert(bytes);
      final senhaHash = digest.toString();

      // Consulta ao banco de dados para verificar o usuário
      final response = await SupabaseService().client.from('usuario').select('*').eq('email', login.email!).eq('senha', senhaHash);

      if (response.isEmpty) {
        throw ErrorModel("Usuário ou senha inválidos!");
      }

      final sessao = SessaoModel.fromMap(response.first);

      await SecureStorageService.delete(SharedKeys.DADOS_USER);
      await SecureStorageService.save(SharedKeys.DADOS_USER, jsonEncode(response.first));

      if (!getIt.isRegistered<SessaoModel>() || getIt<SessaoModel>().email != sessao.email) {
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
      // Criptografar a senha usando SHA-256
      final bytes = utf8.encode(novoUsuario.senha!);
      final digest = sha256.convert(bytes);
      final senhaHash = digest.toString();

      // Inserção de dados na tabela 'USUARIO'
      await SupabaseService().client.from('usuario').insert({
        'nome': novoUsuario.nome,
        'email': novoUsuario.email,
        'senha': senhaHash,
      });

      final response = await SupabaseService().client.from('usuario').select().eq("email", novoUsuario.email!);

      await SupabaseService().client.from('usuario_permissao').insert({
        'id_usuario': response.first['id_usuario'],
        'id_permissao': 2, // Permissão default
      });
    } catch (_) {
      rethrow;
    }
  }
}
