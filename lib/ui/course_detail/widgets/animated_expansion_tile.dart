part of '../pages/course_detail_pages.dart';

class AnimatedExpansionTile extends StatefulWidget {
  const AnimatedExpansionTile({
    super.key,
    required this.leading,
    required this.title,
    required this.children,
  });

  final Widget leading, title;
  final List<Widget> children;
  @override
  State<AnimatedExpansionTile> createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool expanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onExpansionChanged(bool value) {
    setState(() {
      expanded = value;
    });

    expanded ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      minTileHeight: 50.h,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      leading: widget.leading,
      title: widget.title,
      trailing: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 3.14,
            child: Icon(
              size: 20.h,
              expanded ? Icons.remove : Icons.add,
            ),
          );
        },
      ),
      onExpansionChanged: onExpansionChanged,
      children: widget.children,
    );
  }
}
