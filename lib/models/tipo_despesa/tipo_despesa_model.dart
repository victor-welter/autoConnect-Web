class TipoDespesaModel {
  TipoDespesaModel();

  TipoDespesaModel.fromMap(Map<String, dynamic> map) {
    idTipoDespesa = map['id_tipo_despesa'];
    descricao = map['descricao'];
  }

  int? idTipoDespesa;
  String? descricao;
}