import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/tipo_combustivel/tipo_combustivel_model.dart';
import '../../services/http_service.dart';

class TipoCombustivelRepository {
  static Future<Map<String, dynamic>> buscarTiposCombustiveis(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TIPO_COMBUSTIVEL,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(TipoCombustivelModel tipoCombustivel) async {
    Map jsonData = {
      "descricao": tipoCombustivel.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_TIPO_COMBUSTIVEL,
      body: jsonEncode(jsonData),
    );
  }
}