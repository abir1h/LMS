import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../widgets/custom_html_expanded_text_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/content_count_data_entity.dart';
import '../../domain/entities/course_content_data_entity.dart';
import '../../domain/entities/course_details_data_entity.dart';
import '../../domain/entities/upcoming_class_data_entity.dart';
import '../services/course_details_screen_service.dart';
import '../widgets/chapter_widget.dart';
import '../widgets/course_content_widget.dart';
import '../widgets/blinking_widget.dart';

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
      initializeDateFormatting();
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
                    ///Live Class Widget
                    if (_screenArgs.curriculumType ==
                            CircularStatus.running.name &&
                        data.upcomingClass != null)
                      LiveClassTopicWidget(
                        data: data.upcomingClass!,
                        onTap: () {},
                      ),

                    ///Last Seen Widget
                    if (_screenArgs.curriculumType ==
                            CircularStatus.running.name &&
                        data.lastViewedContent != null)
                      LastSeenWidget(
                        data: data.lastViewedContent!,
                        onTap: () {
                          data.lastViewedContent!.contentType ==
                                  ContentType.circular_video.name
                              ? onTapCourseVideo(data.lastViewedContent!)
                              : data.lastViewedContent!.contentType ==
                                      ContentType.circular_assignment.name
                                  ? onTapCourseAssignment(
                                      data.lastViewedContent!.contentId,
                                      data.lastViewedContent!.isCompleted)
                                  : data.lastViewedContent!.contentType ==
                                          ContentType.circular_assessment.name
                                      ? onTapCourseAssessment(
                                          data.lastViewedContent!.contentId)
                                      : data.lastViewedContent!.contentType ==
                                              ContentType.course_script.name
                                          ? onTapScript(
                                              courseId: data.id,
                                              courseContentId: data
                                                  .lastViewedContent!.contentId,
                                              courseContentType: data
                                                  .lastViewedContent!
                                                  .contentType,
                                              courseCode: data.code,
                                              courseDescriptionEn:
                                                  data.longDescEn,
                                              courseDescriptionBn:
                                                  data.longDescBn)
                                          : data.lastViewedContent!
                                                      .contentType ==
                                                  ContentType.course_script.name
                                              ? onTapCourseLiveClass(data
                                                  .lastViewedContent!.contentId)
                                              : Container();
                        },
                      ),
                    CustomTextWidget(
                      text: label(e: data.nameEn, b: data.nameBn),
                      fontSize: size.textXMedium,
                      fontWeight: FontWeight.w500,
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                    ),
                    SizedBox(height: size.h8),
                    if (data.code.isNotEmpty)
                      CustomTextWidget(
                        text: label(
                            e: "${en.courseCode} ${data.code}",
                            b: "${bn.courseCode} ${data.code}"),
                        textColor: clr.textColorAppleBlack,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w400,
                        padding: EdgeInsets.symmetric(horizontal: size.w16),
                      ),
                    SizedBox(height: size.h12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(
                            text: label(e: en.aboutCourse, b: bn.aboutCourse),
                            textColor: clr.textColorBlack,
                            fontSize: size.textXMedium,
                            fontWeight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: onTapProgress,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.w10, vertical: size.h6),
                              // margin: EdgeInsets.symmetric(horizontal: size.w16),
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
                                  CustomTextWidget(
                                    text: label(
                                        e: en.overallProgress,
                                        b: bn.overallProgress),
                                    fontSize: size.textXMedium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.h4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                      child: HtmlExpandableText(
                        text: label(e: data.shortDescEn, b: data.shortDescBn),
                        style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        minimumTextLengthToFold: 130,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                    //   child: ExpandableText(
                    //     text: label(e: data.shortDescEn, b: data.shortDescBn),
                    //     style: TextStyle(
                    //         color: clr.textColorAppleBlack,
                    //         fontSize: size.textSmall,
                    //         fontWeight: FontWeight.w500,
                    //         fontFamily: StringData.fontFamilyPoppins),
                    //     minimumTextLengthToFold: 130,
                    //   ),
                    // ),
                    // CourseText(
                    //   text: label(e: data.shortDescEn, b: data.shortDescBn),
                    //   textColor: clr.textColorAppleBlack,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    SizedBox(height: size.h12),

                    ///Supporting Text
                    CustomTextWidget(
                      text:
                          label(e: en.supportingLesson, b: bn.supportingLesson),
                      textColor: clr.textColorBlack,
                      fontSize: size.textXMedium,
                      fontWeight: FontWeight.w500,
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                    ),
                    SizedBox(height: size.h8),
                    if (data.supportingDoc.isNotEmpty)
                      SupportingDocWidget(
                        docTitle: data.supportingDoc.split("/").last,
                        onTap: () {
                          downloadFiles(
                              fileUrl: data.supportingDoc,
                              filename: data.supportingDoc.split("/").last,
                              context: context);
                        },
                      ),
                    // SupportingTextItemSection(
                    //     items: const ["", ""],
                    //     buildItem: (BuildContext context, int index, item) {
                    //       return SupportingDocWidget(
                    //         onTap: () {},
                    //       );
                    //     }),
                    SizedBox(height: size.h12),

                    ///Course Material Widget
                    CourseMaterialWidget(
                      data: data.contentCount!,
                    ),
                    SizedBox(height: size.h12),

                    ///Course content
                    CustomTextWidget(
                      text: label(e: en.courseContent, b: bn.courseContent),
                      textColor: clr.textColorBlack,
                      fontSize: size.textXMedium,
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                    ),
                    SizedBox(height: size.h16),
                    CourseModuleItemSectionWidget(
                        items: data.courseModules!,
                        buildItem: (BuildContext context, int index, item) {
                          return ChapterWidget(
                            chapterTitle: label(e: item.nameEn, b: item.nameBn),
                            duration: item.startDate.isNotEmpty &&
                                    item.endDate.isNotEmpty
                                ? label(
                                    e: "${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.startDate))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.endDate))}",
                                    b: "${replaceEnglishNumberWithBengali(DateFormat('dd/MM/yyyy').format(DateTime.parse(item.startDate)))} - ${replaceEnglishNumberWithBengali(DateFormat('dd/MM/yyyy').format(DateTime.parse(item.endDate)))}")
                                : "",
                            status: item.status,
                            items: item.courseContents!,
                            onTapLearningOutcome: () => onTapLearningOutcome(
                                label(
                                    e: item.learningOutcomeEn,
                                    b: item.learningOutcomeBn)),
                            buildItem: (BuildContext context, int index, item) {
                              return CourseContentWidget(
                                data: item,
                                onTapVideo: () => onTapCourseVideo(item),
                                onTapAssignment: () => onTapCourseAssignment(
                                    item.contentId, item.isCompleted),
                                onTapAssessment: () =>
                                    onTapCourseAssessment(item.contentId),
                                onTapScript: () => onTapScript(
                                    courseId: data.id,
                                    courseContentId: item.contentId,
                                    courseContentType: item.contentType,
                                    courseCode: data.code,
                                    courseDescriptionEn: data.longDescEn,
                                    courseDescriptionBn: data.longDescBn),
                                onTapBlendedClass: () =>
                                    onTapCourseLiveClass(item.contentId),
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
              title: label(e: 'No Course Found', b: 'কোন কোর্স পাওয়া যায়নি'),
              // constraints: constraints,
              // offset: 350.w,
            ),
          ),

          ///Enroll will be add later
          // if (_screenArgs.curriculumType == CircularStatus.upcoming.name)
          //   Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Padding(
          //       padding: EdgeInsets.only(
          //           bottom: size.h20, left: size.w16, right: size.w16),
          //       child: CustomButton(
          //         onTap: () {},
          //         title: label(e: en.enroll, b: bn.enroll),
          //         radius: size.w24,
          //       ),
          //     ),
          //   ),
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
            onTap: () => Navigator.of(context)
                .pushNamed(AppRoute.courseAssessmentScreen)));
  }

  @override
  void navigateToCourseAssignmentScreen(int courseContentId, bool isCompleted) {
    if (isCompleted) {
      Navigator.of(context).pushNamed(AppRoute.assignmentScreen,
          arguments: AssignmentArgs(courseContentId: courseContentId));
    } else {
      Navigator.of(context).pushNamed(AppRoute.courseAssignmentScreen,
          arguments: AssignmentArgs(courseContentId: courseContentId));
    }
  }

  @override
  void navigateToCourseLiveClassScreen(int courseContentId) {
    Navigator.of(context).pushNamed(AppRoute.courseLiveClassScreen,
        arguments: CourseBlendedScreenArgs(courseContentId: courseContentId));
  }

  @override
  void navigateToCourseVideoScreen(CourseContentDataEntity itemData) {
    Navigator.of(context).pushNamed(AppRoute.transcriptVideoScreen,
        arguments: CourseVideoScreenArgs(data: itemData));
  }

  @override
  void navigateToOverallProgressScreen() {
    Navigator.of(context).pushNamed(AppRoute.overallProgressScreen);
  }

  @override
  void navigateToCourseScriptScreen(
      int courseId,
      int courseContentId,
      String courseContentType,
      String courseCode,
      String courseDescriptionEn,
      String courseDescriptionBn) {
    Navigator.of(context).pushNamed(AppRoute.courseScriptScreen,
        arguments: CourseScriptScreenArgs(
            courseContentId: courseContentId,
            courseContentType: courseContentType,
            courseCode: courseCode,
            courseDescriptionEn: courseDescriptionEn,
            courseDescriptionBn: courseDescriptionBn));
    contentReadPost(courseContentId, courseId);
  }

  @override
  void navigateToCourseLearningOutcomeScreen(String learningOutcome) {
    Navigator.of(context).pushNamed(AppRoute.courseLearningOutcomeScreen,
        arguments: CourseLearningOutcomeScreenArgs(text: learningOutcome));
  }
}

class LiveClassTopicWidget extends StatelessWidget with AppTheme, Language {
  final UpcomingClassDataEntity data;
  final VoidCallback onTap;
  const LiveClassTopicWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: clr.cardFillColorMintCream,
          borderRadius: BorderRadius.circular(size.w8),
          border: Border.all(color: clr.cardStrokeColor, width: size.w1),
        ),
        // padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h6),
        margin: EdgeInsets.symmetric(horizontal: size.w16),
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(ImageAssets.imgWebinar),
                  SizedBox(width: size.w10 + size.w1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: label(e: data.titleEn, b: data.titleBn),
                          textColor: clr.blackColor,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                        ),
                        SizedBox(height: size.h4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: size.r16,
                              color: clr.gapStrokeGrey,
                            ),
                            SizedBox(width: size.w6),
                            Expanded(
                              child: CustomTextWidget(
                                text: label(
                                    e: DateFormat('dd MMMM,').add_jm().format(
                                        DateTime.parse(data.scheduleAt)),
                                    b: DateFormat('dd MMMM,').add_jm().format(
                                        DateTime.parse(data.scheduleAt))),
                                textColor: clr.gapStrokeGrey,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w400,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: BlinkingWidget(
                child: Container(
                  decoration: BoxDecoration(
                    color: clr.appPrimaryColorGreen,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.w8),
                        bottomLeft: Radius.circular(size.w8)),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w16, vertical: size.h4),
                  child: CustomTextWidget(
                    text: label(e: en.upcoming, b: bn.upcoming),
                    textColor: clr.shadeWhiteColor2,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LastSeenWidget extends StatelessWidget with AppTheme, Language {
  final CourseContentDataEntity data;
  final VoidCallback onTap;
  const LastSeenWidget({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: clr.cardFillColorMintCream,
          borderRadius: BorderRadius.circular(size.w8),
          border: Border.all(color: clr.cardStrokeColor, width: size.w1),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: clr.blackColor.withOpacity(.2))
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
        margin: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: label(e: en.lastViewedLesson, b: bn.lastViewedLesson),
                    textColor: clr.textColorBlack,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: size.r16,
                  color: clr.appPrimaryColorGreen,
                ),
              ],
            ),
            SizedBox(height: size.h8),
            LinearPercentIndicator(
              animation: true,
              lineHeight: size.h16,
              percent: data.isCompleted ? 1 : 0,
              center: CustomTextWidget(
                text: label(
                    e: data.isCompleted ? "100%" : "0%",
                    b: data.isCompleted ? "১০০%" : "০%"),
                textColor: clr.blackColor,
                fontSize: size.textXXSmall,
                fontWeight: FontWeight.w500,
              ),
              progressColor: clr.cardStrokeColor,
              backgroundColor: clr.progressBGColor,
              barRadius: Radius.circular(size.r12),
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}

class SupportingDocWidget<T> extends StatelessWidget with AppTheme, Language {
  final String docTitle;
  final VoidCallback onTap;
  const SupportingDocWidget(
      {Key? key, required this.docTitle, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          borderRadius: BorderRadius.circular(size.r4),
          border: Border.all(color: clr.cardStrokeColorGrey2)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h4),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Row(
        children: [
          Image.asset(ImageAssets.imgPdf),
          SizedBox(width: size.w8),
          Expanded(
            child: CustomTextWidget(
              text: docTitle,
              textColor: clr.textColorBlack,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(width: size.w4),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.file_download_outlined,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
          )
        ],
      ),
    );
  }
}

class CourseMaterialWidget<T> extends StatefulWidget {
  final ContentCountDataEntity data;
  const CourseMaterialWidget({super.key, required this.data});

  @override
  State<CourseMaterialWidget<T>> createState() =>
      _CourseMaterialWidgetState<T>();
}

class _CourseMaterialWidgetState<T> extends State<CourseMaterialWidget<T>>
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
            _toggle();
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h4),
            margin: EdgeInsets.symmetric(horizontal: size.w16),
            decoration: BoxDecoration(
              color: clr.cardFillColorCruise,
              borderRadius: BorderRadius.circular(size.r8),
              border: Border.all(color: clr.drawerFillColor, width: size.w1),
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.2),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.h2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                    text: label(
                        e: en.whatWillBeInTheCourse,
                        b: bn.whatWillBeInTheCourse),
                    textColor: clr.textColorBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: clr.iconColorBlack,
                  size: size.r24,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            decoration: BoxDecoration(
              color: clr.cardFillColorWhite,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(size.w8),
                bottomRight: Radius.circular(size.w8),
              ),
              border:
                  Border.all(color: clr.cardStrokeColorGrey, width: size.w1),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: clr.blackColor.withOpacity(.15))
              ],
            ),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
            margin:
                EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseMaterialItemWidget(
                  icon: Icons.calendar_month,
                  title: label(e: "Duration", b: "সময়কাল"),
                  duration: label(
                      e: "${widget.data.courseWeekCount.toString()} Week",
                      b: "${replaceEnglishNumberWithBengali(widget.data.courseWeekCount.toString())} সপ্তাহ"),
                ),
                SizedBox(height: size.h8),
                CourseMaterialItemWidget(
                  icon: Icons.quiz,
                  title: label(e: "Assessment", b: "মূল্যায়ন"),
                  duration: label(
                      e: widget.data.assessmentCount.toString(),
                      b: "${replaceEnglishNumberWithBengali(widget.data.assessmentCount.toString())} টি"),
                ),
                SizedBox(height: size.h8),
                CourseMaterialItemWidget(
                  icon: Icons.video_call,
                  title: label(e: "Blended Class", b: "ব্লেনডেড ক্লাস"),
                  duration: label(
                      e: widget.data.blendedClassCount.toString(),
                      b: "${replaceEnglishNumberWithBengali(widget.data.blendedClassCount.toString())} টি"),
                ),
                SizedBox(height: size.h8),
                CourseMaterialItemWidget(
                  icon: Icons.text_snippet,
                  title: label(e: "Reading Materials", b: "রিডিং ম্যাটেরিয়ালস"),
                  duration: label(
                      e: widget.data.scriptCount.toString(),
                      b: "${replaceEnglishNumberWithBengali(widget.data.scriptCount.toString())} টি"),
                ),
                SizedBox(height: size.h8),
                CourseMaterialItemWidget(
                  icon: Icons.assignment,
                  title: label(e: "Assignment", b: "এসাইনমেন্ট"),
                  duration: label(
                      e: widget.data.assignmentCount.toString(),
                      b: "${replaceEnglishNumberWithBengali(widget.data.assignmentCount.toString())} টি"),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class CourseMaterialItemWidget extends StatelessWidget with AppTheme {
  final IconData icon;
  final String title;
  final String duration;
  const CourseMaterialItemWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: clr.appPrimaryColorGreen,
          size: size.r16,
        ),
        SizedBox(width: size.w4),
        Expanded(
          child: CustomTextWidget(
            text: title,
            textColor: clr.textColorAppleBlack,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(width: size.w4),
        CustomTextWidget(
          text: duration,
          textColor: clr.textColorAppleBlack,
          fontSize: size.textXSmall,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
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
