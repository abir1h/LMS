import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class CustomTextWidgets extends StatelessWidget with AppTheme {
  final String text;
  const CustomTextWidgets({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: clr.appPrimaryColorGreen,
          fontSize: size.textSmall,
          fontFamily: StringData.fontFamilyRoboto,
          fontWeight: FontWeight.w600),
    );
  }
}
