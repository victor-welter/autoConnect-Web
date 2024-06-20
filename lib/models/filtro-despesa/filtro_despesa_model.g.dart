// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtro_despesa_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FiltroDespesaModel on _FiltroDespesaModel, Store {
  Computed<DateTime?>? _$dataInicialComputed;

  @override
  DateTime? get dataInicial =>
      (_$dataInicialComputed ??= Computed<DateTime?>(() => super.dataInicial,
              name: '_FiltroDespesaModel.dataInicial'))
          .value;
  Computed<DateTime?>? _$dataFinalComputed;

  @override
  DateTime? get dataFinal =>
      (_$dataFinalComputed ??= Computed<DateTime?>(() => super.dataFinal,
              name: '_FiltroDespesaModel.dataFinal'))
          .value;
  Computed<VeiculoModel?>? _$veiculoComputed;

  @override
  VeiculoModel? get veiculo =>
      (_$veiculoComputed ??= Computed<VeiculoModel?>(() => super.veiculo,
              name: '_FiltroDespesaModel.veiculo'))
          .value;

  late final _$_dataInicialAtom =
      Atom(name: '_FiltroDespesaModel._dataInicial', context: context);

  @override
  DateTime get _dataInicial {
    _$_dataInicialAtom.reportRead();
    return super._dataInicial;
  }

  @override
  set _dataInicial(DateTime value) {
    _$_dataInicialAtom.reportWrite(value, super._dataInicial, () {
      super._dataInicial = value;
    });
  }

  late final _$_dataFinalAtom =
      Atom(name: '_FiltroDespesaModel._dataFinal', context: context);

  @override
  DateTime get _dataFinal {
    _$_dataFinalAtom.reportRead();
    return super._dataFinal;
  }

  @override
  set _dataFinal(DateTime value) {
    _$_dataFinalAtom.reportWrite(value, super._dataFinal, () {
      super._dataFinal = value;
    });
  }

  late final _$_veiculoAtom =
      Atom(name: '_FiltroDespesaModel._veiculo', context: context);

  @override
  VeiculoModel? get _veiculo {
    _$_veiculoAtom.reportRead();
    return super._veiculo;
  }

  @override
  set _veiculo(VeiculoModel? value) {
    _$_veiculoAtom.reportWrite(value, super._veiculo, () {
      super._veiculo = value;
    });
  }

  late final _$_FiltroDespesaModelActionController =
      ActionController(name: '_FiltroDespesaModel', context: context);

  @override
  void setDataInicial(DateTime? dataInicial) {
    final _$actionInfo = _$_FiltroDespesaModelActionController.startAction(
        name: '_FiltroDespesaModel.setDataInicial');
    try {
      return super.setDataInicial(dataInicial);
    } finally {
      _$_FiltroDespesaModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataFinal(DateTime? dataFinal) {
    final _$actionInfo = _$_FiltroDespesaModelActionController.startAction(
        name: '_FiltroDespesaModel.setDataFinal');
    try {
      return super.setDataFinal(dataFinal);
    } finally {
      _$_FiltroDespesaModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVeiculo(VeiculoModel? veiculo) {
    final _$actionInfo = _$_FiltroDespesaModelActionController.startAction(
        name: '_FiltroDespesaModel.setVeiculo');
    try {
      return super.setVeiculo(veiculo);
    } finally {
      _$_FiltroDespesaModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataInicial: ${dataInicial},
dataFinal: ${dataFinal},
veiculo: ${veiculo}
    ''';
  }
}
