import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'custom_text_widget.dart';

class RunningCourseCard extends StatelessWidget with AppTheme, Language {
  const RunningCourseCard({
    super.key,
    required this.image,
    required this.onPressed,
    required this.text1,
    required this.text2,
    required this.text3,
  });
  final String text1, text2, text3;
  final Widget image;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: clr.shadeWhiteColor,
            borderRadius: BorderRadius.circular(size.w8),
            border: Border.all(color: clr.boxStrokeColor, width: size.w1),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: clr.blackColor.withOpacity(.15))
            ],
          ),
          padding: EdgeInsets.only(
              left: size.w4,
              right: size.w1 + size.w12,
              top: size.h8,
              bottom: size.h4),
          margin: EdgeInsets.only(
              left: size.w16, right: size.w16, bottom: size.h20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                      text: label(e: en.ongoingWeek, b: bn.ongoingWeek)),
                  Icon(
                    Icons.arrow_forward,
                    size: size.r24,
                    color: clr.appPrimaryColorGreen,
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  SizedBox(width: size.w20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.w12, vertical: size.h6),
                          decoration: BoxDecoration(
                            color: clr.cardStrokeColor,
                            borderRadius: BorderRadius.circular(size.w4),
                          ),
                          child: Text(
                            text1,
                            style: TextStyle(
                                color: clr.textColorAppleBlack,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w600,
                                fontFamily: StringData.fontFamilyPoppins),
                          ),
                        ),
                        SizedBox(height: size.h8),
                        Text(
                          text2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: StringData.fontFamilyPoppins,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              color: clr.appPrimaryColorGreen),
                        ),
                        SizedBox(height: size.h12),
                        LinearPercentIndicator(
                          animation: true,
                          lineHeight: size.h8,
                          percent: 0.1,
                          progressColor: clr.appPrimaryColorGreen,
                          backgroundColor: clr.progressBGColor,
                          barRadius: Radius.circular(size.w6),
                          padding: EdgeInsets.zero,
                        ),
                        // LinearProgressIndicator(
                        //   value: .1,
                        //   color: clr.appPrimaryColorGreen,
                        //   backgroundColor: clr.progressBGColor,
                        //   valueColor: AlwaysStoppedAnimation<Color>(
                        //     clr.appPrimaryColorGreen,
                        //   ),
                        //   borderRadius: BorderRadius.circular(size.w6),
                        //   minHeight: size.h8,
                        // ),
                        SizedBox(height: size.h8),
                        Text(
                          text3,
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyPoppins),
                        ),
                        SizedBox(height: size.h6),
                        // Add more Text widgets as needed
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
