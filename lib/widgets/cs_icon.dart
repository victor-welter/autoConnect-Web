import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CsIcon extends StatelessWidget {
  const CsIcon({
    required this.icon,
    this.size = 24,
    this.color,
    super.key,
  });

  final dynamic icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (icon is String) {
      if (icon!.split('.').last.toLowerCase() == 'svg') {
        return SvgPicture.asset(
          icon!,
        width: size * 1.25,
        height: size * 1.25,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }

      return Image.asset(
        icon!,
        fit: BoxFit.scaleDown,
        width: size * 1.25,
        height: size * 1.25,
        color: color,
      );
    }

    return Icon(
      icon,
      size: size,
      color: color ?? theme.colorScheme.secondary,
    );
  }
}
