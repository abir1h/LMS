import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class QuestionWidget extends StatelessWidget with AppTheme {
  final String questionNo;
  final String questionText;
  final String questionDescription;
  final Widget child;
  const QuestionWidget({
    Key? key,
    required this.questionNo,
    required this.questionText,
    this.questionDescription = "",
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: label(
                e: "Question ${questionNo.trim()}. ",
                b: "প্রশ্ন ${questionNo.trim()}. "),
            style: TextStyle(
              color: clr.blackColor,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w700,
              fontFamily: StringData.fontFamilyPoppins,
            ),
            children: [
              TextSpan(
                text: questionText.trim(),
                style: TextStyle(
                  color: clr.blackColor,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins,
                ),
              ),
            ])),
        if (questionDescription.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: size.h4),
            child: Text(
              questionDescription,
              style: TextStyle(
                color: clr.gapStrokeGrey,
                fontSize: size.textXXSmall,
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyRoboto,
              ),
            ),
          ),
        SizedBox(height: size.h10),
        Flexible(
          child: child,
        ),
      ],
    );
  }
}
