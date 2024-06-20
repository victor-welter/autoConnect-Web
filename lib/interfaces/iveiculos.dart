import '../models/veiculo/veiculo_model.dart';

abstract class IVeiculos {
  Future<List<VeiculoModel>> buscarVeiculos(String where);

  Future<void> registrar(VeiculoModel veiculo);

  Future<void> deletarVeiculo(VeiculoModel veiculo);
}
