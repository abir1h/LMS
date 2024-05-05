import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/popup_widget.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../assessment/presentation/screens/assesment_single_question_screen.dart';
import '../../../assessment/presentation/screens/assessment_answer_in_one_word_screen.dart';
import '../../../assessment/presentation/screens/assessment_matching_screen.dart';
import '../../../assessment/presentation/screens/assessment_true_false_screen.dart';
import '../../../assessment/presentation/screens/assessment_quiz_screen.dart';
import '../../../../core/utility/app_label.dart';
import '../../../assessment/presentation/screens/assessment_fill_in_the_blank_screen.dart';
import '../../domain/entities/course_module_data_entity.dart';
import 'course_content_widget.dart';
import '../../../../core/constants/common_imports.dart';

class ChapterWidget<T> extends StatefulWidget {
  final String chapterTitle;
  final String chapterCode;
  final int status;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ChapterWidget(
      {super.key,
      required this.chapterTitle,
      required this.chapterCode,
      required this.status,
      required this.items,
      required this.buildItem});

  @override
  State<ChapterWidget<T>> createState() => _ChapterWidgetState<T>();
}

class _ChapterWidgetState<T> extends State<ChapterWidget<T>>
    with AppTheme, Language {
  bool _isExpanded = false;

  _toggle() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.status != 0) {
              _toggle();
            }
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
            decoration: BoxDecoration(
              color: clr.backgroundColorGreenCyan,
              border: Border.all(color: clr.greyColor, width: size.w1),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: clr.blackColor.withOpacity(.2))
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.status == 0)
                  Icon(
                    Icons.lock,
                    color: clr.textColorBlack,
                    size: size.r20,
                  ),
                if (widget.status == 1)
                  SvgPicture.asset(
                    ImageAssets.icLockOpenRight,
                    colorFilter: ColorFilter.mode(
                        clr.appPrimaryColorGreen, BlendMode.srcIn),
                  ),
                if (widget.status == 2)
                  Icon(
                    Icons.check_circle,
                    color: clr.appPrimaryColorGreen,
                    size: size.r20,
                  ),
                SizedBox(width: size.w4),
                Container(
                  width: size.w40,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w4, vertical: size.h8),
                  decoration: BoxDecoration(
                    color: clr.cardFillColorCruise,
                    borderRadius: BorderRadius.circular(size.r8),
                    border:
                        Border.all(color: clr.drawerFillColor, width: size.w1),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   widget.chapterTitle,
                      //   style: TextStyle(
                      //       color: clr.appPrimaryColorGreen,
                      //       fontSize: size.textSmall,
                      //       fontWeight: FontWeight.w600,
                      //       fontFamily: StringData.fontFamilyPoppins),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: label(e: "Week 1: ", b: "সপ্তাহ ১: "),
                              style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: StringData.fontFamilyPoppins),
                              children: [
                                TextSpan(
                                    text: widget.chapterTitle,
                                    style: TextStyle(
                                        color: clr.appPrimaryColorGreen,
                                        fontSize: size.textSmall,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                            StringData.fontFamilyPoppins)),
                              ])),
                      SizedBox(height: size.h8),
                      Text(
                        widget.chapterCode,
                        style: TextStyle(
                            color: clr.appPrimaryColorGreen,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.w16),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: clr.appPrimaryColorGreen,
                  size: size.r24,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          /* ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CourseContentWidget(
                courseIcon: Icons.text_snippet,
                iconColor: clr.clickableLinkColor,
                title: label(
                    e: "Introduction, Chapter Description",
                    b: "ভূমিকা, অধ্যায়ের বিবরণ"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseIntroductionScreen,
                    arguments: CourseIntroductionScreenArgs(
                        screenTitle: label(
                            e: "Introduction, Chapter Description",
                            b: "ভূমিকা, অধ্যায়ের বিবরণ"))),
              ),
              CourseContentWidget(
                courseIcon: Icons.smart_display,
                iconColor: clr.iconColorSweetRed,
                title: label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                buttonText: label(e: en.see, b: bn.see),
                buttonIcon: Icons.play_circle,
                status: true,
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoute.transcriptVideoScreen),
              ),
              CourseContentWidget(
                courseIcon: Icons.assignment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "Assignment", b: "অ্যাসাইনমেন্ট"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoute.courseAssignmentScreen),
              ),
              CourseContentWidget(
                courseIcon: Icons.cast_connected,
                iconColor: clr.textColorBlack,
                title: label(e: "Live Class", b: "লাইভ ক্লাস"),
                buttonText: label(e: en.join, b: bn.join),
                buttonIcon: Icons.video_call,
                status: true,
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoute.courseLiveClassScreen),
              ),
              CourseContentWidget(
                courseIcon: Icons.help_center,
                iconColor: clr.textColorAppleBlack,
                title: label(e: "Evaluation", b: "মূল্যায়ন"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoute.assessmentScreen))),
              ),
              CourseContentWidget(
                courseIcon: Icons.help_center,
                iconColor: clr.textColorAppleBlack,
                title: label(e: "Evaluation 2", b: "মূল্যায়ন ২"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () =>
                            Get.to(const AssessmentSingleQuestionScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "Quiz", b: "কুইজ"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () => Get.to(const AssessmentQuizScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "Matching", b: "ম্যাচিং"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () => Get.to(const AssessmentMatchingScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "True False", b: "সত্য মিথ্যা"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () =>
                            Get.to(const AssessmentTrueFalseScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "Fill in the gaps", b: "শূন্যস্থান পূরণ"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () =>
                            Get.to(const AssessmentFillInTheBlankScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: "One word answer", b: "এক কথায় উত্তর"),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoute.courseAssessmentScreen,
                    arguments: CourseAssessmentScreenArgs(
                        onTap: () =>
                            Get.to(const AssessmentAnsInOneWordScreen()))),
              ),
              CourseContentWidget(
                courseIcon: Icons.add_comment,
                iconColor: clr.appPrimaryColorGreen,
                title: label(e: en.discussion, b: bn.discussion),
                buttonIcon: Icons.visibility,
                status: true,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoute.discussionScreen),
              ),
            ],
          )*/

          Column(
            children: [
              ListView.builder(
                itemCount: widget.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return widget.buildItem(context, index, widget.items[index]);
                },
              ),
              Container(
                // width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: size.h12),
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor2,
                  // border: Border(bottom: BorderSide(color: clr.boxStrokeColor)),
                ),
                child: GestureDetector(
                  onTap: () => _dialogBuilder(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w10, vertical: size.h6),
                    decoration: BoxDecoration(
                      color: clr.cardFillColorCruise,
                      borderRadius: BorderRadius.circular(size.r8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(ImageAssets.icBarChart),
                        SizedBox(width: size.w8),
                        Text(
                          label(
                              e: en.progressOfTheWeek, b: bn.progressOfTheWeek),
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXMedium,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyRoboto),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(color: clr.boxStrokeColor, height: size.h1)
            ],
          )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, builder) {
          return LayoutBuilder(builder: (context, constraints) {
            return Dialog(
              backgroundColor: clr.cardFillColorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.r8)),
              child: Container(
                decoration: BoxDecoration(
                    color: clr.cardFillColorWhite,
                    borderRadius: BorderRadius.circular(size.r8),
                    border:
                        Border.all(color: clr.cardStrokeColor, width: size.w1)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w20, vertical: size.h20 - size.h2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: clr.cardFillColorMintCream,
                          borderRadius: BorderRadius.circular(size.r8),
                          border: Border.all(
                              color: clr.cardStrokeColor, width: size.w1)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w16, vertical: size.h2 + size.h12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label(
                                e: en.progressOfTheWeek,
                                b: bn.progressOfTheWeek),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyRoboto),
                          ),
                          SizedBox(height: size.h12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: clr.shadeWhiteColor2,
                                    borderRadius:
                                        BorderRadius.circular(size.r8),
                                    border: Border.all(
                                        color: clr.cardStrokeColorGrey,
                                        width: size.w1)),
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
                                        label(e: "50%", b: "৫০%"),
                                        style: TextStyle(
                                            color: clr.blackColor,
                                            fontSize: size.textXSmall,
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                                StringData.fontFamilyRoboto),
                                      ),
                                      progressColor: clr.progressColorOrange,
                                      backgroundColor: clr.progressBGColor,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                    SizedBox(height: size.h16),
                                    Text(
                                      label(e: en.assignment, b: bn.assignment),
                                      style: TextStyle(
                                          color: clr.blackColor,
                                          fontSize: size.textXSmall,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              StringData.fontFamilyRoboto),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: clr.shadeWhiteColor2,
                                    borderRadius:
                                        BorderRadius.circular(size.r8),
                                    border: Border.all(
                                        color: clr.cardStrokeColorGrey,
                                        width: size.w1)),
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
                                        label(e: "75%", b: "৭৫%"),
                                        style: TextStyle(
                                            color: clr.blackColor,
                                            fontSize: size.textXSmall,
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                                StringData.fontFamilyRoboto),
                                      ),
                                      progressColor: clr.progressColorBlue,
                                      backgroundColor: clr.progressBGColor,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                    SizedBox(height: size.h16),
                                    Text(
                                      label(e: en.assessment, b: bn.assessment),
                                      style: TextStyle(
                                          color: clr.blackColor,
                                          fontSize: size.textXSmall,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              StringData.fontFamilyRoboto),
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
                          border: Border.all(
                              color: clr.cardStrokeColor, width: size.w1)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w16, vertical: size.h2 + size.h12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label(e: en.weeklyProgress, b: bn.weeklyProgress),
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
                              label(e: "60%", b: "৬০%"),
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyRoboto),
                            ),
                            progressColor: clr.progressColorOrange,
                            backgroundColor: clr.progressBGColor,
                            barRadius: Radius.circular(size.r12),
                            padding: EdgeInsets.zero,
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
                          border: Border.all(
                              color: clr.cardStrokeColor, width: size.w1)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w16, vertical: size.h2 + size.h12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label(e: en.classAttendance, b: bn.classAttendance),
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
                            percent: 0.8,
                            center: Text(
                              label(e: "82%", b: "৮২%"),
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
              ),
            );
          });
        });
      },
    );
  }
}
