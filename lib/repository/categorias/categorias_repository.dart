import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/categoria/categoria_model.dart';
import '../../services/http_service.dart';

class CategoriaRepository {
  static Future<Map<String, dynamic>> buscarCategorias(String where) async {
    Map params = {
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_CATEGORIAS,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(CategoriaModel categoria) async {
    Map jsonData = {
      'descricao': categoria.descricao,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_CATEGORIA,
      body: jsonEncode(jsonData),
    );
  }
}
