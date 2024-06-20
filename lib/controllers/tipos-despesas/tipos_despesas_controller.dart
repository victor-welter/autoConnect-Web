import '../../interfaces/itipos_despesas.dart';
import '../../models/tipo-despesa/tipo_despesa_model.dart';
import '../../repository/tipos-despesas/tipos_despesas_repository.dart';
import '../../utils/request_utils.dart';

class TiposDespesasController implements ITiposDespesas {
  @override
  Future<List<TipoDespesaModel>> buscarTiposDespesas(String where) async {
    final response = await TipoDespesaRepository.buscarTiposDespesas(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => TipoDespesaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(TipoDespesaModel tipoDespesa) async {
    try {
      final response = await TipoDespesaRepository.registrar(tipoDespesa);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarTipoDespesa(TipoDespesaModel tipoDespesa) async {
    try {
      final response = await TipoDespesaRepository.deletarTipoDespesa(tipoDespesa);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}