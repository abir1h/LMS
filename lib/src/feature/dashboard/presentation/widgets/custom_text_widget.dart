import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class CustomTextWidget extends StatelessWidget with AppTheme {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  const CustomTextWidget(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontFamily,
      this.fontWeight,
      this.maxLines,
      this.textAlign,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? clr.appPrimaryColorGreen,
            fontSize: fontSize ?? size.textSmall,
            fontFamily: fontFamily ?? StringData.fontFamilyRoboto,
            fontWeight: fontWeight ?? FontWeight.w600,
            overflow: TextOverflow.ellipsis),
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
