import '../marca/marca_model.dart';

class ModeloModel {
  ModeloModel();
  
  ModeloModel.fromMap(Map<String, dynamic> data) {
    idModelo = data['id_modelo'];
    descricao = data['descricao'];
    marca = MarcaModel.fromMap(data);
  }

  int? idModelo;
  String? descricao;
  MarcaModel? marca;
}