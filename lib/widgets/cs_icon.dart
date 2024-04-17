import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CsIcon extends StatelessWidget {
  const CsIcon.icon({
    required this.icon,
    this.size = 24,
    this.color,
    super.key,
  }) : assetsPath = null;

  const CsIcon.assets({
    required this.assetsPath,
    this.size = 30,
    this.color,
    super.key,
  }) : icon = null;

  final String? assetsPath;
  final IconData? icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (assetsPath != null) {
      if (assetsPath!.split('.').last.toLowerCase() == 'svg') {
        return SvgPicture.asset(
          assetsPath!,
          width: size,
          height: size,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }

      return Image.asset(
        assetsPath!,
        fit: BoxFit.scaleDown,
        width: size,
        height: size,
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
