// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_usuario_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroUsuarioState on _CadastroUsuarioState, Store {
  Computed<bool>? _$obscurePasswordComputed;

  @override
  bool get obscurePassword =>
      (_$obscurePasswordComputed ??= Computed<bool>(() => super.obscurePassword,
              name: '_CadastroUsuarioState.obscurePassword'))
          .value;
  Computed<bool>? _$obscureConfirmPasswordComputed;

  @override
  bool get obscureConfirmPassword => (_$obscureConfirmPasswordComputed ??=
          Computed<bool>(() => super.obscureConfirmPassword,
              name: '_CadastroUsuarioState.obscureConfirmPassword'))
      .value;
  Computed<bool>? _$saveInComputed;

  @override
  bool get saveIn => (_$saveInComputed ??= Computed<bool>(() => super.saveIn,
          name: '_CadastroUsuarioState.saveIn'))
      .value;
  Computed<bool>? _$isDoneComputed;

  @override
  bool get isDone => (_$isDoneComputed ??= Computed<bool>(() => super.isDone,
          name: '_CadastroUsuarioState.isDone'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_CadastroUsuarioState.hasError'))
          .value;
  Computed<TextInputMask>? _$maskComputed;

  @override
  TextInputMask get mask =>
      (_$maskComputed ??= Computed<TextInputMask>(() => super.mask,
              name: '_CadastroUsuarioState.mask'))
          .value;
  Computed<bool>? _$houveAlteracoesComputed;

  @override
  bool get houveAlteracoes =>
      (_$houveAlteracoesComputed ??= Computed<bool>(() => super.houveAlteracoes,
              name: '_CadastroUsuarioState.houveAlteracoes'))
          .value;

  late final _$_obscurePasswordAtom =
      Atom(name: '_CadastroUsuarioState._obscurePassword', context: context);

  @override
  bool get _obscurePassword {
    _$_obscurePasswordAtom.reportRead();
    return super._obscurePassword;
  }

  @override
  set _obscurePassword(bool value) {
    _$_obscurePasswordAtom.reportWrite(value, super._obscurePassword, () {
      super._obscurePassword = value;
    });
  }

  late final _$_obscureConfirmPasswordAtom = Atom(
      name: '_CadastroUsuarioState._obscureConfirmPassword', context: context);

  @override
  bool get _obscureConfirmPassword {
    _$_obscureConfirmPasswordAtom.reportRead();
    return super._obscureConfirmPassword;
  }

  @override
  set _obscureConfirmPassword(bool value) {
    _$_obscureConfirmPasswordAtom
        .reportWrite(value, super._obscureConfirmPassword, () {
      super._obscureConfirmPassword = value;
    });
  }

  late final _$_saveInAtom =
      Atom(name: '_CadastroUsuarioState._saveIn', context: context);

  @override
  bool get _saveIn {
    _$_saveInAtom.reportRead();
    return super._saveIn;
  }

  @override
  set _saveIn(bool value) {
    _$_saveInAtom.reportWrite(value, super._saveIn, () {
      super._saveIn = value;
    });
  }

  late final _$_isDoneAtom =
      Atom(name: '_CadastroUsuarioState._isDone', context: context);

  @override
  bool get _isDone {
    _$_isDoneAtom.reportRead();
    return super._isDone;
  }

  @override
  set _isDone(bool value) {
    _$_isDoneAtom.reportWrite(value, super._isDone, () {
      super._isDone = value;
    });
  }

  late final _$_hasErrorAtom =
      Atom(name: '_CadastroUsuarioState._hasError', context: context);

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

  late final _$_maskAtom =
      Atom(name: '_CadastroUsuarioState._mask', context: context);

  @override
  TextInputMask get _mask {
    _$_maskAtom.reportRead();
    return super._mask;
  }

  @override
  set _mask(TextInputMask value) {
    _$_maskAtom.reportWrite(value, super._mask, () {
      super._mask = value;
    });
  }

  late final _$_houveAlteracoesAtom =
      Atom(name: '_CadastroUsuarioState._houveAlteracoes', context: context);

  @override
  bool get _houveAlteracoes {
    _$_houveAlteracoesAtom.reportRead();
    return super._houveAlteracoes;
  }

  @override
  set _houveAlteracoes(bool value) {
    _$_houveAlteracoesAtom.reportWrite(value, super._houveAlteracoes, () {
      super._houveAlteracoes = value;
    });
  }

  late final _$setSaveInAsyncAction =
      AsyncAction('_CadastroUsuarioState.setSaveIn', context: context);

  @override
  Future<dynamic> setSaveIn({required bool value}) {
    return _$setSaveInAsyncAction.run(() => super.setSaveIn(value: value));
  }

  late final _$_CadastroUsuarioStateActionController =
      ActionController(name: '_CadastroUsuarioState', context: context);

  @override
  void changeObscurePassword() {
    final _$actionInfo = _$_CadastroUsuarioStateActionController.startAction(
        name: '_CadastroUsuarioState.changeObscurePassword');
    try {
      return super.changeObscurePassword();
    } finally {
      _$_CadastroUsuarioStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeObscureConfirmPassword() {
    final _$actionInfo = _$_CadastroUsuarioStateActionController.startAction(
        name: '_CadastroUsuarioState.changeObscureConfirmPassword');
    try {
      return super.changeObscureConfirmPassword();
    } finally {
      _$_CadastroUsuarioStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_CadastroUsuarioStateActionController.startAction(
        name: '_CadastroUsuarioState.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_CadastroUsuarioStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMask(String value) {
    final _$actionInfo = _$_CadastroUsuarioStateActionController.startAction(
        name: '_CadastroUsuarioState.setMask');
    try {
      return super.setMask(value);
    } finally {
      _$_CadastroUsuarioStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHouveAlteracoes({bool? value}) {
    final _$actionInfo = _$_CadastroUsuarioStateActionController.startAction(
        name: '_CadastroUsuarioState.setHouveAlteracoes');
    try {
      return super.setHouveAlteracoes(value: value);
    } finally {
      _$_CadastroUsuarioStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscurePassword: ${obscurePassword},
obscureConfirmPassword: ${obscureConfirmPassword},
saveIn: ${saveIn},
isDone: ${isDone},
hasError: ${hasError},
mask: ${mask},
houveAlteracoes: ${houveAlteracoes}
    ''';
  }
}
