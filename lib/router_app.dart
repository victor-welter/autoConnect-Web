import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'configs/assets/assets_path.dart';
import 'configs/routes/local_routes.dart';
import 'services/navigator_service.dart';
import 'services/service_locator.dart';
import 'views/home-screen/home_screen_view.dart';
import 'views/login/login_view.dart';
import 'widgets/cs_icon.dart';
import 'widgets/cs_sliver_app_bar.dart';
import 'widgets/nenhuma_informacao.dart';

class RouterApp {
  static final GoRouter routes = GoRouter(
    initialLocation: LocalRoutes.HOME,
    redirect: _redirect,
    errorBuilder: (context, state) {
      return const _RotaInexistenteView();
    },
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: _RotaInexistenteView(),
      );
    },
    navigatorKey: getIt<NavigationService>().navigatorKey,
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
    ],
  );

  static Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    // try {
    //   final data = await SecureStorageService.read(SharedKeys.DADOS_USER) ?? '';

    //   if (data.isNotEmpty) {
    //     final sessao = SessaoModel.fromDatabase(jsonDecode(data));

    //     if (!getIt.isRegistered<SessaoModel>()) {
    //       getIt.registerSingleton<SessaoModel>(sessao);
    //     }

    //     await LoginController().autenticado();
    //     await LoginController().buscaPermissoes();

    //     return state.subloc;
    //   }
    // } catch (_) {}

    return LocalRoutes.LOGIN;
  }
}

class _RotaInexistenteView extends StatelessWidget {
  const _RotaInexistenteView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CsSliverAppBar(
        icon: CsIcon.icon(
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
