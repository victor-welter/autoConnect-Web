import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../cs_icon.dart';

class CardErrorLogin extends StatelessWidget {
  const CardErrorLogin({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(0),
      color: theme.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CsIcon(
              icon: Icons.warning_amber_rounded,
              color: theme.colorScheme.errorContainer,
              size: 28,
            ),
            const SizedBox(width: 15),
            Flexible(
              child: AutoSizeText(
                message,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.secondary,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
