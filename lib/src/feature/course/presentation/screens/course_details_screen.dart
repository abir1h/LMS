import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../services/course_details_screen_service.dart';
import '../widgets/chapter_widget.dart';

class CourseDetailsScreen extends StatefulWidget with AppTheme {
  final Object? arguments;
  const CourseDetailsScreen({super.key, this.arguments});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with AppTheme, Language, CourseDetailsScreenService, AppEventsNotifier {
  late CourseDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadCourseData(_screenArgs.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _screenArgs.curriculumType == CircularStatus.running.name
          ? label(
              e: en.ongoingCourseDetailsText, b: bn.ongoingCourseDetailsText)
          : _screenArgs.curriculumType == CircularStatus.completed.name
              ? label(
                  e: en.completedCourseDetailsText,
                  b: bn.completedCourseDetailsText)
              : label(e: en.courseDetailsText, b: bn.courseDetailsText),
      body: Stack(
        children: [
          AppStreamBuilder<CourseDetailsDataEntity>(
            stream: courseDetailsDataStreamController.stream,
            loadingBuilder: (context) {
              return const Center(child: CircularLoader());
            },
            dataBuilder: (context, data) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: size.h12),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CourseWidget(
                      title: label(
                          e: "Education Policy and Management in Education",
                          b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
                      courseCode: label(
                          e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
                      chapterType: _screenArgs.status == "done"
                          ? ChapterType.done
                          : _screenArgs.status == "open"
                              ? ChapterType.open
                              : ChapterType.lock,
                      description: label(
                          e: "Teaching for Learning programs are detailed discussions for those who are teaching, or who want to teach, any subject, in any context",
                          b: "শেখার জন্য শিক্ষাদান প্রোগ্রামের হল যারা শিক্ষা দিচ্ছেন, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো প্রসঙ্গে বিস্তারিত আলোচনা"),
                      curriculumType: _screenArgs.curriculumType,
                    ),
                    SizedBox(height: size.h32),
                  ],
                ),
              );
            },
            emptyBuilder: (context, message, icon) => CustomEmptyWidget(
              message: message,
              // constraints: constraints,
              // offset: 350.w,
            ),
          ),
          /*SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: size.h12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CourseWidget(
                  title: label(
                      e: "Education Policy and Management in Education",
                      b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
                  courseCode:
                      label(e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
                  chapterType: _screenArgs.status == "done"
                      ? ChapterType.done
                      : _screenArgs.status == "open"
                          ? ChapterType.open
                          : ChapterType.lock,
                  description: label(
                      e: "Teaching for Learning programs are detailed discussions for those who are teaching, or who want to teach, any subject, in any context",
                      b: "শেখার জন্য শিক্ষাদান প্রোগ্রামের হল যারা শিক্ষা দিচ্ছেন, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো প্রসঙ্গে বিস্তারিত আলোচনা"),
                  curriculumType: _screenArgs.curriculumType,
                ),
                SizedBox(height: size.h32),
              ],
            ),
          ),*/
          if (_screenArgs.curriculumType == "upcoming")
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: CustomButton(
                  onTap: () {},
                  title: label(e: en.enroll, b: bn.enroll),
                  radius: size.w24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.courseDetailsScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class CourseWidget extends StatelessWidget with AppTheme, Language {
  final String title;
  final String courseCode;
  final ChapterType chapterType;
  final String description;
  final String curriculumType;
  const CourseWidget(
      {super.key,
      required this.title,
      required this.courseCode,
      required this.chapterType,
      required this.description,
      required this.curriculumType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseText(
          text: title,
          fontSize: size.textXMedium,
        ),
        SizedBox(height: size.h16),
        if (courseCode.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: size.h10),
            child: CourseText(
              text: courseCode,
              textColor: clr.textColorAppleBlack,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w400,
            ),
          ),
        CourseText(
          text: label(e: en.curriculumDescription, b: bn.curriculumDescription),
          textColor: clr.textColorBlack,
        ),
        SizedBox(height: size.h10),
        CourseText(
          text: description,
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: size.h16),
        CourseText(
          text: label(e: en.curriculumContent, b: bn.curriculumContent),
          textColor: clr.textColorBlack,
        ),
        SizedBox(height: size.h12),
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ChapterWidget(
              chapterTitle: label(
                  e: "Chapter 1: The Desert of Karbala",
                  b: "অধ্যায় ১: কারবালা প্রান্তর"),
              chapterCode: label(e: "Chapter Code", b: "অধ্যায়ের কোড"),
              chapterType:
                  curriculumType == "running" ? ChapterType.done : chapterType,
            ),
            SizedBox(height: size.h8),
            ChapterWidget(
              chapterTitle: label(
                  e: "Chapter 2: Human-Welfare", b: "অধ্যায় ২: মানব-কল্যাণ"),
              chapterCode: label(e: "Chapter Code", b: "অধ্যায়ের কোড"),
              chapterType: chapterType,
            ),
            SizedBox(height: size.h8),
            ChapterWidget(
              chapterTitle: label(
                  e: "Chapter 3: The Desert of Karbala",
                  b: "অধ্যায় ৩: কারবালা প্রান্তর"),
              chapterCode: label(e: "Chapter Code", b: "অধ্যায়ের কোড"),
              chapterType:
                  curriculumType == "running" ? ChapterType.lock : chapterType,
            ),
            SizedBox(height: size.h8),
            ChapterWidget(
              chapterTitle: label(
                  e: "Chapter 4: Human-Welfare", b: "অধ্যায় ৪: মানব-কল্যাণ"),
              chapterCode: label(e: "Chapter Code", b: "অধ্যায়ের কোড"),
              chapterType:
                  curriculumType == "running" ? ChapterType.lock : chapterType,
            ),
            SizedBox(height: size.h8),
            ChapterWidget(
              chapterTitle: label(
                  e: "Chapter 5: The Enormity of Life",
                  b: "অধ্যায় ৫: জীবযাত্রার বিপুলতা"),
              chapterCode: label(e: "Chapter Code", b: "অধ্যায়ের কোড"),
              chapterType:
                  curriculumType == "running" ? ChapterType.lock : chapterType,
            ),
          ],
        )
        // ListView.builder(
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: 4,
        //   itemBuilder: (context, index) {
        //     return const ChapterWidget(
        //       chapterTitle: "অধ্যায় ১: কারবালা প্রান্তর",
        //       chapterCode: "অধ্যায়ের কোড",
        //     );
        //   },
        // ),
      ],
    );
  }
}

class CourseText extends StatelessWidget with AppTheme {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CourseText(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.w16),
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? clr.appPrimaryColorGreen,
            fontSize: fontSize ?? size.textSmall,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontFamily: StringData.fontFamilyPoppins),
      ),
    );
  }
}
