import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/marca/marca_model.dart';
import '../../services/http_service.dart';

class MarcaRepository {
  static Future<Map<String, dynamic>> buscarMarcas(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_MARCA,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(MarcaModel marca) async {
    Map jsonData = {
      "descricao": marca.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_MARCA,
      body: jsonEncode(jsonData),
    );
  }

    static Future<Map<String, dynamic>> deletarMarca(MarcaModel marca) async {
    Map params = {
      'id_marca': marca.idMarca,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_MARCA,
      params: params,
    );
  }
}
