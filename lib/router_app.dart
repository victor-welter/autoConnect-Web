import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'configs/assets/assets_path.dart';
import 'configs/constants.dart';
import 'configs/enums.dart';
import 'configs/routes/local_routes.dart';
import 'models/sessao/sessao_model.dart';
import 'services/navigator_service.dart';
import 'services/secure_storage_service.dart';
import 'services/service_locator.dart';
import 'views/cadastro-usuario/cadastro_usuario_view.dart';
import 'views/dashboard/dashboard_view.dart';
import 'views/home-screen/home_screen_view.dart';
import 'views/login/login_view.dart';
import 'views/seleciona-registro/seleciona_registro_view.dart';
import 'widgets/cs_icon.dart';
import 'widgets/cs_sliver_app_bar.dart';
import 'widgets/nenhuma_informacao.dart';

class RouterApp {
  static final routes = GoRouter(
    initialLocation: LocalRoutes.HOME,
    redirect: _redirect,
    navigatorKey: getIt<NavigationService>().navigatorKey,
    errorBuilder: (context, state) => const _RotaInexistenteView(),
    errorPageBuilder: (context, state) => const MaterialPage(
      child: _RotaInexistenteView(),
    ),
    routes: <GoRoute>[
      // Login
      GoRoute(
        path: LocalRoutes.LOGIN,
        builder: (context, state) => const LoginView(),
      ),

      // Home
      GoRoute(
        path: LocalRoutes.HOME,
        builder: (context, state) => const HomeScreenView(),
      ),

      // Cadastro de Usuário
      GoRoute(
        path: LocalRoutes.CADASTRO_USUARIO,
        builder: (context, state) => const CadastroUsuarioView(),
      ),

      // Seleciona Registro
      GoRoute(
        path: LocalRoutes.SELECIONA_REGISTRO,
        builder: (context, state) {
          final extra = state.extra as Map?;

          if (extra == null) {
            return const HomeScreenView();
          }

          return SelecionaRegistroView(
            title: extra['title'] as String,
            textEmpty: extra['textEmpty'] as String,
            dataType: extra['dataType'] as SelectDataType,
            hasFilter: extra['hasFilter'] as bool? ?? true,
            hasAdd: extra['hasAdd'] as bool? ?? true,
            extra: extra['extra'] as dynamic,
          );
        },
      ),

      // Dashboard
      GoRoute(
        path: LocalRoutes.DASHBOARD,
        builder: (context, state) => const DashboardView(),
      ),
    ],
  );

  static Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    try {
      final data = await SecureStorageService.read(SharedKeys.DADOS_USER) ?? '';

      if (data.isNotEmpty || RoutesOptions.LIVRE_ACESSO.contains(state.subloc)) {
        if (!RoutesOptions.LIVRE_ACESSO.contains(state.subloc)) {
          final sessao = SessaoModel.fromMap(jsonDecode(data));

          if (!getIt.isRegistered<SessaoModel>()) {
            getIt.registerSingleton<SessaoModel>(sessao);
          }
        }

        return state.subloc;
      }
    } catch (_) {}

    return LocalRoutes.LOGIN;
  }
}

class _RotaInexistenteView extends StatelessWidget {
  const _RotaInexistenteView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CsSliverAppBar(
        icon: CsIcon(
          icon: Icons.warning_amber_rounded,
          color: Colors.white,
          size: 100,
        ),
        title: 'Ops! Ocorreu um erro',
        body: Center(
          child: SingleChildScrollView(
            child: NenhumaInformacao(
              imagePath: AssetsPath.ERROR_404,
              message: 'Desculpe, a página que você está procurando não foi encontrada. Relate o seu problema abrindo um chamado no botão abaixo!',
            ),
          ),
        ),
      ),
    );
  }
}
