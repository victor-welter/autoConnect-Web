// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../configs/theme/theme_app.dart';
import '../utils/functions_utils.dart';

class CsTextFormField extends StatelessWidget {
  ///[TextFormField] utilizados no aplicativo
  CsTextFormField({
    required this.hintText,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.forceDisable = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.focus,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.label,
    this.obrigatorio = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.filled = true,
    this.fillColor,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autofillHints,
    super.key,
  }) : secondary = false;

  ///[TextFormField] secondary utilizados no aplicativo
  CsTextFormField.secondary({
    required this.hintText,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.forceDisable = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.focus,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.label,
    this.obrigatorio = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.always,
    this.filled = true,
    this.fillColor,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autofillHints,
    super.key,
  }) : secondary = true;

  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final TextEditingController? controller;
  final bool enabled;
  final bool forceDisable;
  final bool autocorrect;
  final bool autofocus;
  final bool enableSuggestions;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final String? label;
  final bool obrigatorio;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final AutovalidateMode autovalidateMode;
  final bool filled;
  final Color? fillColor;
  final bool secondary;
  final VoidCallback? onTap;
  final void Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  void Function(String)? onFieldSubmitted;
  final List<String>? autofillHints;

  EdgeInsets _definePadding() {
    const double defaultPadding = 15;
    const double padding = 40;

    if (suffixIcon != null && prefixIcon != null) {
      return const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: defaultPadding,
      );
    }

    if (suffixIcon != null) {
      return const EdgeInsets.all(defaultPadding).copyWith(right: padding);
    }

    if (prefixIcon != null) {
      return const EdgeInsets.all(defaultPadding).copyWith(left: padding);
    }

    return const EdgeInsets.all(defaultPadding);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isNullOrEmpty(label)) ...[
            _Label(
              label: label ?? '',
              obrigatorio: obrigatorio,
              secondary: secondary,
            ),
            const SizedBox(height: 5),
          ],
          Stack(
            children: [
              //Utilizado apenas para validação de campos desabilitados
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  enabled: forceDisable ? false : !enabled,
                  validator: (_) => validator != null
                      ? enabled
                          ? null
                          : validator!(controller?.text ?? '')
                      : null,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  autovalidateMode: autovalidateMode,
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: '',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: _definePadding(),
                    errorStyle: secondary ? ThemeApp.errorStyleSecondary : theme.inputDecorationTheme.errorStyle,
                  ),
                ),
              ),

              TextFormField(
                //Campos obrigatórios
                onChanged: onChanged,
                validator: enabled ? validator : null,
                controller: controller,

                //Campos opcionais
                enabled: enabled,
                autocorrect: autocorrect,
                autofocus: autofocus,
                enableSuggestions: enableSuggestions,
                obscureText: obscureText,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                focusNode: focus,
                textCapitalization: textCapitalization,
                maxLength: maxLength,
                maxLines: maxLines,
                scrollPhysics: const BouncingScrollPhysics(),
                textInputAction: textInputAction,
                autovalidateMode: autovalidateMode,
                onSaved: onSaved,
                onEditingComplete: onEditingComplete,
                onFieldSubmitted: onFieldSubmitted,
                cursorColor: secondary ? theme.colorScheme.primaryContainer : theme.colorScheme.primary,
                autofillHints: autofillHints,
                decoration: InputDecoration(
                  filled: filled,
                  fillColor: secondary ? theme.colorScheme.primary : Colors.white.withOpacity(0.5),
                  counterText: '',
                  alignLabelWithHint: true,
                  label: null,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: hintText,
                  errorText: errorText,
                  labelStyle: theme.inputDecorationTheme.labelStyle,
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                  errorStyle: secondary ? ThemeApp.errorStyleSecondary : theme.inputDecorationTheme.errorStyle,
                  border: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  enabledBorder: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  errorBorder: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  focusedErrorBorder: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  focusedBorder: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  disabledBorder: secondary ? ThemeApp.textFieldBorderSecondary : ThemeApp.textFieldBorder,
                  contentPadding: _definePadding(),
                  enabled: enabled,
                ),
                style: secondary ? ThemeApp.labelMediumSecondary : theme.textTheme.labelMedium,
              ),

              ///Define a posição do ícone que será exibida no [TextField], se possuir
              if (prefixIcon != null) ...[
                Positioned(
                  top: 5,
                  left: 5,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: prefixIcon!,
                  ),
                ),
              ],

              ///Define a posição do ícone que será exibida no [TextField], se possuir
              if (suffixIcon != null) ...[
                Positioned(
                  top: 5,
                  right: 5,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: suffixIcon!,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
    required this.obrigatorio,
    required this.secondary,
  });

  final String label;
  final bool obrigatorio;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: secondary ? 15 : 25),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondary ? Colors.grey[600] : Colors.white,
                fontSize: 15,
              ),
            ),
            if (obrigatorio) ...[
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
