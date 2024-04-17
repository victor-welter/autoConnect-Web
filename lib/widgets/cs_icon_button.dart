import 'package:flutter/material.dart';

import '../services/service_locator.dart';
import '../utils/functions_utils.dart';

class CsIconButton extends StatelessWidget {
  CsIconButton.light({
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size,
    this.constraints,
    this.badge,
    this.hideBadgeZero = false,
    super.key,
  }) : splashColor = Theme.of(getIt<BuildContext>()).colorScheme.onPrimary;

  CsIconButton.dark({
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size,
    this.constraints,
    this.badge,
    this.hideBadgeZero = false,
    super.key,
  }) : splashColor = Theme.of(getIt<BuildContext>()).colorScheme.secondary;

  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  final double? size;
  final Color splashColor;
  final BoxConstraints? constraints;
  final String? badge;
  final bool hideBadgeZero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String? badge = this.badge;

    if (hideBadgeZero) {
      if (badge == '0') {
        badge = null;
      }
    }

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: splashColor.withOpacity(0.3),
          focusColor: splashColor.withOpacity(0.3),
          hoverColor: splashColor.withOpacity(0.3),
          highlightColor: splashColor.withOpacity(0.3),
          icon: icon,
          alignment: Alignment.center,
          tooltip: tooltip,
          padding: const EdgeInsets.all(0),
          constraints: constraints,
          iconSize: size,
        ),

        // Badge
        if (!isNullOrEmpty(badge)) ...[
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(3),
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                badge!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
