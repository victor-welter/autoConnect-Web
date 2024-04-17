import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class ErrorModel implements Exception {
  ErrorModel(this.descricao, {this.callback}) : type = ErrorType.generic;

  ErrorModel.login(this.descricao, {this.callback}) : type = ErrorType.login;

  ErrorModel.cadastro(this.descricao, {this.callback}) : type = ErrorType.cadastro;

  ErrorModel.http(this.descricao, {this.callback}) : type = ErrorType.http_request;

  ErrorModel.session({this.descricao, this.callback}) : type = ErrorType.session;

  ErrorModel.expiredSession({this.descricao, this.callback}) : type = ErrorType.expiredToken;

  ErrorModel.type(this.descricao, this.type, {this.callback});

  final String? descricao;
  final ErrorType type;
  final VoidCallback? callback;
}
