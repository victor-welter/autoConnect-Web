import '../models/local/local_model.dart';

abstract class ILocais {
  Future<List<LocalModel>> buscarLocais(String where);

  Future<void> registrar(LocalModel local);

  Future<void> deletarLocal(LocalModel local);
}
