// ignore_for_file: unused_element

import 'package:mobx/mobx.dart';

import '../../configs/constants.dart';
import '../../utils/functions_utils.dart';
import '../local/local_model.dart';
import '../tipo-combustivel/tipo_combustivel_model.dart';
import '../tipo-despesa/tipo_despesa_model.dart';
import '../tipo-problema/tipo_problema_model.dart';
import '../veiculo/veiculo_model.dart';

part 'despesa_model.g.dart';

class DespesaModel = _DespesaModel with _$DespesaModel;

abstract class _DespesaModel with Store {
  _DespesaModel();

  _DespesaModel.fromMap(Map<String, dynamic> data) {
    idDespesa = data['id_despesa'];
    this.data = tryParseDate(data['data']);
    odometro = data['odometro'];
    precoUnitario = data['preco_unitario'];
    quantidade = data['quantidade'];
    precoTotal = data['preco_total'];
    descricao = data['descricao'];
    manutencaoPreventiva = data['manutencao_preventiva'];
    if (data['local'] != null) local = LocalModel.fromMap(data['local']);
    if (data['tipo_combustivel'] != null) tipoCombustivel = TipoCombustivelModel.fromMap(data['tipo_combustivel']);
    if (data['veiculo'] != null) veiculo = VeiculoModel.fromMap(data['veiculo']);
    if (data['tipo_despesa'] != null) tipoDespesa = TipoDespesaModel.fromMap(data['tipo_despesa']);
    if (data['tipo_problema'] != null) tipoProblema = TipoProblemaModel.fromMap(data['tipo_problema']);
  }

  int? idDespesa;
  DateTime? data;
  double? odometro;
  double? precoUnitario;
  double? quantidade;

  @observable
  double? precoTotal;
  
  LocalModel? local;
  TipoCombustivelModel? tipoCombustivel;
  VeiculoModel? veiculo;
  
  @observable
  int? manutencaoPreventiva = CadOptions.MANUTENCAO_PREVENTIVA;
  
  String? descricao;

  @observable
  TipoDespesaModel? tipoDespesa;

  TipoProblemaModel? tipoProblema;
}
