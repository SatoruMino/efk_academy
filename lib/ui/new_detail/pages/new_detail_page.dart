import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:flutter/material.dart';

class NewDetailPage extends StatelessWidget {
  const NewDetailPage(this.item, {super.key});

  final New item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: titleStyle,
            ),
            const SizedBox(height: 4.0),
            Text(
              item.message,
              style: descriptionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
