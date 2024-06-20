import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CsRadioListTile<T> extends StatelessWidget {
  ///Retorna os [Widget] [Radio] para ser utilizado no aplicativo
  const CsRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.height = 50,
    this.toggleable = false,
    super.key,
  });

  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? title;
  final double? height;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();

          onChanged!(value!);

          if (toggleable) {
            if (value == groupValue) {
              onChanged!(null);
            }
          }
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: theme.colorScheme.onPrimary,
        focusColor: theme.colorScheme.onPrimary,
        hoverColor: theme.colorScheme.onPrimary,
        highlightColor: theme.colorScheme.onPrimary,
        child: Row(
          children: [
            Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Expanded(
              child: AutoSizeText(
                title!,
                maxLines: 1,
                maxFontSize: 15,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primaryContainer,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}