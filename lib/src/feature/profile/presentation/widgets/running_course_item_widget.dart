import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lms/src/feature/profile/domain/entities/progress_course_data_entity.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../circular/presentation/screens/circular_details_screen.dart';
import '../../../course/presentation/screens/overall_progress_screen.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class RunningItemWidget extends StatelessWidget with AppTheme, Language {
  final VoidCallback onTap;
  final ProgressCourseDataEntity progressCourseDataEntity;
  const RunningItemWidget(
      {super.key, required this.onTap, required this.progressCourseDataEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.h24, horizontal: size.w12),
      decoration: BoxDecoration(
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        borderRadius: BorderRadius.circular(size.r8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 4,
            offset: Offset(0, 3), // Adjust shadow offset as needed
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      blurRadius: 4,
                      offset: Offset(0, 3), // Adjust shadow offset as needed
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius as needed
                  child: Image(
                    image: AssetImage(ImageAssets.imgAssignment),
                    fit: BoxFit.contain,
                    height: 70.h,
                    width: 77.w,
                    // Adjust image height as needed
                  ),
                ),
              ),
              SizedBox(
                width: size.h16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label(
                          e: progressCourseDataEntity.nameEn,
                          b: progressCourseDataEntity.nameBn),
                      style: TextStyle(
                          color: clr.appPrimaryColorGreen,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: size.h8,
                    ),
                    Text(
                      label(
                          e: 'Duration : ${progressCourseDataEntity.startDate} - ${progressCourseDataEntity.endDate}',
                          b: 'সময়কাল : ${replaceEnglishNumberWithBengali(progressCourseDataEntity.startDate)} - ${replaceEnglishNumberWithBengali(progressCourseDataEntity.endDate)}'),
                      // label(
                      //     e: 'Duration : ${DateFormat(" d y").format(DateTime.parse(progressCourseDataEntity.startDate))} - ${DateFormat.yMMMMd('en_US').format(DateTime.parse(progressCourseDataEntity.endDate))}',
                      //     b: 'সময়কাল : ${timeAgoToBengali(DateFormat("MMMM d y").format(DateTime.parse(progressCourseDataEntity.startDate)).replaceAll(',', ''))} - ${timeAgoToBengali(DateFormat.yMMMMd('en_US').format(DateTime.parse(progressCourseDataEntity.endDate)).replaceAll(',', ''))}'),

                      style: TextStyle(
                          color: clr.iconColorDimGrey,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w400,
                          fontFamily: StringData.fontFamilyRoboto),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: size.h24 + size.h1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.w64),
            child: DotWidget(
              dashColor: clr.cardStrokeColorGrey2,
              dashHeight: size.h1,
              dashWidth: size.w6,
            ),
          ),
          SizedBox(height: size.h12),
          Text(
            label(e: en.courseSummary, b: bn.courseSummary),
            style: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyRoboto),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: size.h12),
          RowItemWidgetText(
            leftText: label(e: "Total Week Count", b: "সর্বমোট সপ্তাহ সংখ্যা"),
            rightText: label(e:progressCourseDataEntity.courseModulesCount.toString(), b: replaceEnglishNumberWithBengali(progressCourseDataEntity.courseModulesCount.toString())),
          ),
          SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText:
                label(e: "Blended Class Count", b: "ব্লেনডেড ক্লাস সংখ্যা"),
            rightText: label(e: progressCourseDataEntity.blendedClassesCount.toString(), b: replaceEnglishNumberWithBengali(progressCourseDataEntity.blendedClassesCount.toString())),
          ),
          SizedBox(height: size.h16),
        /*  RowItemWidgetText(
            leftText:
                label(e: "Physical Class Count", b: "ফিজিক্যাল ক্লাস সংখ্যা "),
            rightText: label(e: "10", b: "১০"),
          ),
          SizedBox(height: size.h16),*/
          RowItemWidgetText(
            leftText:
                label(e: "Course Script Count", b: "কোর্স স্ক্রিপ্টস কাউন্ট"),
            rightText: label(e: progressCourseDataEntity.courseScriptsCount.toString(), b: replaceEnglishNumberWithBengali(progressCourseDataEntity.courseScriptsCount.toString())),
          ),
        ],
      ),
    );
  }
}
