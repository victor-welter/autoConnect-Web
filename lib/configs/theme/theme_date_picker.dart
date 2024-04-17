import 'package:flutter/material.dart';

class ThemeDatePicker extends StatelessWidget {
  /// Utilizado para mudar o layout default do [DatePicker]
  const ThemeDatePicker({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        primaryColor: theme.primaryColor,
        colorScheme: ColorScheme.light(
          // Header background color
          primary: theme.primaryColor,
          // Header text color
          onPrimary: theme.scaffoldBackgroundColor,
          // Body text color
          onSurface: theme.colorScheme.primaryContainer,
        ),

        // Card border theme
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: child,
    );
  }
}
