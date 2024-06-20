import '../../interfaces/imodelos.dart';
import '../../models/modelo/modelo_model.dart';
import '../../repository/modelos/modelos_repository.dart';
import '../../utils/request_utils.dart';

class ModelosController implements IModelos {
  @override
  Future<List<ModeloModel>> buscarModelos(String where) async {
    final response = await ModeloRepository.buscarModelos(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => ModeloModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(ModeloModel modelo) async {
    try {
      final response = await ModeloRepository.registrar(modelo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarModelo(ModeloModel modelo) async {
    try {
      final response = await ModeloRepository.deletarModelo(modelo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}