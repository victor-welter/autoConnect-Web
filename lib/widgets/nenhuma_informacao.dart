import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/context_ext.dart';

class NenhumaInformacao extends StatelessWidget {
  /// Recebe uma `message` e uma `imagePath` e exibe de forma centralizada na tela
  ///
  /// Utilizada para exibir avisos ao usuário
  const NenhumaInformacao({
    required this.message,
    this.imagePath,
    this.actions,
    this.width,
    this.height,
    super.key,
  });

  final String message;
  final String? imagePath;
  final List<Widget>? actions;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null) ...[
                SvgPicture.asset(
                  '$imagePath',
                  fit: BoxFit.fill,
                  width: width ?? context.width * 0.4,
                  height: height ?? context.height * 0.4,
                ),
                const SizedBox(height: 15),
              ],
              Text(
                '$message',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primaryContainer,
                  fontSize: 18,
                ),
              ),
              if (actions != null) ...[
                const SizedBox(height: 20),
                Column(children: actions!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
