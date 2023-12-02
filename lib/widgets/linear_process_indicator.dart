import 'package:flutter/material.dart';

class LinearProcessIndicator extends StatelessWidget {
  const LinearProcessIndicator({Key? key, required this.color, required this.sizeWidth, this.sizeHeight, required this.percent}) : super(key: key);

  final Color color;
  final double sizeWidth;
  final double? sizeHeight;
  final int percent;
  @override
  Widget build(BuildContext context) {
    double sizePercent = (percent / 100) * sizeWidth;
    return Stack(
      children: [
        Container(
          width: sizeWidth,
          height: sizeHeight ?? 8,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(13)
          ),
        ),
        AnimatedContainer(
          width: sizePercent,
          constraints: const BoxConstraints(maxWidth: 220),
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: color,
          ),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 2000),
        ),
      ],
    );
  }
}