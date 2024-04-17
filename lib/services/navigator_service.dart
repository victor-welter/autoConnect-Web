import 'package:flutter/material.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> showModal({
    required Widget child,
  }) async {
    return await navigatorKey.currentState!.push(
      PageRouteBuilder(
        barrierDismissible: true,
        opaque: false,
        fullscreenDialog: true,
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) {
          return child;
        },
      ),
    );
  }
}
