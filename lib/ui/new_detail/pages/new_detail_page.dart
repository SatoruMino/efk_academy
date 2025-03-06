import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:flutter/material.dart';

class NewDetailPage extends StatelessWidget {
  const NewDetailPage(this.oNew, {super.key});

  final New oNew;

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
              oNew.name,
              style: titleStyle,
            ),
            const SizedBox(height: 4.0),
            Text(
              oNew.message,
              style: descriptionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
