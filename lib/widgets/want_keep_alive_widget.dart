import 'package:flutter/material.dart';

class WantKeepAliveWidget extends StatefulWidget {
  final Widget child;
  const WantKeepAliveWidget({
    super.key,
    required this.child,
  });

  @override
  State<WantKeepAliveWidget> createState() => _WantKeepAliveWidgetState();
}

class _WantKeepAliveWidgetState extends State<WantKeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
