import 'package:flutter/material.dart';

class WKeepAlive extends StatefulWidget {
  const WKeepAlive({super.key, required this.child});

  final Widget child;

  @override
  State<WKeepAlive> createState() => _WKeepAliveState();
}

class _WKeepAliveState extends State<WKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}