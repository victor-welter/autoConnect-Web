import '../../interfaces/iveiculos.dart';
import '../../models/veiculo/veiculo_model.dart';
import '../../repository/veiculos/veiculos_repository.dart';
import '../../utils/request_utils.dart';

class VeiculosController implements IVeiculos {
  @override
  Future<List<VeiculoModel>> buscarVeiculos(String where) async {
    final response = await VeiculoRepository.buscarVeiculos(where);

    validaResponse(response);

    List data = response['data'];

    return data.map((e) => VeiculoModel.fromMap(e)).toList();
  }

  @override
  Future<void> registrar(VeiculoModel veiculo) async {
    try {
      final response = await VeiculoRepository.registrar(veiculo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletarVeiculo(VeiculoModel veiculo) async {
    try {
      final response = await VeiculoRepository.deletarVeiculo(veiculo);

      validaResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}