import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/src/feature/course/presentation/widgets/tab_switch_widget.dart';
import 'package:lms/src/feature/dashboard/presentation/widgets/custom_text_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/blinking_widget.dart';

class OverallProgressScreen extends StatefulWidget {
  const OverallProgressScreen({super.key});

  @override
  State<OverallProgressScreen> createState() => _OverallProgressScreenState();
}

class _OverallProgressScreenState extends State<OverallProgressScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.courseOverallProgress, b: bn.courseOverallProgress),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.h12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidgets(
                text: label(e: en.yourCourseProgress, b: bn.yourCourseProgress),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            const YourCourseProgressWidget(),
            SizedBox(height: size.h16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidgets(
                text: label(e: en.progressLine, b: bn.progressLine),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            Container(),

            ///Graph
            SizedBox(height: size.h16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidgets(
                text: label(e: en.progressLine, b: bn.progressLine),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            Container(),

            ///Graph
            SizedBox(height: size.h20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w24),
              child: const TabSwitchWidget(),
            ),
            SizedBox(height: size.h12),
            Container(
              decoration: BoxDecoration(
                color: clr.cardFillColorMintCream,
                borderRadius: BorderRadius.circular(size.w8),
                border: Border.all(color: clr.cardStrokeColor, width: size.w1),
              ),
              margin: EdgeInsets.symmetric(horizontal: size.w16),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.w20,
                        right: size.w20,
                        top: size.h32,
                        bottom: size.h12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.w40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.w4, vertical: size.h8),
                              decoration: BoxDecoration(
                                color: clr.cardFillColorCruise,
                                borderRadius: BorderRadius.circular(size.r8),
                                boxShadow: [
                                  BoxShadow(
                                    color: clr.blackColor.withOpacity(.2),
                                    blurRadius: size.r4,
                                    offset: Offset(0.0, size.h2),
                                  ),
                                ],
                              ),
                              child: Text(
                                label(e: "Week 1", b: "সপ্তাহ ১"),
                                style: TextStyle(
                                    color: clr.textColorAppleBlack,
                                    fontSize: size.textXXSmall,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyRoboto),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: size.w12),
                            Expanded(
                              child: CustomTextWidgets(
                                text: label(e: "Running", b: "চলমান"),
                                textColor: clr.textColorAppleBlack,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: size.h12),
                        Row(
                          children: [
                            Icon(
                              Icons.smart_display_outlined,
                              color: clr.appPrimaryColorGreen,
                              size: size.r16,
                            ),
                            SizedBox(width: size.w4),
                            Expanded(
                              child: CustomTextWidgets(
                                text: "title",
                                textColor: clr.textColorAppleBlack,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(width: size.w4),
                            CustomTextWidgets(
                              text: "duration",
                              textColor: clr.textColorAppleBlack,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clr.progressColorOrange,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size.w8),
                            bottomLeft: Radius.circular(size.w8)),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w20, vertical: size.h6),
                      child: CustomTextWidgets(
                        text: label(e: "Running", b: "চলমান"),
                        textColor: clr.shadeWhiteColor2,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YourCourseProgressWidget extends StatelessWidget with AppTheme, Language {
  const YourCourseProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: clr.cardFillColorWhite,
        // borderRadius: BorderRadius.circular(size.r8),
        // border: Border.all(color: clr.cardStrokeColor, width: size.w1),
        border: Border(
            top: BorderSide(color: clr.cardStrokeColor, width: size.w1),
            bottom: BorderSide(color: clr.cardStrokeColor, width: size.w1)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w44, vertical: size.h20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: clr.cardFillColorMintCream,
              borderRadius: BorderRadius.circular(size.r8),
              border: Border.all(color: clr.cardStrokeColor, width: size.w1),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: clr.blackColor.withOpacity(.2))
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: size.w16, vertical: size.h2 + size.h12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label(e: "Overall Progress", b: "সামগ্রিক অগ্রগতি"),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyRoboto),
                ),
                SizedBox(height: size.h12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: clr.shadeWhiteColor2,
                        borderRadius: BorderRadius.circular(size.r8),
                        border: Border.all(
                            color: clr.cardStrokeColorGrey, width: size.w1),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: clr.blackColor.withOpacity(.2))
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: size.w12,
                          right: size.w12,
                          top: size.h24,
                          bottom: size.h8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            animation: true,
                            radius: size.r24,
                            lineWidth: size.w1 + size.w4,
                            percent: .5,
                            center: Text(
                              "৫০%",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyRoboto),
                            ),
                            progressColor: clr.progressColorOrange,
                            backgroundColor: clr.progressBGColor,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          SizedBox(height: size.h16),
                          Text(
                            label(e: "Assignment", b: "এসাইনমেন্ট"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyRoboto),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: size.w16),
                    Container(
                      decoration: BoxDecoration(
                        color: clr.shadeWhiteColor2,
                        borderRadius: BorderRadius.circular(size.r8),
                        border: Border.all(
                            color: clr.cardStrokeColorGrey, width: size.w1),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: clr.blackColor.withOpacity(.2))
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: size.w12,
                          right: size.w12,
                          top: size.h24,
                          bottom: size.h8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            animation: true,
                            radius: size.r24,
                            lineWidth: size.w1 + size.w4,
                            percent: .75,
                            center: Text(
                              "৭৫%",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyRoboto),
                            ),
                            progressColor: clr.progressColorBlue,
                            backgroundColor: clr.progressBGColor,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          SizedBox(height: size.h16),
                          Text(
                            label(e: "Assessment", b: "এসেসমেন্ট"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyRoboto),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.h12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: clr.cardFillColorMintCream,
              borderRadius: BorderRadius.circular(size.r8),
              border: Border.all(color: clr.cardStrokeColor, width: size.w1),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: clr.blackColor.withOpacity(.2))
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: size.w16, vertical: size.h2 + size.h12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label(e: "Other Progress", b: "অন্যান্য অগ্রগতি"),
                  style: TextStyle(
                      color: clr.gapStrokeGrey,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyRoboto),
                ),
                SizedBox(height: size.h8),
                LinearPercentIndicator(
                  animation: true,
                  lineHeight: size.h16,
                  percent: 0.6,
                  center: Text(
                    "৬০%",
                    style: TextStyle(
                        color: clr.shadeWhiteColor2,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyRoboto),
                  ),
                  progressColor: clr.progressColorBlue,
                  backgroundColor: clr.progressBGColor,
                  barRadius: Radius.circular(size.r12),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
