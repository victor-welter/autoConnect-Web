import '../../interfaces/imarcas.dart';
import '../../models/marca/marca_model.dart';
import '../../repository/marcas/marcas_repository.dart';
import '../../utils/request_utils.dart';

class MarcasController implements IMarcas {
  @override
  Future<List<MarcaModel>> buscarMarcas(String where) async {
    final response = await MarcaRepository.buscarMarcas(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => MarcaModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(MarcaModel marca) async {
    try {
      final response = await MarcaRepository.registrar(marca);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarMarca(MarcaModel marca) async {
    try {
      final response = await MarcaRepository.deletarMarca(marca);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}