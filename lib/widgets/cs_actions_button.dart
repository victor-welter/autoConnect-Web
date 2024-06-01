import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CsActionsButton extends StatelessWidget {
  const CsActionsButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.color,
    this.height = 50,
    this.width,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const SizedBox(),
        clipBehavior: Clip.none,
        label: AutoSizeText(
          label.toUpperCase(),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? theme.colorScheme.primary.withOpacity(0.8)),
          overlayColor: MaterialStateProperty.all(color?.withOpacity(0.8) ?? theme.colorScheme.onPrimary),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}