import '../../interfaces/itipos_problemas.dart';
import '../../models/tipo-problema/tipo_problema_model.dart';
import '../../repository/tipos-problemas/tipos_problemas_repository.dart';
import '../../utils/request_utils.dart';

class TiposProblemasController implements ITiposProblemas {
  @override
  Future<List<TipoProblemaModel>> buscarTiposProblemas(String where) async {
    final response = await TipoProblemaRepository.buscarTiposProblemas(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => TipoProblemaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(TipoProblemaModel tipoProblema) async {
    try {
      final response = await TipoProblemaRepository.registrar(tipoProblema);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarTipoProblema(TipoProblemaModel tipoProblema) async {
    try {
      final response = await TipoProblemaRepository.deletarTipoProblema(tipoProblema);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}