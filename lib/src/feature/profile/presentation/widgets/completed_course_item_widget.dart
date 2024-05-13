import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms/src/feature/profile/domain/entities/completed_course_data_entity.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/presentation/screens/overall_progress_screen.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CompletedCourseItemWidget extends StatelessWidget
    with AppTheme, Language {
  final VoidCallback onTap;
  final CompletedCourseDataEntity completedCourseDataEntity;
  const CompletedCourseItemWidget({super.key, required this.onTap, required this.completedCourseDataEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(size.w8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 4,
            offset: Offset(0, 3), // Adjust shadow offset as needed
          ),
        ],
        border: Border.all(color: clr.progressBGColor, width: size.w1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.w8, right: size.w8, top: size.h56, bottom: size.h24+size.h1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: label(
                      e: completedCourseDataEntity.nameEn,
                      b: completedCourseDataEntity.nameBn),
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins,
                  fontSize: size.textSmall,
                  textColor: clr.blackText,
                ),
                SizedBox(height: size.h20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w64),
                  child: DotWidget(
                    dashColor: clr.cardStrokeColorGrey2,
                    dashHeight: size.h1,
                    dashWidth: size.w6,
                  ),
                ),
                SizedBox(height: size.h12),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.calendarMonth,height: size.h16,),

                          SizedBox(width: size.w4),
                          Text(
                            label(
                                e: "Course Completed",
                                b: "কোর্সটি সম্পন্ন হয়েছেো"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(label(e: completedCourseDataEntity.endDate, b: replaceEnglishNumberWithBengali(completedCourseDataEntity.endDate)), maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins,
                      ),)
                  ],
                ),
                SizedBox(height: size.h8),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.trophyIcon,height: size.h16,),
                          SizedBox(width: size.w4),
                          Text(
                            label(
                                e: "Marks Earned",
                                b: "অর্জিত মার্ক"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(label(e: completedCourseDataEntity.marks.toString(), b: completedCourseDataEntity.marks.toString()), maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins,
                      ),)
                  ],
                ),

              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.80),
                  ]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.w8),
                      bottomLeft: Radius.circular(size.w8)),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w2 + size.w16, vertical: size.h6),
                child: Row(
                  children: [
                    CustomTextWidget(
                      text: label(e: "Completed", b: "সম্পন্ন"),
                      textColor: clr.shadeWhiteColor2,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: size.r20,
                      color: clr.shadeWhiteColor2,
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
