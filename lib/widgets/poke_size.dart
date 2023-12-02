import 'package:flutter/material.dart';

class PokeSize extends StatelessWidget {
  const PokeSize({Key? key, required this.iconData, required this.value, required this.label}) : super(key: key);

  final IconData iconData;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(iconData, color: Colors.black54),
            const SizedBox(width: 12),
            Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87),)
          ],
        ),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}