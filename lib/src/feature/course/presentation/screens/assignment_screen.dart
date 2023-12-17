import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assignment, b: bn.assignment),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: clr.iconColorBlack,
                        size: size.r24,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: clr.iconColorBlack,
                        size: size.r24,
                      ),
                      SizedBox(width: size.w8),
                      Expanded(
                        child: Text(
                          label(e: "5 pm", b: "বিকেল ৫টা"),
                          style: TextStyle(
                              color: clr.blackColor,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: size.w8),
                      Icon(
                        Icons.schedule,
                        color: clr.iconColorBlack,
                        size: size.r20,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        color: clr.iconColorBlack,
                        size: size.r24,
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
                  SizedBox(height: size.h20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w10),
                    child: CustomButton(
                      onTap: () {},
                      title: label(e: en.loginText, b: bn.loginText),
                      radius: size.r4,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
