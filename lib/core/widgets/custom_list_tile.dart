import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(4),
      minTileHeight: 0,
      minVerticalPadding: 4,
      leading: Icon(iconData),
      title: Text(text),
      trailing: const Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
