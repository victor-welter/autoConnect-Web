// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessao_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SessaoModel on _SessaoModel, Store {
  Computed<List<int>>? _$permissoesComputed;

  @override
  List<int> get permissoes =>
      (_$permissoesComputed ??= Computed<List<int>>(() => super.permissoes,
              name: '_SessaoModel.permissoes'))
          .value;

  late final _$_permissoesAtom =
      Atom(name: '_SessaoModel._permissoes', context: context);

  @override
  ObservableList<int> get _permissoes {
    _$_permissoesAtom.reportRead();
    return super._permissoes;
  }

  @override
  set _permissoes(ObservableList<int> value) {
    _$_permissoesAtom.reportWrite(value, super._permissoes, () {
      super._permissoes = value;
    });
  }

  late final _$_SessaoModelActionController =
      ActionController(name: '_SessaoModel', context: context);

  @override
  void setPermissoes(List<int> permissoes) {
    final _$actionInfo = _$_SessaoModelActionController.startAction(
        name: '_SessaoModel.setPermissoes');
    try {
      return super.setPermissoes(permissoes);
    } finally {
      _$_SessaoModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
permissoes: ${permissoes}
    ''';
  }
}
