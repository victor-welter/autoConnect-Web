import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/local/local_model.dart';
import '../../services/http_service.dart';

class LocalRepository {
  static Future<Map<String, dynamic>> buscarLocais(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_LOCAL,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(LocalModel local) async {
    Map jsonData = {
      "nome": local.nome,
      "endereco": local.endereco,
      "id_categoria": local.categoria?.idCategoria,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_LOCAL,
      body: jsonEncode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> deletarLocal(LocalModel local) async {
    Map params = {
      'id_local': local.idLocal,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_LOCAL,
      params: params,
    );
  }
}
