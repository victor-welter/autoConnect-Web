import 'package:flutter/material.dart';

import '../utils/functions_utils.dart';

class CsIncolumnInfo extends StatelessWidget {
  const CsIncolumnInfo({
    required this.icon,
    required this.label,
    this.info,
    this.color,
    this.marginVertical,
    this.marginHorizontal,
    this.fontSize = 15,
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
          SizedBox(width: marginHorizontal ?? 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color ?? theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
                if (!isNullOrEmpty(info)) ...[
                  const SizedBox(height: 2),
                  Text(
                    info!,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: color ?? theme.primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}