import '../models/despesa/despesa_model.dart';

abstract class IDespesas {
  Future<List<DespesaModel>> buscarDespesas();

  Future<double> buscaTotalDespesas();
  
  Future<double> buscaMediaDespesas();

  Future<double> buscaTotalDespesaPorTipo(int idTipoDespesa);

  Future<void> registrar(DespesaModel despesa);

  Future<void> deletarDespesa(DespesaModel despesa);
}
