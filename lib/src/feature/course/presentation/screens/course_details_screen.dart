import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../services/course_details_screen_service.dart';
import '../widgets/chapter_widget.dart';
import '../widgets/course_content_widget.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CourseText(
                      text: label(e: data.nameEn, b: data.nameBn),
                      fontSize: size.textXMedium,
                    ),
                    SizedBox(height: size.h16),
                    if (data.code.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: size.h10),
                        child: CourseText(
                          text: label(
                              e: "Course Code : ${data.code}",
                              b: "অধিবেশনের কোড : ${data.code}"),
                          textColor: clr.textColorAppleBlack,
                          fontSize: size.textXSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    CourseText(
                      text: label(
                          e: en.curriculumDescription,
                          b: bn.curriculumDescription),
                      textColor: clr.textColorBlack,
                    ),
                    SizedBox(height: size.h10),
                    CourseText(
                      text: label(e: data.shortDescEn, b: data.shortDescBn),
                      textColor: clr.textColorAppleBlack,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: size.h16),
                    CourseText(
                      text: label(
                          e: en.curriculumContent, b: bn.curriculumContent),
                      textColor: clr.textColorBlack,
                    ),
                    SizedBox(height: size.h12),
                    CourseModuleItemSectionWidget(
                        items: data.courseModules!,
                        buildItem: (BuildContext context, int index, item) {
                          return ChapterWidget(
                            chapterTitle: label(e: item.nameEn, b: item.nameBn),
                            chapterCode: label(
                                e: "Chapter Code ${item.code}",
                                b: "অধ্যায়ের কোড ${item.code}"),
                            chapterType: ChapterType.open,
                            items: item.courseContents!,
                            buildItem: (BuildContext context, int index, item) {
                              return CourseContentWidget(
                                data: item,
                                onTapVideo: onTapCourseVideo,
                                onTapAssignment: () =>
                                    onTapCourseAssignment(item.contentId),
                                onTapAssessment: () =>
                                    onTapCourseAssessment(item.contentId),
                                onTapScript: () {},
                                onTapBlendedClass: onTapCourseLiveClass,
                              );
                            },
                          );
                        }),
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
          if (_screenArgs.curriculumType == "upcoming")
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: size.h20, left: size.w16, right: size.w16),
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

  @override
  void navigateToCourseAssessmentScreen(int courseContentId) {
    Navigator.of(context).pushNamed(AppRoute.courseAssessmentScreen,
        arguments: CourseAssessmentScreenArgs(
            courseContentId: courseContentId,
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoute.assessmentScreen)));
  }

  @override
  void navigateToCourseAssignmentScreen(int courseContentId) {
    Navigator.of(context).pushNamed(AppRoute.courseAssignmentScreen,
        arguments: CourseAssessmentScreenArgs(
            courseContentId: courseContentId, onTap: () {}));
  }

  @override
  void navigateToCourseLiveClassScreen() {
    Navigator.of(context).pushNamed(AppRoute.courseLiveClassScreen);
  }

  @override
  void navigateToCourseVideoScreen() {
    Navigator.of(context).pushNamed(AppRoute.transcriptVideoScreen);
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

class CourseModuleItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CourseModuleItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h8);
      },
    );
  }
}
