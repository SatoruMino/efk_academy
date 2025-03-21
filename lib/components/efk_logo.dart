import 'package:flutter/material.dart';

class EfkLogo extends StatelessWidget {
  const EfkLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'EFK\nACADEMY',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(width: 4),
        Image.asset(
          'assets/images/efk.png',
        ),
      ],
    );
  }
}
