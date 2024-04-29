import 'package:flutter/material.dart';

class ThemeApp {
  static final ligthTheme = ThemeData(
    primaryColor: const Color(0xFF071950),
    splashColor: const Color(0xFF071950),
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: Colors.white,
    cardColor: Colors.grey[100],
    fontFamily: 'WorkSan',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF071950),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.grey[300],
      onPrimary: Colors.grey[200],
      onSecondary: Colors.grey[50],
      primaryContainer: Colors.grey[600],
      secondary: const Color(0xFF071950),
      brightness: Brightness.light,
      surface: Colors.white,
      onSurface: Colors.grey,
      error: Colors.yellow[800],
      errorContainer: Colors.red,
      background: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
      color: Colors.grey[400],
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey[600],
      selectionColor: const Color(0xFF071950),
      selectionHandleColor: const Color(0xFF071950),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: textFieldBorder,
      errorBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      focusedBorder: textFieldBorder,
      disabledBorder: textFieldBorder,
      focusedErrorBorder: textFieldBorder,
      fillColor: Colors.grey.shade300,
      errorStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 16,
      ),
      hintStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF323232),
    ),
  );

  static const textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    borderSide: BorderSide.none,
  );

  static const textFieldBorderSecondary = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide.none,
  );

  static final labelMediumSecondary = TextStyle(
    color: Colors.grey[600],
    fontSize: 16,
  );

  static const errorStyleSecondary = TextStyle(
    color: Colors.red,
    fontSize: 14,
  );
}
