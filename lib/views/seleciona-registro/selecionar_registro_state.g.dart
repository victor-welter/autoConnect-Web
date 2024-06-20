// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selecionar_registro_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelecionarRegistroState on _SelecionarRegistroState, Store {
  Computed<List<dynamic>>? _$registrosComputed;

  @override
  List<dynamic> get registros =>
      (_$registrosComputed ??= Computed<List<dynamic>>(() => super.registros,
              name: '_SelecionarRegistroState.registros'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_SelecionarRegistroState.loading'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_SelecionarRegistroState.hasError'))
          .value;
  Computed<bool>? _$hasInternetComputed;

  @override
  bool get hasInternet =>
      (_$hasInternetComputed ??= Computed<bool>(() => super.hasInternet,
              name: '_SelecionarRegistroState.hasInternet'))
          .value;
  Computed<String?>? _$whereComputed;

  @override
  String? get where => (_$whereComputed ??= Computed<String?>(() => super.where,
          name: '_SelecionarRegistroState.where'))
      .value;

  late final _$_registrosAtom =
      Atom(name: '_SelecionarRegistroState._registros', context: context);

  @override
  ObservableList<dynamic> get _registros {
    _$_registrosAtom.reportRead();
    return super._registros;
  }

  @override
  set _registros(ObservableList<dynamic> value) {
    _$_registrosAtom.reportWrite(value, super._registros, () {
      super._registros = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_SelecionarRegistroState._loading', context: context);

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
      Atom(name: '_SelecionarRegistroState._hasError', context: context);

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

  late final _$_hasInternetAtom =
      Atom(name: '_SelecionarRegistroState._hasInternet', context: context);

  @override
  bool get _hasInternet {
    _$_hasInternetAtom.reportRead();
    return super._hasInternet;
  }

  @override
  set _hasInternet(bool value) {
    _$_hasInternetAtom.reportWrite(value, super._hasInternet, () {
      super._hasInternet = value;
    });
  }

  late final _$_whereAtom =
      Atom(name: '_SelecionarRegistroState._where', context: context);

  @override
  String? get _where {
    _$_whereAtom.reportRead();
    return super._where;
  }

  @override
  set _where(String? value) {
    _$_whereAtom.reportWrite(value, super._where, () {
      super._where = value;
    });
  }

  late final _$_SelecionarRegistroStateActionController =
      ActionController(name: '_SelecionarRegistroState', context: context);

  @override
  void addRegistros(List<dynamic> registros) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.addRegistros');
    try {
      return super.addRegistros(registros);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRegistro(dynamic registro) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.addRegistro');
    try {
      return super.addRegistro(registro);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeRegistro(dynamic registro) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.removeRegistro');
    try {
      return super.removeRegistro(registro);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading({required bool value}) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasInternet({required bool value}) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.setHasInternet');
    try {
      return super.setHasInternet(value: value);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWhere({required String? where}) {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.setWhere');
    try {
      return super.setWhere(where: where);
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetWhere() {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.resetWhere');
    try {
      return super.resetWhere();
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onFilter() {
    final _$actionInfo = _$_SelecionarRegistroStateActionController.startAction(
        name: '_SelecionarRegistroState.onFilter');
    try {
      return super.onFilter();
    } finally {
      _$_SelecionarRegistroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
registros: ${registros},
loading: ${loading},
hasError: ${hasError},
hasInternet: ${hasInternet},
where: ${where}
    ''';
  }
}
