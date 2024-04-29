import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

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
            CustomTextWidget(
              text: label(e: "অধ্যায়ের বিবরণ:", b: "অধ্যায়ের বিবরণ:"),
              textColor: clr.textColorBlack,
              fontFamily: StringData.fontFamilyPoppins,
            ),
            SizedBox(height: size.h8),
            CustomTextWidget(
              text: description,
              textColor: clr.textColorBlack,
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyPoppins,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: size.h64)
          ],
        ),
      ),
    );
  }
}
