import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class ChapterDetailsWidget extends StatelessWidget with AppTheme {
  final String description;
  final ScrollPhysics? physics;
  const ChapterDetailsWidget(
      {super.key, required this.description, this.physics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: size.w16, right: size.w16, top: size.h12),
      padding: EdgeInsets.only(left: size.w6, right: size.w6, top: size.h6),
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.r4),
            topRight: Radius.circular(size.r4)),
        border: Border(
            right: BorderSide(color: clr.cardStrokeColor, width: size.r1),
            left: BorderSide(color: clr.cardStrokeColor, width: size.r1),
            top: BorderSide(color: clr.cardStrokeColor, width: size.r1)),
        boxShadow: [
          BoxShadow(
            color: clr.blackColor.withOpacity(.2),
            blurRadius: size.r4,
            offset: Offset(0.0, size.h2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: physics ?? const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                  color: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyPoppins),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: size.h64)
          ],
        ),
      ),
    );
  }
}
