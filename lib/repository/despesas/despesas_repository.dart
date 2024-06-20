import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/despesa/despesa_model.dart';
import '../../models/filtro-despesa/filtro_despesa_model.dart';
import '../../models/sessao/sessao_model.dart';
import '../../services/http_service.dart';
import '../../services/service_locator.dart';
import '../../utils/functions_utils.dart';

class DespesaRepository {
  static Future<Map<String, dynamic>> buscarCategorias() async {
    Map params = {
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
      'id_veiculo': getIt<FiltroDespesaModel>().veiculo?.idVeiculo,
      'startDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial),
      'endDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal),
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_DESPESA,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> buscaTotalDespesas() async {
    Map params = {
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
      'id_veiculo': getIt<FiltroDespesaModel>().veiculo?.idVeiculo,
      'startDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial),
      'endDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal),
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TOTAL_DESPESAS,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> buscaMediaDespesas() async {
    Map params = {
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
      'id_veiculo': getIt<FiltroDespesaModel>().veiculo?.idVeiculo,
      'startDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial),
      'endDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal),
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_MEDIA_DESPESAS,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> buscaTotalDespesaPorTipo(int idTipoDespesa) async {
    Map params = {
      'id_tipo_despesa': idTipoDespesa,
      'usuario_cpf_cnpj': getIt<SessaoModel>().cpfCnpj,
      'id_veiculo': getIt<FiltroDespesaModel>().veiculo?.idVeiculo,
      'startDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataInicial),
      'endDate': uploadDateFormat(getIt<FiltroDespesaModel>().dataFinal),
    };

    return await HttpService.post(
      rota: WebRoutes.BUSCAR_TOTAL_DESPESA_POR_TIPO,
      params: params,
    );
  }

  static Future<Map<String, dynamic>> registrar(DespesaModel despesa) async {
    Map jsonData = {
      "data": uploadDateFormat(despesa.data),
      "odometro": despesa.odometro,
      "preco_unitario": despesa.precoUnitario,
      "quantidade": despesa.quantidade,
      "preco_total": despesa.precoTotal,
      "descricao": despesa.descricao,
      "manutencao_preventiva": despesa.manutencaoPreventiva,
      "id_veiculo": despesa.veiculo?.idVeiculo,
      "id_local": despesa.local?.idLocal,
      "id_tipo_despesa": despesa.tipoDespesa?.idTipoDespesa,
      "id_tipo_combustivel": despesa.tipoCombustivel?.idTipoCombustivel,
      "id_tipo_problema": despesa.tipoProblema?.idTipoProblema,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_DESPESA,
      body: jsonEncode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> deletarDespesa(DespesaModel despesa) async {
    Map params = {
      'id_despesa': despesa.idDespesa,
    };

    return await HttpService.post(
      rota: WebRoutes.DELETAR_DESPESA,
      params: params,
    );
  }
}
