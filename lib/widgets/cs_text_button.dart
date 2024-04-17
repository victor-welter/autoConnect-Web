import 'package:flutter/material.dart';

class CsTextButton extends StatelessWidget {
  ///Cria um Text Button totalmente customizado para ser utilizado no aplicativo
  const CsTextButton({
    required this.label,
    this.onTap,
    this.color,
    this.fontSize = 15,
    Key? key,
  }) : super(key: key);

  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      splashColor: theme.colorScheme.onPrimary.withOpacity(0.4),
      focusColor: theme.colorScheme.onPrimary.withOpacity(0.4),
      hoverColor: theme.colorScheme.onPrimary.withOpacity(0.4),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: fontSize,
            color: color ?? theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
