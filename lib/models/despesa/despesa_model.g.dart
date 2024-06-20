// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despesa_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DespesaModel on _DespesaModel, Store {
  late final _$precoTotalAtom =
      Atom(name: '_DespesaModel.precoTotal', context: context);

  @override
  double? get precoTotal {
    _$precoTotalAtom.reportRead();
    return super.precoTotal;
  }

  @override
  set precoTotal(double? value) {
    _$precoTotalAtom.reportWrite(value, super.precoTotal, () {
      super.precoTotal = value;
    });
  }

  late final _$manutencaoPreventivaAtom =
      Atom(name: '_DespesaModel.manutencaoPreventiva', context: context);

  @override
  int? get manutencaoPreventiva {
    _$manutencaoPreventivaAtom.reportRead();
    return super.manutencaoPreventiva;
  }

  @override
  set manutencaoPreventiva(int? value) {
    _$manutencaoPreventivaAtom.reportWrite(value, super.manutencaoPreventiva,
        () {
      super.manutencaoPreventiva = value;
    });
  }

  late final _$tipoDespesaAtom =
      Atom(name: '_DespesaModel.tipoDespesa', context: context);

  @override
  TipoDespesaModel? get tipoDespesa {
    _$tipoDespesaAtom.reportRead();
    return super.tipoDespesa;
  }

  @override
  set tipoDespesa(TipoDespesaModel? value) {
    _$tipoDespesaAtom.reportWrite(value, super.tipoDespesa, () {
      super.tipoDespesa = value;
    });
  }

  @override
  String toString() {
    return '''
precoTotal: ${precoTotal},
manutencaoPreventiva: ${manutencaoPreventiva},
tipoDespesa: ${tipoDespesa}
    ''';
  }
}
