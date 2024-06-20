import 'package:mobx/mobx.dart';

import '../veiculo/veiculo_model.dart';

part 'filtro_despesa_model.g.dart';

class FiltroDespesaModel = _FiltroDespesaModel with _$FiltroDespesaModel;

abstract class _FiltroDespesaModel with Store {
  @observable
  DateTime _dataInicial = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @observable
  DateTime _dataFinal = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @observable
  VeiculoModel? _veiculo;

  @computed
  DateTime? get dataInicial => _dataInicial;

  @computed
  DateTime? get dataFinal => _dataFinal;

  @computed
  VeiculoModel? get veiculo => _veiculo;

  @action
  void setDataInicial(DateTime? dataInicial) {
    _dataInicial = dataInicial ?? DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  @action
  void setDataFinal(DateTime? dataFinal) {
    _dataFinal = dataFinal ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  @action
  void setVeiculo(VeiculoModel? veiculo) {
    _veiculo = veiculo;
  }
}
