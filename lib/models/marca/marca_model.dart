class MarcaModel {
  MarcaModel();
  
  MarcaModel.fromMap(Map<String, dynamic> data) {
    idMarca = data['id_marca'];
    descricao = data['descricao'];
  }

  int? idMarca;
  String? descricao;
}
