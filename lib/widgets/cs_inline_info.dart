import 'package:flutter/material.dart';

import '../utils/functions_utils.dart';

class CsInlineInfo extends StatelessWidget {
  const CsInlineInfo({
    required this.icon,
    required this.label,
    this.info,
    this.color,
    this.marginVertical,
    this.marginHorizontal,
    this.fontSize = 16,
    super.key,
  });

  final Widget icon;
  final String label;
  final String? info;
  final Color? color;
  final double? marginVertical;
  final double? marginHorizontal;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertical ?? 0, horizontal: marginHorizontal ?? 0),
      child: Row(
        children: [
          icon,
          SizedBox(width: marginHorizontal ?? 5),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color ?? theme.primaryColor,
              fontSize: fontSize,
            ),
          ),
          if (!isNullOrEmpty(info)) ...[
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                info!,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: color ?? theme.primaryColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}