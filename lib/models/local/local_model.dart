import '../categoria/categoria_model.dart';

class LocalModel {
  LocalModel();

  LocalModel.fromMap(Map<String, dynamic> data) {
    idLocal = data['id_local'];
    nome = data['nome'];
    endereco = data['endereco'];
    categoria = CategoriaModel.fromMap(data);
  }

  int? idLocal;
  String? nome;
  String? endereco;
  CategoriaModel? categoria;
}