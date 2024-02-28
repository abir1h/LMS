import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/enums/enums.dart';
import '../../domain/entities/course_data_entity.dart';

class CourseCard extends StatelessWidget with AppTheme {
  final CourseDataEntity data;
  final String circularStatus;
  final VoidCallback? onTap;
  const CourseCard({
    super.key,
    required this.data,
    required this.circularStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: circularStatus == CircularStatus.running.name
                ? clr.cardFillColorOrange
                : circularStatus == CircularStatus.completed.name
                    ? clr.cardFillColorGreen
                    : clr.cardFillColorBlue,
            borderRadius: BorderRadius.circular(size.w8),
            border: Border.all(
                color: circularStatus == CircularStatus.running.name
                    ? clr.cardStrokeColorOrange
                    : circularStatus == CircularStatus.completed.name
                        ? clr.cardStrokeColorGreen
                        : clr.cardStrokeColorBlue,
                width: size.w1),
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
                      label(e: data.nameEn, b: data.nameBn),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: StringData.fontFamilyPoppins,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w600,
                          color: clr.appPrimaryColorGreen),
                    ),
                  ),
                  if (circularStatus != CircularStatus.running.name)
                    Icon(
                      circularStatus == CircularStatus.completed.name
                          ? Icons.check_circle
                          : Icons.lock,
                      size: size.r20,
                      color: circularStatus == CircularStatus.completed.name
                          ? clr.appPrimaryColorGreen
                          : clr.iconColorDimGrey,
                    )
                ],
              ),
              SizedBox(height: size.h6),
              Text(
                label(
                    e: "Course Code : ${data.code}",
                    b: "অধিবেশনের কোড : ${data.code}"),
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
                label(
                    e: "Duration : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(data.startDate))} - ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.endDate))}",
                    b: "সময়কাল : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(data.startDate))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(data.endDate))}"),
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
                value: double.parse(data.courseProgress.toString()) / 100,
                color: clr.appPrimaryColorGreen,
                backgroundColor: clr.progressBGColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(clr.appPrimaryColorGreen),
                borderRadius: BorderRadius.circular(size.w6),
                minHeight: size.h8,
              ),
              SizedBox(height: size.h8),
              Text(
                label(
                    e: circularStatus == CircularStatus.running.name
                        ? "${data.courseProgress}% complete"
                        : circularStatus == CircularStatus.completed.name
                            ? "Completed"
                            : "Will Begin",
                    b: circularStatus == CircularStatus.running.name
                        ? "${data.courseProgress}% সম্পন্ন"
                        : circularStatus == CircularStatus.completed.name
                            ? "সম্পন্ন হয়েছে"
                            : "শুরু হবে"),
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
