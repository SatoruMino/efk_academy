import 'package:flutter/material.dart';

class CustomExpansionListTile extends StatefulWidget {
  const CustomExpansionListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.children,
  });

  final String leading;
  final String title;
  final List<Widget> children;

  @override
  State<CustomExpansionListTile> createState() =>
      _CustomExpansionListTileState();
}

class _CustomExpansionListTileState extends State<CustomExpansionListTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Text(
        widget.leading,
      ),
      title: Text(
        widget.title,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      children: widget.children,
    );
  }
}
