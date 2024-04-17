import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'configs/constants.dart';
import 'configs/theme/theme_app.dart';
import 'router_app.dart';
import 'services/service_locator.dart';
import 'widgets/no_glow_effect.dart';

final routeObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  LicenseRegistry.addLicense(() async* {
    final kleeOneLicence = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], kleeOneLicence);
  });

  // ErrorWidget.builder = (errorDetails) {
  //   return const RotaErrorWidgetView();
  // };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: App.NAME,
      themeMode: ThemeMode.light,
      theme: ThemeApp.ligthTheme,
      color: Colors.white,
      builder: (context, child) {
        if (!getIt.isRegistered<BuildContext>()) {
          getIt.registerSingleton<BuildContext>(context);
        }

        return ScrollConfiguration(
          behavior: const NoGlowEffect(),
          child: child!,
        );
      },
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      routerConfig: RouterApp.routes,
    );
  }
}
