import 'package:flutter/material.dart';

import '../../configs/assets/assets_path.dart';
import '../../widgets/nenhuma_informacao.dart';

class RotaErrorWidgetView extends StatelessWidget {
  const RotaErrorWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: NenhumaInformacao(
            imagePath: AssetsPath.ERROR_UNKNOWN,
            message: 'Desculpe, ocorreu um problema desconhecido. Ajude nossa equipe de desenvolvimento relatando o problema abrindo um chamado no botão abaixo!',
          ),
        ),
      ),
    );
  }
}
