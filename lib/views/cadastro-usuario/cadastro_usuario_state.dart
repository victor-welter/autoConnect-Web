// ignore_for_file: prefer_final_fields

import 'package:easy_mask/easy_mask.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_usuario_state.g.dart';

class CadastroUsuarioState = _CadastroUsuarioState with _$CadastroUsuarioState;

abstract class _CadastroUsuarioState with Store {
  @observable
  bool _obscurePassword = true;

  @observable
  bool _obscureConfirmPassword = true;

  @observable
  bool _saveIn = false;

  @observable
  bool _isDone = false;

  @observable
  bool _hasError = false;

  @observable
  TextInputMask _mask = TextInputMask(mask: '999.999.999-99');

  @observable
  bool _houveAlteracoes = false;

  //Computed
  @computed
  bool get obscurePassword => _obscurePassword;

  @computed
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  @computed
  bool get saveIn => _saveIn;

  @computed
  bool get isDone => _isDone;

  @computed
  bool get hasError => _hasError;

  @computed
  TextInputMask get mask => _mask;

  @computed
  bool get houveAlteracoes => _houveAlteracoes;

  //Action
  @action
  void changeObscurePassword() {
    _obscurePassword = !_obscurePassword;
  }

  @action
  void changeObscureConfirmPassword() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
  }

  @action
  Future setSaveIn({required bool value}) async {
    if (!value) {
      _isDone = true;
      await Future.delayed(const Duration(seconds: 1));
    }

    _saveIn = value;

    if (value) {
      _isDone = false;
      _hasError = false;
    }
  }

  @action
  void setHasError({required bool value}) {
    _hasError = value;
  }

  @action
  void setMask(String value) {
    if (value.length <= 11) {
      _mask.magicMask.buildMaskTokens('999.999.999-99');
    } else {
      _mask.magicMask.buildMaskTokens('99.999.999/9999-99');
    }
  }

  @action
  void setHouveAlteracoes({bool? value}) {
    _houveAlteracoes = value ?? true;
  }
}
