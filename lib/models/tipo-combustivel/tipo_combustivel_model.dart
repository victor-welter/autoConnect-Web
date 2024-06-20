class TipoCombustivelModel {
  TipoCombustivelModel();

  TipoCombustivelModel.fromMap(Map<String, dynamic> map) {
    idTipoCombustivel = map['id_tipo_combustivel'];
    descricao = map['descricao'];
  }

  int? idTipoCombustivel;
  String? descricao;
}