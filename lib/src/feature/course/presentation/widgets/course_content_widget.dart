import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/course/presentation/screens/live_class_screen.dart';

import '../../../../core/constants/common_imports.dart';

class CourseContentWidget extends StatelessWidget with AppTheme {
  final IconData courseIcon;
  final Color iconColor;
  final String title;
  final String? buttonText;
  final IconData buttonIcon;
  final VoidCallback? onTap;
  const CourseContentWidget(
      {Key? key,
      required this.courseIcon,
      required this.iconColor,
      required this.title,
      this.buttonText,
      required this.buttonIcon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: size.w12 * 2,
            top: size.h16,
            bottom: size.h16,
            right: size.w16),
        decoration: BoxDecoration(
            color: clr.shadeWhiteColor2,
            border: Border(bottom: BorderSide(color: clr.boxStrokeColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                courseIcon,
                size: size.r24,
                color: iconColor,
              ),
            ),
            // SizedBox(width: size.w12),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // SizedBox(width: size.w12),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => Get.to(const LiveClassScreen()),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w8, vertical: size.h8),
                  decoration: BoxDecoration(
                      color: clr.cardFillColorCruise,
                      borderRadius: BorderRadius.circular(size.r4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buttonText ?? "চেক করুন",
                        style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: size.w8),
                      Icon(
                        buttonIcon,
                        size: size.r16,
                        color: clr.textColorAppleBlack,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
