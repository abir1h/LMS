import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/course_content_data_entity.dart';

class CourseContentWidget extends StatelessWidget with AppTheme, Language {
  final CourseContentDataEntity data;
  final IconData courseIcon;
  final Color iconColor;
  final String title;
  final String? buttonText;
  final IconData buttonIcon;
  final VoidCallback? onTap;
  final bool status;
  const CourseContentWidget(
      {Key? key,
      required this.data,
      required this.courseIcon,
      required this.iconColor,
      required this.title,
      this.buttonText,
      required this.buttonIcon,
      this.onTap,
      this.status = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size buttonTextSize = (TextPainter(
            text: TextSpan(text: buttonText ?? ""),
            maxLines: 1,
            textScaler: MediaQuery.of(context).textScaler,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: size.w12 * 2, top: size.h16, bottom: size.h16, right: size.w16),
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
            flex: buttonTextSize.width < 80.0 ? 3 : 2,
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
            flex: buttonTextSize.width < 80.0 ? 3 : 4,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w8, vertical: size.h8),
                decoration: BoxDecoration(
                    color: status
                        ? clr.cardFillColorCruise
                        : clr.greyColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(size.r4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        buttonText ?? label(e: en.check, b: bn.check),
                        style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
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
    );
  }
}
