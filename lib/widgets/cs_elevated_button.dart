import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CsElevatedButton extends StatelessWidget {
  const CsElevatedButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final double height;
  final double width;
  final Color? backgroundColor;

  Color? _borderColor() {
    if (onPressed == null) {
      return Colors.grey[400];
    }

    if (backgroundColor != null) {
      return backgroundColor!;
    }

    return null;
  }

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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((_) {
            if (onPressed == null) {
              return theme.colorScheme.primary.withOpacity(0.6);
            }

            return theme.primaryColor;
          }),
          overlayColor: MaterialStateProperty.all(theme.colorScheme.secondary),
          textStyle: MaterialStateProperty.all(const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
            fontSize: 16,
          )),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: _borderColor() ?? theme.colorScheme.secondary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
