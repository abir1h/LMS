import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class CustomTextWidgets extends StatelessWidget with AppTheme {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  const CustomTextWidgets(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor ?? clr.appPrimaryColorGreen,
          fontSize: fontSize ?? size.textSmall,
          fontFamily: StringData.fontFamilyRoboto,
          fontWeight: fontWeight ?? FontWeight.w600,
          overflow: TextOverflow.ellipsis),
      maxLines: maxLines,
    );
  }
}
