import '../marca/marca_model.dart';
import '../modelo/modelo_model.dart';

class VeiculoModel {
  VeiculoModel();

  VeiculoModel.fromMap(Map<String, dynamic> data) {
    idVeiculo = data['id_veiculo'];
    ano = data['ano'];
    placa = data['placa'];
    odometro = data['odometro'];
    if(data['marca'] != null) marca = MarcaModel.fromMap(data['marca']);
    if(data['modelo'] != null) modelo = ModeloModel.fromMap(data['modelo']);
  }

  int? idVeiculo;
  String? ano;
  String? placa;
  double? odometro;
  MarcaModel? marca;
  ModeloModel? modelo;
}
