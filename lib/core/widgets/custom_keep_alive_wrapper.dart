import 'package:flutter/material.dart';

class CustomKeepAliveWrapper extends StatefulWidget {
  const CustomKeepAliveWrapper(this.child, {super.key});

  final Widget child;

  @override
  State<CustomKeepAliveWrapper> createState() => _CustomKeepAliveWrapperState();
}

class _CustomKeepAliveWrapperState extends State<CustomKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
