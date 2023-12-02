import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 2, 
      color: Colors.grey.withOpacity(0.3),
      height: height
    );
  }
}