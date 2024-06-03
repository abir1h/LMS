import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CollaborativeAssignmentVerificationScreen extends StatefulWidget {
  final Object? arguments;
  const CollaborativeAssignmentVerificationScreen({super.key, this.arguments});

  @override
  State<CollaborativeAssignmentVerificationScreen> createState() =>
      _CollaborativeAssignmentVerificationScreenState();
}

class _CollaborativeAssignmentVerificationScreenState
    extends State<CollaborativeAssignmentVerificationScreen>
    with AppTheme, Language {
  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(resizeToAvoidBottomInset: true,
      title: "",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.h16, vertical: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextWidget(
              text: label(
                  e: "Basic Pedagogy: Collaborative Assignment",
                  b: "বেসিক পেডাগোজি: কোলাবরেটিভ এসাইনমেন্ট"),
              textColor: clr.appPrimaryColorGreen,
              fontWeight: FontWeight.w500,
              fontSize: size.textSmall,
            ),
            SizedBox(height: size.h16 + size.h2),
            Divider(
              height: size.h1,
              color: clr.boxStrokeColor,
            ),
            SizedBox(height: size.h16),
            Row(
              children: [
                CustomTextWidget(
                  text: label(
                      e: "Review time Remaining",
                      b: "রিভিউইয়ের সময় আছে:"),
                  textColor: clr.blackText,
                  fontFamily: StringData.fontFamilyRoboto,
                  fontWeight: FontWeight.w500,
                  fontSize: size.textSmall,
                ),SizedBox(width: size.w16,),
                CustomTextWidget(
                  text: label(
                      e: "Hour",
                      b: "ঘণ্টা"),
                  textColor: clr.blackText,
                  fontFamily: StringData.fontFamilyRoboto,
                  fontWeight: FontWeight.w500,
                  fontSize: size.textSmall,
                )
              ],
            ),            SizedBox(height: size.h16),

            CustomTextWidget(
              text: label(e: "Assignment Description", b: "অ্যাসাইনমেন্টের বিবরণ"),
              textColor: clr.blackText,
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
            ),
            SizedBox(height: size.h8),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.h10, vertical: size.h12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.r8),
                  boxShadow: [
                    BoxShadow(
                        color: clr.gapStrokeGrey.withOpacity(.15),
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 8)
                  ],
                  color: clr.whiteColor,
                  border: Border.all(color: clr.cardStrokeColorGrey2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomTextWidget(
                    text: label(
                        e: "An assignment is a piece of work or academic work that someone is given to do, especially as part of their studies or work. Assignments give students the opportunity to learn, practice and demonstrate that they have achieved their learning goals.",
                        b: "অ্যাসাইনমেন্ট হল একটি কাজ বা একাডেমিক কাজের অংশ যা কাউকে করতে দেওয়া হয়, বিশেষ করে তাদের পড়াশোনা বা কাজের অংশ হিসেবে।অ্যাসাইনমেন্টগুলি শিক্ষার্থীদের শেখার, অনুশীলন করার এবং প্রদর্শন করার সুযোগ দেয় যে তারা তাদের শেখার লক্ষ্য অর্জন করেছে।"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),

                ],
              ),
            ),            SizedBox(height: size.h16),   CustomTextWidget(
              text: label(e: "Trainee Submissions:", b: "প্রশিক্ষণার্থীর সাবমিশন:"),
              textColor: clr.blackText,
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
            ),
            SizedBox(height: size.h8),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.h10, vertical: size.h12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.r8),
                  boxShadow: [
                    BoxShadow(
                        color: clr.gapStrokeGrey.withOpacity(.15),
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 8)
                  ],
                  color: clr.whiteColor,
                  border: Border.all(color: clr.cardStrokeColorGrey2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomTextWidget(
                    text: 'শিক্ষাবিজ্ঞান বা পেডাগজি হলো শিক্ষার নীতিমালা এবং শিক্ষাদানের পদ্ধতি। এটি শিক্ষার্থীদের ভাষা বিকাশ, মনস্তাত্ত্বিক প্রশিক্ষণ, এবং শিক্ষামূলক সার্ভিসের প্রথম পর্যায়ে শিক্ষাদানের পদ্ধতি নির্ধারণ করে। এই প্রণালীতে শিক্ষার্থীদের বৈজ্ঞানিক ও মনস্তাত্ত্বিক পদ্ধতিতে শিক্ষা দেওয়া হয়।শব্দের প্রতীক সম্পর্কে যথার্থ উপলব্ধি',
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),

                ],
              ),
            ),            SizedBox(height: size.h16),
            Text.rich(
                textAlign: TextAlign.end,
                 overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: clr
                        .placeHolderTextColorGray,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData
                        .fontFamilyPoppins),
                TextSpan(

                    text: label(
                        e: "Enter Number",
                        b: "নম্বর ইনপুট দিন"),
                    style: TextStyle(color: clr.blackColor,fontWeight: FontWeight.w600,fontSize: size.textSmall,),
                    children: [

                      TextSpan(
                        text: label(
                          e: "*",
                          b: "*",
                        ),style: TextStyle(color: clr.appSecondaryColorFlagRed)
                      )
                    ])),SizedBox(height: size.h16,),
            AppTextField(

              hintText: '',
              autoMaxLine: true,
              controller: TextEditingController(),

            ),




            SizedBox(height: size.h56+size.h56),
          ],
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

