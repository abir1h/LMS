import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';

class CourseCard extends StatelessWidget with AppTheme {
  final String title, code, time, status;
  final double? titleFontSize;
  final IconData? iconData;
  final Color? bgColor, borderColor, iconColor;
  final double statusValue;
  final VoidCallback? onTap;
  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.time,
    required this.status,
    this.titleFontSize,
    this.iconData,
    this.bgColor,
    this.borderColor,
    this.iconColor,
    required this.statusValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: bgColor ?? clr.cardFillColorGreen,
            borderRadius: BorderRadius.circular(size.w8),
            border: Border.all(
                color: borderColor ?? clr.cardStrokeColorGreen, width: size.w1),
            boxShadow: [
              BoxShadow(
                color: clr.blackColor.withOpacity(.2),
                blurRadius: size.r8,
                offset: Offset(0.0, size.h2),
              ),
            ],
          ),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: StringData.fontFamilyPoppins,
                          fontSize: titleFontSize ?? size.textSmall,
                          fontWeight: FontWeight.w600,
                          color: clr.appPrimaryColorGreen),
                    ),
                  ),
                  if (iconData != null)
                    Icon(
                      iconData,
                      size: size.r20,
                      color: iconColor ?? clr.appPrimaryColorGreen,
                    )
                ],
              ),
              SizedBox(height: size.h6),
              Text(
                code,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w400,
                    color: clr.textColorAppleBlack),
              ),
              SizedBox(height: size.h8),
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    color: clr.placeHolderTextColorGray),
              ),
              SizedBox(height: size.h12),
              LinearProgressIndicator(
                value: statusValue,
                color: clr.appPrimaryColorGreen,
                backgroundColor: clr.progressBGColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(clr.appPrimaryColorGreen),
                borderRadius: BorderRadius.circular(size.w6),
                minHeight: size.h8,
              ),
              SizedBox(height: size.h8),
              Text(
                status,
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          )),
    );
  }
}
