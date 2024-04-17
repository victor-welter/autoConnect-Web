import 'package:flutter/material.dart';

class FadeWidget extends StatefulWidget {
  const FadeWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<FadeWidget> createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }
}
