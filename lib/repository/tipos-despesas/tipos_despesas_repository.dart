import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/tipo_despesa/tipo_despesa_model.dart';
import '../../services/http_service.dart';

class TipoDespesaRepository {
  static Future<Map<String, dynamic>> buscarTiposDespesas(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TIPO_COMBUSTIVEL,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(TipoDespesaModel tipoDespesa) async {
    Map jsonData = {
      "descricao": tipoDespesa.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_TIPO_COMBUSTIVEL,
      body: jsonEncode(jsonData),
    );
  }
}