import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class TraineeCard extends StatelessWidget with AppTheme {
  final String text1, text2;
  final Size? minimumSize;
  final Color? primaryColor;
  final Widget? trailing;
  final Function() onPressed;
  const TraineeCard(
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w400,
                          fontFamily: StringData.fontFamilyInter,
                          color: Colors.black87)),
                  Text(text2,
                      style: TextStyle(
                          fontSize: size.textXMedium,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyRoboto,
                          color: Colors.black87))
                ],
              ),
            ),
            trailing!
          ],
        ),
      ),
    );
  }
}
