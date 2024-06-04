import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CollaborativeAssignmentInstructionScreen extends StatefulWidget {
  final Object? arguments;
  const CollaborativeAssignmentInstructionScreen({super.key, this.arguments});

  @override
  State<CollaborativeAssignmentInstructionScreen> createState() =>
      _CollaborativeAssignmentInstructionScreenState();
}

class _CollaborativeAssignmentInstructionScreenState
    extends State<CollaborativeAssignmentInstructionScreen>
    with AppTheme, Language {
  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
            CustomTextWidget(
              text: label(e: "Assignment Guide", b: "এসাইনমেন্ট সহায়িকা"),
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
                        e: "48 Hours - You have 48 hours to review this assignment",
                        b: "৪৮ ঘণ্টা - এই এসাইনমেন্টটি রেভিউ করার জন্য আপনার কাছে ৪৮ ঘণ্টা সময় আছে"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),
                  SizedBox(
                    height: size.h16,
                  ),
                  CustomTextWidget(
                    text: label(
                        e: "Mark 10 – Demonstrates a thorough understanding of the educational theories and practices discussed in the course (Grading Criteria Demo 1).",
                        b: "১০ নম্বর - কোর্সে আলোচিত শিক্ষাগত তত্ত্ব এবং অনুশীলন গুলির একটি পুঙ্খানুপুঙ্খ বোঝাপড়া প্রদর্শন করে (গ্রেডিং মানদণ্ড ডেমো 1)।"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),
                  SizedBox(
                    height: size.h16,
                  ),
                  CustomTextWidget(
                    text: label(
                        e: "20 Marks – Provides clear examples of how theoretical concepts can be applied in practical learning contexts (Grading Criteria Demo 2).",
                        b: "২০ নম্বর -তাত্ত্বিক ধারণাগুলি কীভাবে ব্যবহারিক শিক্ষার প্রসঙ্গে প্রয়োগ করা যেতে পারে তার স্পষ্ট উদাহরণ প্রদান করে (গ্রেডিং ক্রাইটেরিয়া ডেমো 2)।"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),
                  SizedBox(
                    height: size.h16,
                  ),
                  CustomTextWidget(
                    text: label(
                        e: "Score 5 – Recommends innovative teaching strategies that can improve student engagement and learning outcomes (Grading Criteria Demo 4).",
                        b: "৫ নম্বর - উদ্ভাবনী শিক্ষণ কৌশলগুলি সুপারিশ করে যা শিক্ষার্থীদের ব্যস্ততা এবং শেখার ফলাফলগুলিকে উন্নত করতে পারে (গ্রেডিং মানদণ্ড ডেমো 4)।"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),
                  SizedBox(
                    height: size.h16,
                  ),
                  CustomTextWidget(
                    text: label(
                        e: "Mark 6 - Presents information in a well-organized manner with clear reasoning and logical progression (Grading Criteria Demo 5).",
                        b: "৬ নম্বর - স্পষ্ট যুক্তি এবং যৌক্তিক অগ্রগতি (গ্রেডিং মানদণ্ড ডেমো 5) সহ একটি সুসংগঠিত পদ্ধতিতে তথ্য উপস্থাপন করে।"),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyRoboto,
                    fontSize: size.textSmall,
                  ),
                  SizedBox(
                    height: size.h16,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.h32 + size.h4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {},
                  verticalPadding: size.h8,
                  horizontalPadding: size.w28 + size.w1,
                  title: label(e: 'Reject', b: 'প্রত্যাখ্যান'),
                  bgColor: clr.whiteColor,
                  borderColor: clr.cardStrokeColor,
                  textColor: clr.appPrimaryColorGreen,
                ),
                SizedBox(
                  width: size.w24,
                ),
                CustomButtonGradient(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.collaborativeAssignmentVerifyScreen,
                  ),
                  verticalPadding: size.h8,
                  horizontalPadding: size.w40 + size.w1,
                  title: label(e: 'Agree', b: 'সম্মত'),
                  gradient: LinearGradient(
                    colors: [
                      clr.appPrimaryColorGreen,
                      clr.appPrimaryColorGreen.withOpacity(.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.1, 1],
                  ),
                  textColor: clr.whiteColor,
                ),
              ],
            ),
            SizedBox(height: size.h56),
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

class CustomButtonGradient extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final Color? bgColor, borderColor;
  final IconData? icon;
  final LinearGradient? gradient;
  final String title;
  final Color? textColor;
  final double? textSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final bool expanded;
  const CustomButtonGradient(
      {super.key,
      required this.onTap,
      this.bgColor,
      this.borderColor,
      this.icon,
      required this.title,
      this.textColor,
      this.textSize,
      this.horizontalPadding,
      this.verticalPadding,
      this.radius,
      this.gradient,
      this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? size.w16,
              vertical: verticalPadding ?? size.h10),
          width: expanded ? double.maxFinite : null,
          decoration: BoxDecoration(
              color: bgColor ?? clr.appPrimaryColorGreen,
              gradient: gradient,
              borderRadius: BorderRadius.circular(radius ?? size.w10),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: size.w1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: size.w4),
                  child: Icon(
                    icon,
                    color: clr.shadeWhiteColor2,
                    size: size.r16,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                    color: textColor ?? clr.shadeWhiteColor2,
                    fontSize: textSize ?? size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
