import '../../interfaces/idespesas.dart';
import '../../models/despesa/despesa_model.dart';
import '../../repository/despesas/despesas_repository.dart';
import '../../utils/request_utils.dart';

class DespesasController implements IDespesas {
  @override
  Future<List<DespesaModel>> buscarDespesas() async {
    final response = await DespesaRepository.buscarCategorias();

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => DespesaModel.fromMap(e)).toList();
  }

  @override
  Future<double> buscaMediaDespesas() async {
    final response = await DespesaRepository.buscaMediaDespesas();

    validaResponse(response);

    return response['data'];
  }

  @override
  Future<double> buscaTotalDespesas() async {
    final response = await DespesaRepository.buscaTotalDespesas();

    validaResponse(response);

    return response['data'];
  }

  @override
  Future<double> buscaTotalDespesaPorTipo(int idTipoDespesa) async {
    final response = await DespesaRepository.buscaTotalDespesaPorTipo(idTipoDespesa);

    validaResponse(response);

    return response['data'];
  }

  @override
  Future<void> registrar(DespesaModel despesa) async {
    try {
      final response = await DespesaRepository.registrar(despesa);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarDespesa(DespesaModel despesa) async {
    try {
      final response = await DespesaRepository.deletarDespesa(despesa);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
