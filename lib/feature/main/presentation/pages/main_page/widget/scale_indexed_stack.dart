

import 'package:flutter/material.dart';

class ScaleIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const ScaleIndexedStack({
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  _ScaleIndexedStackState createState() => _ScaleIndexedStackState();
}

class _ScaleIndexedStackState extends State<ScaleIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // scale animatsiya 0.8 → 1.0
    _animation = Tween<double>(
      begin: 0.988,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ScaleIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: IndexedStack(index: widget.index, children: widget.children),
    );
  }
}
