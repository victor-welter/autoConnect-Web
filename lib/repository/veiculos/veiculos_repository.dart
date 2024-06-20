import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/sessao/sessao_model.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../services/http_service.dart';
import '../../services/service_locator.dart';

class VeiculoRepository {
  static Future<Map<String, dynamic>> buscarVeiculos(String where) async {
    Map params = {
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
      'where': where,
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_VEICULO,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(VeiculoModel veiculo) async {
    Map jsonData = {
      "ano": veiculo.ano,
      "placa": veiculo.placa,
      "usuario_cpf_cnpj": getIt<SessaoModel>().cpfCnpj,
      "id_marca": veiculo.marca?.idMarca,
      "id_modelo": veiculo.modelo?.idModelo,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_VEICULO,
      body: jsonEncode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> deletarVeiculo(VeiculoModel veiculo) async {
    Map params = {
      'id_veiculo': veiculo.idVeiculo,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_VEICULO,
      params: params,
    );
  }
}
