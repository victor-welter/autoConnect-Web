import '../models/marca/marca_model.dart';

abstract class IMarcas {
  Future<List<MarcaModel>> buscarMarcas(String where);

  Future<void> registrar(MarcaModel marca);

  Future<void> deletarMarca(MarcaModel marca);
}
