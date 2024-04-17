import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';

class CsAlertDialog extends StatelessWidget {
  const CsAlertDialog({
    required this.title,
    required this.description,
    this.actions,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      clipBehavior: Clip.none,
      // Dados obrigatórios
      content: Container(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.6,
          maxWidth: context.width * 0.6,
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
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions ?? const [],
                  ),
                ],
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
