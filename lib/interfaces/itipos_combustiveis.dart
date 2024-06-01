import '../models/tipo_combustivel/tipo_combustivel_model.dart';

abstract class ITiposCombustiveis {
  Future<List<TipoCombustivelModel>> buscarTiposCombustiveis(String where);

  Future<void> registrar(TipoCombustivelModel tipoCombustivel);
}
