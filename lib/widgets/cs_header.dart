import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'cs_icon.dart';

class CsHeader extends StatelessWidget {
  const CsHeader({
    required this.title,
    required this.icon,
    super.key,
  })  : secondary = false,
        third = false;

  const CsHeader.secondary({
    required this.title,
    required this.icon,
    super.key,
  })  : secondary = true,
        third = false;

  const CsHeader.third({
    required this.title,
    required this.icon,
    super.key,
  })  : secondary = false,
        third = true;

  final String title;
  final dynamic icon;
  final bool secondary;
  final bool third;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (secondary) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                CsIcon(
                  icon: icon,
                  color: theme.colorScheme.onSurface,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$title',
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              height: 0,
              thickness: 1,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
      );
    }

    if (third) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                CsIcon(
                  icon: icon,
                  color: theme.colorScheme.secondary,
                  size: 40,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AutoSizeText(
                    title,
                    maxLines: 2,
                    maxFontSize: 20,
                    style: TextStyle(
                      fontSize: 20,
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              height: 0,
              thickness: 1,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 2,
      color: theme.scaffoldBackgroundColor,
      margin: const EdgeInsets.all(0).copyWith(bottom: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CsIcon(
              icon: icon,
              color: theme.colorScheme.secondary,
              size: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 20,
                  color: theme.colorScheme.primaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
