import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, this.primary, required this.title}) : super(key: key);
  final Color? primary;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      fontSize: 18, 
      fontWeight: 
      FontWeight.bold, 
      color: primary ?? AppTheme.lightPrimaryColor)
    );
  }
}