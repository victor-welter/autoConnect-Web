import '../models/tipo_despesa/tipo_despesa_model.dart';

abstract class ITiposDespesas {
  Future<List<TipoDespesaModel>> buscarTiposDespesas(String where);

  Future<void> registrar(TipoDespesaModel tipoDespesa);
}