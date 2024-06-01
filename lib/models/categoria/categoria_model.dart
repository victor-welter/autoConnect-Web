class CategoriaModel {
  CategoriaModel();

  CategoriaModel.fromMap(Map<String, dynamic> data) {
    idCategoria = data['id_categoria'];
    descricao = data['descricao'];
  }

  int? idCategoria;
  String? descricao;
}