// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_alert_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ErrorAlertModel on _ErrorAlertModel, Store {
  Computed<List<LancamentoErrorModel>>? _$errorsComputed;

  @override
  List<LancamentoErrorModel> get errors => (_$errorsComputed ??=
          Computed<List<LancamentoErrorModel>>(() => super.errors,
              name: '_ErrorAlertModel.errors'))
      .value;
  Computed<List<LancamentoErrorModel>>? _$alertsComputed;

  @override
  List<LancamentoErrorModel> get alerts => (_$alertsComputed ??=
          Computed<List<LancamentoErrorModel>>(() => super.alerts,
              name: '_ErrorAlertModel.alerts'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ErrorAlertModel.hasError'))
          .value;
  Computed<bool>? _$hasAlertComputed;

  @override
  bool get hasAlert =>
      (_$hasAlertComputed ??= Computed<bool>(() => super.hasAlert,
              name: '_ErrorAlertModel.hasAlert'))
          .value;

  late final _$_errorsAtom =
      Atom(name: '_ErrorAlertModel._errors', context: context);

  @override
  ObservableList<LancamentoErrorModel> get _errors {
    _$_errorsAtom.reportRead();
    return super._errors;
  }

  @override
  set _errors(ObservableList<LancamentoErrorModel> value) {
    _$_errorsAtom.reportWrite(value, super._errors, () {
      super._errors = value;
    });
  }

  late final _$_alertsAtom =
      Atom(name: '_ErrorAlertModel._alerts', context: context);

  @override
  ObservableList<LancamentoErrorModel> get _alerts {
    _$_alertsAtom.reportRead();
    return super._alerts;
  }

  @override
  set _alerts(ObservableList<LancamentoErrorModel> value) {
    _$_alertsAtom.reportWrite(value, super._alerts, () {
      super._alerts = value;
    });
  }

  late final _$_ErrorAlertModelActionController =
      ActionController(name: '_ErrorAlertModel', context: context);

  @override
  void removeError(List<int> codigos) {
    final _$actionInfo = _$_ErrorAlertModelActionController.startAction(
        name: '_ErrorAlertModel.removeError');
    try {
      return super.removeError(codigos);
    } finally {
      _$_ErrorAlertModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addError(String message, int codigo,
      {VoidCallback? callback, int? page}) {
    final _$actionInfo = _$_ErrorAlertModelActionController.startAction(
        name: '_ErrorAlertModel.addError');
    try {
      return super.addError(message, codigo, callback: callback, page: page);
    } finally {
      _$_ErrorAlertModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAlert(List<int> codigos) {
    final _$actionInfo = _$_ErrorAlertModelActionController.startAction(
        name: '_ErrorAlertModel.removeAlert');
    try {
      return super.removeAlert(codigos);
    } finally {
      _$_ErrorAlertModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAlert(String message, int codigo,
      {VoidCallback? callback, int? page}) {
    final _$actionInfo = _$_ErrorAlertModelActionController.startAction(
        name: '_ErrorAlertModel.addAlert');
    try {
      return super.addAlert(message, codigo, callback: callback, page: page);
    } finally {
      _$_ErrorAlertModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errors: ${errors},
alerts: ${alerts},
hasError: ${hasError},
hasAlert: ${hasAlert}
    ''';
  }
}
