import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/assessment/presentation/screens/assessment_quiz_screen.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class CourseAssessmentScreen extends StatefulWidget {
  final VoidCallback onTap;
  const CourseAssessmentScreen({super.key, required this.onTap});

  @override
  State<CourseAssessmentScreen> createState() => _CourseAssessmentScreenState();
}

class _CourseAssessmentScreenState extends State<CourseAssessmentScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assessment, b: bn.assessment),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h16),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: clr.boxStrokeColor))),
                child: Text(
                  label(
                      e: "Education policy and management in education",
                      b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
                  style: TextStyle(
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
              SizedBox(height: size.h12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: Text(
                  label(e: en.assessment, b: bn.assessment),
                  style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
              SizedBox(height: size.h20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: Text(
                  label(
                      e: "Reflect on your own identity and aspirations as a teacher",
                      b: "একজন শিক্ষক হিসাবে আপনার নিজের পরিচয় এবং আকাঙ্খাগুলিকে প্রতিফলিত করুন"),
                  style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
              SizedBox(height: size.h16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: Text(
                  label(e: en.instructions, b: bn.instructions),
                  style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
              SizedBox(height: size.h16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.w16),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w20, vertical: size.h20),
                decoration: BoxDecoration(
                    color: clr.whiteColor,
                    borderRadius: BorderRadius.circular(size.r8),
                    border:
                        Border.all(color: clr.boxStrokeColor, width: size.w1)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: clr.iconColorDarkGrey,
                          size: size.r20,
                        ),
                        SizedBox(width: size.w8),
                        Expanded(
                          child: Text(
                            label(
                                e: "Last date for submission: 31 January",
                                b: "জমাদানের শেষ তারিখ: ৩১ জানুয়ারী"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.h16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icAlarm,
                          colorFilter: ColorFilter.mode(
                              clr.iconColorDarkGrey, BlendMode.srcIn),
                        ),
                        SizedBox(width: size.w8),
                        Text(
                          label(e: "Time: 30 minutes", b: "সময়ঃ ৩০ মিনিট"),
                          style: TextStyle(
                              color: clr.blackColor,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                        ),
                        SizedBox(width: size.w16),
                        SvgPicture.asset(
                          ImageAssets.icDictionary,
                          colorFilter: ColorFilter.mode(
                              clr.iconColorDarkGrey, BlendMode.srcIn),
                        ),
                        SizedBox(width: size.w8),
                        Expanded(
                          child: Text(
                            label(e: "Marks: 25", b: "মার্কস : ২৫"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.h16),
                    Row(
                      children: [
                        Icon(
                          Icons.quiz,
                          color: clr.iconColorDarkGrey,
                          size: size.r20,
                        ),
                        SizedBox(width: size.w8),
                        Expanded(
                          child: Text(
                            label(
                                e: "Total Questions: 10",
                                b: "প্রশ্নের সংখ্যা: ১০"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.h20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.w10),
                      child: CustomButton(
                        onTap: widget.onTap,
                        title: label(e: en.loginText, b: bn.loginText),
                        radius: size.r4,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
