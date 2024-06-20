import '../../interfaces/itipos_combustiveis.dart';
import '../../models/tipo-combustivel/tipo_combustivel_model.dart';
import '../../repository/tipos-combustiveis/tipos_combustiveis_repository.dart';
import '../../utils/request_utils.dart';

class TiposCombustiveisController implements ITiposCombustiveis {
  @override
  Future<List<TipoCombustivelModel>> buscarTiposCombustiveis(String where) async {
    final response = await TipoCombustivelRepository.buscarTiposCombustiveis(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => TipoCombustivelModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(TipoCombustivelModel tiposCombustivel) async {
    try {
      final response = await TipoCombustivelRepository.registrar(tiposCombustivel);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarTipoCombustivel(TipoCombustivelModel tiposCombustivel) async {
    try {
      final response = await TipoCombustivelRepository.deletarTipoCombustivel(tiposCombustivel);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}