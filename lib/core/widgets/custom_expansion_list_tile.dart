import 'package:flutter/material.dart';

class CustomExpansionListTile extends StatefulWidget {
  const CustomExpansionListTile({
    super.key,
    required this.leading,
    required this.title,
    this.iconSize,
    this.style,
    required this.children,
  });

  final String leading;
  final String title;
  final double? iconSize;
  final TextStyle? style;
  final List<Widget> children;

  @override
  State<CustomExpansionListTile> createState() =>
      _CustomExpansionListTileState();
}

class _CustomExpansionListTileState extends State<CustomExpansionListTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _expand = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onExpansionChanged(bool value) {
    setState(() {
      _expand = value;
    });

    _expand ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: _onExpansionChanged,
      leading: Text(
        widget.leading,
        style: widget.style,
      ),
      title: Text(
        widget.title,
        style: widget.style,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      trailing: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 3.14,
            child: child,
          );
        },
        child: Icon(
          size: widget.iconSize,
          _expand ? Icons.remove : Icons.add,
        ),
      ),
      children: widget.children,
    );
  }
}
