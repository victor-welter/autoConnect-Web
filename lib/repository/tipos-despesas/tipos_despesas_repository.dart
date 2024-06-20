import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../services/http_service.dart';

class TipoDespesaRepository {
  static Future<Map<String, dynamic>> buscarTiposDespesas(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TIPO_DESPESA,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(TipoDespesaModel tipoDespesa) async {
    Map jsonData = {
      "descricao": tipoDespesa.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_TIPO_DESPESA,
      body: jsonEncode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> deletarTipoDespesa(TipoDespesaModel tipoDespesa) async {
    Map params = {
      'id_tipo_despesa': tipoDespesa.idTipoDespesa,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_TIPO_DESPESA,
      params: params,
    );
  }
}
