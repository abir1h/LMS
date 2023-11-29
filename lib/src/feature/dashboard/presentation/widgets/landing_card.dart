import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class LandingCard extends StatelessWidget with AppTheme {
  final String text1, text2;
  final Size? minimumSize;
  final Color? primaryColor;
  final Widget? trailing;
  final Function() onPressed;

  const LandingCard(
      {super.key,
      this.primaryColor,
      this.trailing,
      this.minimumSize,
      required this.onPressed,
      required this.text1,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: minimumSize!.height,
      width: minimumSize!.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: size.w24, right: size.w20, top: size.h10, bottom: size.h10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1,
                    style: TextStyle(
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w400,
                        fontFamily: StringData.fontFamilyInter,
                        color: Colors.white)),
                Text(text2,
                    style: TextStyle(
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyRoboto,
                        color: Colors.white))
              ],
            ),
            trailing!
          ],
        ),
      ),
    );
  }
}
