import 'package:go_router/go_router.dart';

import '../configs/constants.dart';
import '../configs/routes/local_routes.dart';
import '../models/erros/error_model.dart';
import '../models/sessao/sessao_model.dart';
import '../services/navigator_service.dart';
import '../services/secure_storage_service.dart';
import '../services/service_locator.dart';

///Obtém o token JWT que está salvo no SecureStorage e o retorna
Future<String> retornaJWT() async {
  final sessao = getIt<SessaoModel>();

  return await SecureStorageService.read(SharedKeys.SECURE_TOKEN, suffix: sessao.usuario) ?? '';
}

///Invalida o token JWT do usuário
Future<void> resetJWT() async {
  final sessao = getIt<SessaoModel>();

  await SecureStorageService.save(SharedKeys.SECURE_TOKEN, '', suffix: sessao.usuario);
}

void validaResponse(Map response, [ErrorModel? custom]) {
  if (!response['status']) {
    if (response['message'] == 'Usuário não encontrado e/ou inativo') {
      getIt<NavigationService>().navigatorKey.currentContext!.go(LocalRoutes.LOGIN);
      return;
    }

    if (response['message'] == 'Acesso negado') {
      getIt<NavigationService>().navigatorKey.currentContext!.go(LocalRoutes.HOME);
      return;
    }

    if (custom == null) {
      throw ErrorModel(response['message']);
    } else {
      throw custom;
    }
  }
}
