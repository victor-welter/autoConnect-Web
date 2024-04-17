// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../configs/enums.dart';

part 'error_alert_model.g.dart';

class ErrorAlertModel = _ErrorAlertModel with _$ErrorAlertModel;

abstract class _ErrorAlertModel with Store {
  @observable
  ObservableList<LancamentoErrorModel> _errors = ObservableList();

  @observable
  ObservableList<LancamentoErrorModel> _alerts = ObservableList();

  @computed
  List<LancamentoErrorModel> get errors => [..._errors];

  @computed
  List<LancamentoErrorModel> get alerts => [..._alerts];

  @computed
  bool get hasError => _errors.isNotEmpty;

  @computed
  bool get hasAlert => _alerts.isNotEmpty;

  ///Remove todos os erros pelo código
  @action
  void removeError(List<int> codigos) {
    Future.delayed(Duration.zero, () {
      _errors.removeWhere((e) => codigos.contains(e.codigo));
    });
  }

  ///Recebe como parâmetros uma mensagem a ser exibida ao usuário, um código de indentificação única do erro e uma função de callback, caso necessário
  @action
  void addError(
    String message,
    int codigo, {
    VoidCallback? callback,
    int? page,
  }) {
    Future.delayed(Duration.zero, () {
      if (!_errors.map((e) => e.codigo).toList().contains(codigo)) {
        _errors.add(LancamentoErrorModel.error(message, codigo, callback, page));
      }
    });
  }

  ///Remove todos os erros pelo código
  @action
  void removeAlert(List<int> codigos) {
    Future.delayed(Duration.zero, () {
      _alerts.removeWhere((e) => codigos.contains(e.codigo));
    });
  }

  ///Recebe como parâmetros uma mensagem a ser exibida ao usuário, um código de indentificação única do erro e uma função de callback, caso necessário
  @action
  void addAlert(
    String message,
    int codigo, {
    VoidCallback? callback,
    int? page,
  }) {
    Future.delayed(Duration.zero, () {
      if (!_alerts.map((e) => e.codigo).toList().contains(codigo)) {
        _alerts.add(LancamentoErrorModel.alert(message, codigo, callback, page));
      }
    });
  }
}

///Erros que são exibidos ao final do atendimento individual e ficha de procedimentos conforme campos obrigatórios que estão em falta
class LancamentoErrorModel {
  LancamentoErrorModel.error(
    this.message,
    this.codigo, [
    this.callback,
    this.page,
  ]) : type = LancamentoErrorType.error;

  LancamentoErrorModel.alert(
    this.message,
    this.codigo, [
    this.callback,
    this.page,
  ]) : type = LancamentoErrorType.alert;

  final String message;
  final int codigo;
  final VoidCallback? callback;
  final LancamentoErrorType type;
  final int? page;
}
