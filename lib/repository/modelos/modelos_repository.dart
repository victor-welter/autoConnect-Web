import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/modelo/modelo_model.dart';
import '../../services/http_service.dart';

class ModeloRepository {
  static Future<Map<String, dynamic>> buscarModelos(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_MODELO,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(ModeloModel modelo) async {
    Map jsonData = {
      "descricao": modelo.descricao,
      "id_marca": modelo.marca?.idMarca,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_MODELO,
      body: jsonEncode(jsonData),
    );
  }
}
