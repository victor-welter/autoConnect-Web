// ignore_for_file: prefer_final_fields

import 'package:mobx/mobx.dart';

part 'selecionar_registro_state.g.dart';

class SelecionarRegistroState = _SelecionarRegistroState with _$SelecionarRegistroState;

abstract class _SelecionarRegistroState with Store {
  @observable
  ObservableList<dynamic> _registros = ObservableList();

  @observable
  bool _loading = false;

  @observable
  bool _hasError = false;

  @observable
  bool _hasInternet = true;

  int _page = 0;

  bool _finishLoading = false;

  @observable
  String? _where;

  @computed
  List<dynamic> get registros => [..._registros];

  @computed
  bool get loading => _loading;

  @computed
  bool get hasError => _hasError;

  int get page => _page;

  bool get finishLoading => _finishLoading;

  @computed
  bool get hasInternet => _hasInternet;

  @computed
  String? get where => _where;

  @action
  void addRegistros(List<dynamic> registros) {
    _registros.addAll(registros);
  }

  @action
  void addRegistro(dynamic registro) {
    _registros.add(registro);
  }

  @action
  void removeRegistro(dynamic registro) {
    _registros.remove(registro);
  }

  @action
  void setLoading({required bool value}) {
    _loading = value;

    if (value) {
      _hasError = false;
      _hasInternet = true;
    }
  }

  @action
  void setHasError({required bool value}) {
    _hasError = value;
  }

  @action
  void setHasInternet({required bool value}) {
    _hasInternet = value;
  }

  void setPage(int page) {
    _page = page;
  }

  void incPage() {
    _page++;
  }

  void setFinishLoading({required bool value}) {
    _finishLoading = value;
  }

  @action
  void setWhere({required String? where}) {
    _where = where;
  }

  @action
  void resetWhere() {
    _where = null;
  }

  @action
  void onFilter() {
    _registros.clear();
    _loading = false;
    _hasError = false;
    _page = 0;
    _finishLoading = false;
  }
}
