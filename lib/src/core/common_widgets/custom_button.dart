import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';

class CustomButton extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final Color? bgColor;
  final IconData? icon;
  final String title;
  final double? textSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final bool expanded;
  const CustomButton(
      {super.key,
      required this.onTap,
      this.bgColor,
      this.icon,
      required this.title,
      this.textSize,
      this.horizontalPadding,
      this.verticalPadding,
      this.radius,
      this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? size.w16,
              vertical: verticalPadding ?? size.h10),
          width: expanded ? double.maxFinite : null,
          decoration: BoxDecoration(
              color: bgColor ?? clr.appPrimaryColorGreen,
              borderRadius: BorderRadius.circular(radius ?? size.w10),
              border: Border.all(
                  color: bgColor ?? clr.appPrimaryColorGreen, width: size.w1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: size.w4),
                  child: Icon(
                    icon,
                    color: clr.shadeWhiteColor2,
                    size: size.r16,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                    color: clr.shadeWhiteColor2,
                    fontSize: textSize ?? size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
