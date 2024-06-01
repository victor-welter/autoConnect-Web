// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:easy_mask/easy_mask.dart';
import 'package:mobx/mobx.dart';

part 'login_state.g.dart';

class LoginState = _LoginState with _$LoginState;

abstract class _LoginState with Store {
  @observable
  bool _obscurePassword = true;

  @observable
  bool _loggingIn = false;

  @observable
  String _errorMessage = '';

  @observable
  TextInputMask _mask = TextInputMask(mask: '999.999.999-99');

  @computed
  bool get obscurePassword => _obscurePassword;

  @computed
  bool get loggingIn => _loggingIn;

  @computed
  String get errorMessage => _errorMessage;

  @computed
  TextInputMask get mask => _mask;

  @action
  void changeObscurePassword() {
    _obscurePassword = !_obscurePassword;
  }

  @action
  void setLogginIn({required bool value}) {
    _loggingIn = value;

    if (value) {
      _errorMessage = '';
    }
  }

  @action
  void setErrorMessage(String message) {
    _errorMessage = message;
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
  void resetState() {
    _obscurePassword = true;
    _loggingIn = false;
    _errorMessage = '';
  }
}
