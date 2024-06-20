class TipoProblemaModel {
  TipoProblemaModel();

  TipoProblemaModel.fromMap(Map<String, dynamic> map) {
    idTipoProblema = map['id_tipo_problema'];
    descricao = map['descricao'];
  }

  int? idTipoProblema;
  String? descricao;
}