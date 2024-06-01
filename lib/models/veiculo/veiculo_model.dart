import '../marca/marca_model.dart';
import '../modelo/modelo_model.dart';

class VeiculoModel {
  VeiculoModel();

  VeiculoModel.fromMap(Map<String, dynamic> data) {
    idVeiculo = data['id_veiculo'];
    ano = data['ano'];
    placa = data['placa'];
    marca = MarcaModel.fromMap(data['marca']);
    modelo = ModeloModel.fromMap(data['modelo']);
  }

  int? idVeiculo;
  String? ano;
  String? placa;
  MarcaModel? marca;
  ModeloModel? modelo;
}
