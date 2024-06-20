// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardState on _DashboardState, Store {
  Computed<ObservableList<DespesaModel>>? _$despesasComputed;

  @override
  ObservableList<DespesaModel> get despesas => (_$despesasComputed ??=
          Computed<ObservableList<DespesaModel>>(() => super.despesas,
              name: '_DashboardState.despesas'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_DashboardState.loading'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_DashboardState.hasError'))
          .value;
  Computed<bool>? _$finishLoadingComputed;

  @override
  bool get finishLoading =>
      (_$finishLoadingComputed ??= Computed<bool>(() => super.finishLoading,
              name: '_DashboardState.finishLoading'))
          .value;
  Computed<double>? _$totalDespesasComputed;

  @override
  double get totalDespesas =>
      (_$totalDespesasComputed ??= Computed<double>(() => super.totalDespesas,
              name: '_DashboardState.totalDespesas'))
          .value;
  Computed<double>? _$mediaDespesasComputed;

  @override
  double get mediaDespesas =>
      (_$mediaDespesasComputed ??= Computed<double>(() => super.mediaDespesas,
              name: '_DashboardState.mediaDespesas'))
          .value;
  Computed<double>? _$totalAbastecimentoComputed;

  @override
  double get totalAbastecimento => (_$totalAbastecimentoComputed ??=
          Computed<double>(() => super.totalAbastecimento,
              name: '_DashboardState.totalAbastecimento'))
      .value;
  Computed<double>? _$totalTrocaPneuComputed;

  @override
  double get totalTrocaPneu =>
      (_$totalTrocaPneuComputed ??= Computed<double>(() => super.totalTrocaPneu,
              name: '_DashboardState.totalTrocaPneu'))
          .value;
  Computed<double>? _$totalTrocaOleoComputed;

  @override
  double get totalTrocaOleo =>
      (_$totalTrocaOleoComputed ??= Computed<double>(() => super.totalTrocaOleo,
              name: '_DashboardState.totalTrocaOleo'))
          .value;
  Computed<double>? _$totalServicoComputed;

  @override
  double get totalServico =>
      (_$totalServicoComputed ??= Computed<double>(() => super.totalServico,
              name: '_DashboardState.totalServico'))
          .value;
  Computed<double>? _$totalManutencaoComputed;

  @override
  double get totalManutencao => (_$totalManutencaoComputed ??= Computed<double>(
          () => super.totalManutencao,
          name: '_DashboardState.totalManutencao'))
      .value;

  late final _$_despesasAtom =
      Atom(name: '_DashboardState._despesas', context: context);

  @override
  ObservableList<DespesaModel> get _despesas {
    _$_despesasAtom.reportRead();
    return super._despesas;
  }

  @override
  set _despesas(ObservableList<DespesaModel> value) {
    _$_despesasAtom.reportWrite(value, super._despesas, () {
      super._despesas = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_DashboardState._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$_hasErrorAtom =
      Atom(name: '_DashboardState._hasError', context: context);

  @override
  bool get _hasError {
    _$_hasErrorAtom.reportRead();
    return super._hasError;
  }

  @override
  set _hasError(bool value) {
    _$_hasErrorAtom.reportWrite(value, super._hasError, () {
      super._hasError = value;
    });
  }

  late final _$_finishLoadingAtom =
      Atom(name: '_DashboardState._finishLoading', context: context);

  @override
  bool get _finishLoading {
    _$_finishLoadingAtom.reportRead();
    return super._finishLoading;
  }

  @override
  set _finishLoading(bool value) {
    _$_finishLoadingAtom.reportWrite(value, super._finishLoading, () {
      super._finishLoading = value;
    });
  }

  late final _$_totalDespesasAtom =
      Atom(name: '_DashboardState._totalDespesas', context: context);

  @override
  double get _totalDespesas {
    _$_totalDespesasAtom.reportRead();
    return super._totalDespesas;
  }

  @override
  set _totalDespesas(double value) {
    _$_totalDespesasAtom.reportWrite(value, super._totalDespesas, () {
      super._totalDespesas = value;
    });
  }

  late final _$_mediaDespesasAtom =
      Atom(name: '_DashboardState._mediaDespesas', context: context);

  @override
  double get _mediaDespesas {
    _$_mediaDespesasAtom.reportRead();
    return super._mediaDespesas;
  }

  @override
  set _mediaDespesas(double value) {
    _$_mediaDespesasAtom.reportWrite(value, super._mediaDespesas, () {
      super._mediaDespesas = value;
    });
  }

  late final _$_totalAbastecimentoAtom =
      Atom(name: '_DashboardState._totalAbastecimento', context: context);

  @override
  double get _totalAbastecimento {
    _$_totalAbastecimentoAtom.reportRead();
    return super._totalAbastecimento;
  }

  @override
  set _totalAbastecimento(double value) {
    _$_totalAbastecimentoAtom.reportWrite(value, super._totalAbastecimento, () {
      super._totalAbastecimento = value;
    });
  }

  late final _$_totalTrocaPneuAtom =
      Atom(name: '_DashboardState._totalTrocaPneu', context: context);

  @override
  double get _totalTrocaPneu {
    _$_totalTrocaPneuAtom.reportRead();
    return super._totalTrocaPneu;
  }

  @override
  set _totalTrocaPneu(double value) {
    _$_totalTrocaPneuAtom.reportWrite(value, super._totalTrocaPneu, () {
      super._totalTrocaPneu = value;
    });
  }

  late final _$_totalTrocaOleoAtom =
      Atom(name: '_DashboardState._totalTrocaOleo', context: context);

  @override
  double get _totalTrocaOleo {
    _$_totalTrocaOleoAtom.reportRead();
    return super._totalTrocaOleo;
  }

  @override
  set _totalTrocaOleo(double value) {
    _$_totalTrocaOleoAtom.reportWrite(value, super._totalTrocaOleo, () {
      super._totalTrocaOleo = value;
    });
  }

  late final _$_totalServicoAtom =
      Atom(name: '_DashboardState._totalServico', context: context);

  @override
  double get _totalServico {
    _$_totalServicoAtom.reportRead();
    return super._totalServico;
  }

  @override
  set _totalServico(double value) {
    _$_totalServicoAtom.reportWrite(value, super._totalServico, () {
      super._totalServico = value;
    });
  }

  late final _$_totalManutencaoAtom =
      Atom(name: '_DashboardState._totalManutencao', context: context);

  @override
  double get _totalManutencao {
    _$_totalManutencaoAtom.reportRead();
    return super._totalManutencao;
  }

  @override
  set _totalManutencao(double value) {
    _$_totalManutencaoAtom.reportWrite(value, super._totalManutencao, () {
      super._totalManutencao = value;
    });
  }

  late final _$_DashboardStateActionController =
      ActionController(name: '_DashboardState', context: context);

  @override
  void addAllDespesas(List<DespesaModel> despesas) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.addAllDespesas');
    try {
      return super.addAllDespesas(despesas);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDespesa(DespesaModel despesa) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.addDespesa');
    try {
      return super.addDespesa(despesa);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeDespesa(DespesaModel despesa) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.removeDespesa');
    try {
      return super.removeDespesa(despesa);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDespesa(DespesaModel despesa, DespesaModel newDespesa) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.updateDespesa');
    try {
      return super.updateDespesa(despesa, newDespesa);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAplicativo(DespesaModel aplicativo) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.removeAplicativo');
    try {
      return super.removeAplicativo(aplicativo);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading({required bool value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinishLoading({required bool value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setFinishLoading');
    try {
      return super.setFinishLoading(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalDespesas({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalDespesas');
    try {
      return super.setTotalDespesas(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMediaDespesas({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setMediaDespesas');
    try {
      return super.setMediaDespesas(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalAbastecimento({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalAbastecimento');
    try {
      return super.setTotalAbastecimento(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalTrocaPneu({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalTrocaPneu');
    try {
      return super.setTotalTrocaPneu(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalTrocaOleo({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalTrocaOleo');
    try {
      return super.setTotalTrocaOleo(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalServico({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalServico');
    try {
      return super.setTotalServico(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalManutencao({required double value}) {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.setTotalManutencao');
    try {
      return super.setTotalManutencao(value: value);
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPage() {
    final _$actionInfo = _$_DashboardStateActionController.startAction(
        name: '_DashboardState.resetPage');
    try {
      return super.resetPage();
    } finally {
      _$_DashboardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
despesas: ${despesas},
loading: ${loading},
hasError: ${hasError},
finishLoading: ${finishLoading},
totalDespesas: ${totalDespesas},
mediaDespesas: ${mediaDespesas},
totalAbastecimento: ${totalAbastecimento},
totalTrocaPneu: ${totalTrocaPneu},
totalTrocaOleo: ${totalTrocaOleo},
totalServico: ${totalServico},
totalManutencao: ${totalManutencao}
    ''';
  }
}
