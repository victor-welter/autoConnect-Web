import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/sessao/login_model.dart';
import '../../models/sessao/novo_usuario_model.dart';
import '../../services/http_service.dart';

class UsuarioRepository {
  static Future<Map> login(LoginModel login) async {
    Map jsonData = {
      'cpfCnpj': login.cpfCnpj,
      'senha': login.senha,
    };

    Map body = {
      '_data': jsonEncode(jsonData),
    };

    return await HttpService.post(
      rota: WebRoutes.LOGIN,
      body: body,
      useToken: false,
    );
  }

  static Future<Map> registrar(NovoUsuarioModel novoUsuario) async {
    Map jsonData = {
      'cpfCnpj': novoUsuario.cpfCnpj,
      'nome': novoUsuario.nome,
      'email': novoUsuario.email,
      'senha': novoUsuario.senha,
    };

    Map body = {
      '_data': jsonEncode(jsonData),
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR,
      body: body,
      useToken: false,
    );
  }
}
