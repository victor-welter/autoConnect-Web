// ignore_for_file: prefer_final_fields

import 'package:mobx/mobx.dart';

import '../../models/despesa/despesa_model.dart';

part 'home_screen_state.g.dart';

class HomeScreenState = _HomeScreenStateBase with _$HomeScreenState;

abstract class _HomeScreenStateBase with Store {
  @observable
  ObservableList<DespesaModel> _despesas = ObservableList();

  @observable
  bool _loading = false;

  @observable
  bool _hasError = false;

  int _page = 0;

  @observable
  bool _finishLoading = false;

  @observable
  double _totalAbastecimento = 0;

  @observable
  double _totalTrocaPneu = 0;

  @observable
  double _totalTrocaOleo = 0;

  @observable
  double _totalServico = 0;

  @observable
  double _totalManutencao = 0;

  @computed
  ObservableList<DespesaModel> get despesas => _despesas;

  @computed
  bool get loading => _loading;

  @computed
  bool get hasError => _hasError;

  int get page => _page;

  @computed
  bool get finishLoading => _finishLoading;

  @computed
  double get totalAbastecimento => _totalAbastecimento;

  @computed
  double get totalTrocaPneu => _totalTrocaPneu;

  @computed
  double get totalTrocaOleo => _totalTrocaOleo;

  @computed
  double get totalServico => _totalServico;

  @computed
  double get totalManutencao => _totalManutencao;

  @action
  void addDespesa(DespesaModel despesa) {
    _despesas.add(despesa);
  }

  @action
  void addAllDespesas(List<DespesaModel> despesas) {
    _despesas.addAll(despesas);
  }

  @action
  void updateDespesa(DespesaModel despesa, DespesaModel newDespesa) {
    _despesas.remove(despesa);
    _despesas.add(newDespesa);
  }

  @action
  void removeAplicativo(DespesaModel aplicativo) {
    _despesas.remove(aplicativo);
  }

  @action
  void setLoading({required bool value}) {
    if (!value) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _loading = value;
      });
    } else {
      _loading = value;
    }

    if (value) {
      _hasError = false;
    }
  }

  @action
  void setHasError({required bool value}) {
    _hasError = value;
  }

  void setPage({required int value}) {
    _page = value;
  }

  void incPage() {
    _page++;
  }

  @action
  void setFinishLoading({required bool value}) {
    _finishLoading = value;
  }

  @action
  void setTotalAbastecimento({required double value}) {
    _totalAbastecimento = value;
  }

  @action
  void setTotalTrocaPneu({required double value}) {
    _totalTrocaPneu = value;
  }

  @action
  void setTotalTrocaOleo({required double value}) {
    _totalTrocaOleo = value;
  }

  @action
  void setTotalServico({required double value}) {
    _totalServico = value;
  }

  @action
  void setTotalManutencao({required double value}) {
    _totalManutencao = value;
  }

  @action
  void resetPage() {
    _despesas.clear();
    _loading = false;
    _hasError = false;
    _page = 0;
    _finishLoading = false;
  }
}
