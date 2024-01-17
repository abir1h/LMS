import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class CourseAssignmentScreen extends StatefulWidget {
  const CourseAssignmentScreen({super.key});

  @override
  State<CourseAssignmentScreen> createState() => _CourseAssignmentScreenState();
}

class _CourseAssignmentScreenState extends State<CourseAssignmentScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assignment, b: bn.assignment),
        body: SingleChildScrollView(
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
                  label(
                      e: "Brief Description of The Assignment",
                      b: "অ্যাসাইনমেন্ট সংক্ষিপ্ত বর্ণনা"),
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
                  label(
                      e: "Assignment Instructions",
                      b: "অ্যাসাইনমেন্ট নির্দেশাবলী"),
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
                                e: "Closing Date: 31st January",
                                b: "সমাপ্তির শেষ তারিখ: ৩১ জানুয়ারী"),
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
                          label(e: "5 pm", b: "বিকেল ৫টা"),
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
                            label(e: "Word range: 200", b: "শব্দ পরিসীমা: ২০০"),
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
                                e: "Total Questions: 01",
                                b: "প্রশ্নের সংখ্যা: ০১"),
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
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoute.assignmentScreen),
                        title: label(e: en.getStarted, b: bn.getStarted),
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
