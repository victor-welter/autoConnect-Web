import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CsCircularProgressIndicador extends StatelessWidget {
  const CsCircularProgressIndicador({
    this.withMessage = false,
    this.message,
    this.color,
    this.margin,
    this.size = 35,
    super.key,
  });

  const CsCircularProgressIndicador.light({
    this.withMessage = false,
    this.message,
    this.margin,
    this.size = 30,
    super.key,
  }) : color = Colors.white;

  const CsCircularProgressIndicador.dark({
    this.withMessage = false,
    this.message,
    this.margin,
    this.size = 30,
    super.key,
  }) : color = null;

  final Color? color;
  final bool withMessage;
  final String? message;
  final EdgeInsetsGeometry? margin;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        margin: margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.beat(
              color: color?.withOpacity(0.8) ?? theme.colorScheme.secondary.withOpacity(0.8),
              size: size,
            ),
            if (withMessage) ...[
              const SizedBox(height: 20),
              Text(
                message ?? 'Carregando Dados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primaryContainer,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
