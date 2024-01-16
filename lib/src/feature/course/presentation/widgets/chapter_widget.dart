import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../assessment/presentation/screens/assesment_single_question_screen.dart';
import '../../../assessment/presentation/screens/assessment_answer_in_one_word_screen.dart';
import '../../../assessment/presentation/screens/assessment_matching_screen.dart';
import '../../../assessment/presentation/screens/assessment_screen.dart';
import '../../../assessment/presentation/screens/assessment_true_false_screen.dart';
import '../../../assessment/presentation/screens/assessment_quiz_screen.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../assessment/presentation/screens/assessment_fill_in_the_blank_screen.dart';
import '../screens/course_assessment_screen.dart';
import '../screens/course_assignment_screen.dart';
import '../../../transcript_video/presentaion/screens/transcript_video_screen.dart';
import '../screens/course_live_class_screen.dart';
import 'course_content_widget.dart';
import '../../../../core/constants/common_imports.dart';

class ChapterWidget extends StatefulWidget {
  final String chapterTitle;
  final String chapterCode;
  final ChapterType chapterType;
  const ChapterWidget(
      {super.key,
      required this.chapterTitle,
      required this.chapterCode,
      this.chapterType = ChapterType.lock});

  @override
  State<ChapterWidget> createState() => _ChapterWidgetState();
}

class _ChapterWidgetState extends State<ChapterWidget> with AppTheme, Language {
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
            if (widget.chapterType != ChapterType.lock) {
              _toggle();
            }
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
            decoration: BoxDecoration(
              color: clr.backgroundColorGreenCyan,
              border: Border(
                  top: BorderSide(
                      color: _isExpanded ? clr.greyColor : Colors.transparent),
                  bottom: BorderSide(
                      color: _isExpanded ? clr.greyColor : clr.boxStrokeColor)),
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.2),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.h2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.chapterType == ChapterType.done)
                  Icon(
                    Icons.check_circle,
                    color: clr.appPrimaryColorGreen,
                    size: size.r20,
                  ),
                if (widget.chapterType == ChapterType.open)
                  SvgPicture.asset(
                    ImageAssets.icLockOpenRight,
                    colorFilter: ColorFilter.mode(
                        clr.appPrimaryColorGreen, BlendMode.srcIn),
                  ),
                if (widget.chapterType == ChapterType.lock)
                  Icon(
                    Icons.lock,
                    color: clr.textColorBlack,
                    size: size.r20,
                  ),
                SizedBox(width: size.w28),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chapterTitle,
                        style: TextStyle(
                            color: clr.appPrimaryColorGreen,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.h8),
                      Text(
                        widget.chapterCode,
                        style: TextStyle(
                            color: clr.textColorAppleBlack,
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
                  color: clr.textColorBlack,
                  size: size.r24,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          ListView(
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
          )
        // ListView.builder(
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: 4,
        //   itemBuilder: (context, index) {
        //     return const CourseContentWidget(
        //       courseIcon: Icons.text_snippet,
        //       title: "ভূমিকা, অধ্যায়ের বিবরণ",
        //       buttonIcon: Icons.visibility,
        //     );
        //   },
        // ),
      ],
    );
  }
}

enum ChapterType { done, open, lock }
