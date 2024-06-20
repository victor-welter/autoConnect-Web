import '../models/modelo/modelo_model.dart';

abstract class IModelos {
  Future<List<ModeloModel>> buscarModelos(String where);

  Future<void> registrar(ModeloModel modelo);

  Future<void> deletarModelo(ModeloModel modelo);
}
