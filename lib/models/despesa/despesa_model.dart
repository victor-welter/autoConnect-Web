import '../local/local_model.dart';
import '../tipo_despesa/tipo_despesa_model.dart';

class DespesaModel {
  DespesaModel();

  int? idDespesa;
  DateTime? data;
  String? odometro;
  TipoDespesaModel? tipoDespesa;
  LocalModel? local;
}
