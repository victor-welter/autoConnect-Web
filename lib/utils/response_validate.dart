// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart' show DioError, Response;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../configs/routes/local_routes.dart';
import '../configs/routes/web_routes.dart';
import '../models/erros/error_model.dart';
import '../services/dialog_service.dart';
import '../services/service_locator.dart';

class ResponseValidate {
  ///Valida requisições com status code 200
  static void validate({required Response resp}) {
    int statusCode = resp.statusCode ?? 0;

    if (resp.statusCode == 200) {
      return;
    }

    if (statusCode >= 500) {
      throw ErrorModel.http('O servidor está temporariamente fora do ar. Por favor, contate o suporte!');
    }

    //Deixar por último
    //Tratamento genérico
    if ((statusCode >= 0 && statusCode < 200) || statusCode >= 400) {
      throw ErrorModel.http('Ocorreu um erro desconhecido ao efetuar a sua requisição. Por favor, contate o suporte!');
    }
  }

  ///Valida requisições que retornar um status code diferente de 200
  static void validateDioError({
    required DioError error,
    required String? rota,
  }) {
    if (error.message!.contains('401')) {
      showSnackbar(description: 'A sua sessão expirou. Faça login novamente!');
      GoRouter.of(getIt<BuildContext>()).go(LocalRoutes.LOGIN);
      throw ErrorModel.session();
    }

    if (error.message!.contains('404')) {
      if (rota == WebRoutes.LOGIN) {
        throw ErrorModel.login('O munícipio selecionado está inválido. Por favor, contate o suporte!');
      }

      throw ErrorModel.http('A operação solicitada não existe. Por favor, contate o suporte!');
    } else if (error.message!.contains('429')) {
      throw ErrorModel.http('Muitas requisições foram efetuadas nos últimos minutos. Por favor, aguarde e tente novamente mais tarde!');
    } else if (error.message!.contains('502') || error.message!.contains('500')) {
      throw ErrorModel.http('O servidor está temporariamente fora do ar. Por favor, contate o suporte!');
    } else if (error.message!.contains('SocketException') || error.message!.contains('HttpException')) {
      throw ErrorModel.http('A conexão com a internet foi perdida. Verifique o seu WI-FI ou dados móveis para continuar!');
    } else {
      throw ErrorModel.http('Não foi possível prosseguir com a solicitação. Por favor, contate o suporte!');
    }
  }
}
