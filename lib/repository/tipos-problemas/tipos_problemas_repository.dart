import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/tipo-problema/tipo_problema_model.dart';
import '../../services/http_service.dart';

class TipoProblemaRepository {
  static Future<Map<String, dynamic>> buscarTiposProblemas(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TIPO_PROBLEMA,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(TipoProblemaModel tipoProblema) async {
    Map jsonData = {
      "descricao": tipoProblema.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_TIPO_PROBLEMA,
      body: jsonEncode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> deletarTipoProblema(TipoProblemaModel tipoProblema) async {
    Map params = {
      'id_tipo_problema': tipoProblema.idTipoProblema,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_TIPO_PROBLEMA,
      params: params,
    );
  }
}
