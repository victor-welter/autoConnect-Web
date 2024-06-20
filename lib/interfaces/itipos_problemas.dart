
import '../models/tipo-problema/tipo_problema_model.dart';

abstract class ITiposProblemas {
  Future<List<TipoProblemaModel>> buscarTiposProblemas(String where);

  Future<void> registrar(TipoProblemaModel tipoProblema); 

  Future<void> deletarTipoProblema(TipoProblemaModel tipoProblema);
}