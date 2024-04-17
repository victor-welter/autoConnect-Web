import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';

class CsAlertDialogContent extends StatelessWidget {
  ///Widget utilizado para exibir um [AlertDialog] com o seu conteúdo totalmente personalizado
  const CsAlertDialogContent({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      clipBehavior: Clip.none,
      // Dados obrigatórios
      content: Container(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.8,
          maxWidth: context.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),

      // Default
      elevation: 10,
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
