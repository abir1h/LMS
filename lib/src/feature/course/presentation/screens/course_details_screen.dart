import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                    if (_screenArgs.curriculumType ==
                        CircularStatus.running.name)
                      const LiveClassTopicWidget(),
                    if (_screenArgs.curriculumType ==
                        CircularStatus.running.name)
                      LastSeenWidget(
                        onTap: () {},
                      ),
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
                              b: "কোর্সের কোড : ${data.code}"),
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
                      text: label(e: "সহায়ক পাঠ", b: "সহায়ক পাঠ"),
                      textColor: clr.textColorBlack,
                    ),
                    SizedBox(height: size.h12),
                    SupportingTextItemSection(
                        items: const ["", ""],
                        buildItem: (BuildContext context, int index, item) {
                          return SupportingTextItemWidget(
                            onTap: () {},
                          );
                        }),
                    SizedBox(height: size.h12),
                    CourseMaterialWidget(
                      items: const ["", ""],
                      buildItem: (BuildContext context, int index, item) {
                        return Text("Test");
                      },
                    ),
                    SizedBox(height: size.h12),
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
          if (_screenArgs.curriculumType == CircularStatus.upcoming.name)
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
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  const CourseText(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.maxLines,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: size.w16),
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? clr.appPrimaryColorGreen,
            fontSize: fontSize ?? size.textSmall,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontFamily: StringData.fontFamilyPoppins,
            overflow: TextOverflow.ellipsis),
        maxLines: maxLines,
      ),
    );
  }
}

class LiveClassTopicWidget extends StatelessWidget with AppTheme {
  const LiveClassTopicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: clr.cardFillColorMintCream,
        borderRadius: BorderRadius.circular(size.w8),
        border: Border.all(color: clr.cardStrokeColor, width: size.w1),
      ),
      // padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h6),
      margin: EdgeInsets.only(left: size.w16, right: size.w16, top: size.h12),
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
                      CourseText(
                        text: label(
                            e: "Live Class Topics", b: "লাইভ ক্লাসের টপিক"),
                        textColor: clr.blackColor,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        padding: EdgeInsets.zero,
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
                            child: CourseText(
                              text: label(
                                  e: "২৯ ফেব্রুয়ারী, রাত ৯:০০ টা",
                                  b: "২৯ ফেব্রুয়ারী, রাত ৯:০০ টা"),
                              textColor: clr.gapStrokeGrey,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w400,
                              maxLines: 1,
                              padding: EdgeInsets.zero,
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
            child: Container(
              decoration: BoxDecoration(
                color: clr.gapStrokeGrey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.w8),
                    bottomLeft: Radius.circular(size.w8)),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h4),
              child: CourseText(
                text: label(e: "Upcoming", b: "আপকামিং"),
                textColor: clr.shadeWhiteColor2,
                fontSize: size.textXSmall,
                fontWeight: FontWeight.w500,
                padding: EdgeInsets.zero,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LastSeenWidget extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  const LastSeenWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  child: CourseText(
                    text: label(e: "সর্বশেষ দেখা পাঠ", b: "সর্বশেষ দেখা পাঠ"),
                    textColor: clr.textColorBlack,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    padding: EdgeInsets.zero,
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
            LinearProgressIndicator(
              value: .1,
              color: clr.cardStrokeColor,
              backgroundColor: clr.progressBGColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                clr.cardStrokeColor,
              ),
              borderRadius: BorderRadius.circular(size.w8),
              minHeight: size.h12,
            ),
          ],
        ),
      ),
    );
  }
}

class SupportingTextItemSection<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const SupportingTextItemSection(
      {super.key, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: size.w8,
        mainAxisSpacing: size.h8,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: size.w16),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
    );
  }
}

class SupportingTextItemWidget<T> extends StatelessWidget
    with AppTheme, Language {
  final VoidCallback onTap;
  const SupportingTextItemWidget({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: clr.shadeWhiteColor2,
            borderRadius: BorderRadius.circular(size.r4),
            border: Border.all(color: clr.cardStrokeColorGrey2)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h4),
        child: Row(
          children: [
            Image.asset(ImageAssets.imgPdf),
            SizedBox(width: size.w4),
            Expanded(
              child: CourseText(
                text: label(e: "Document-1.pdf", b: "Document-1.pdf"),
                textColor: clr.textColorBlack,
                fontSize: size.textXSmall,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(width: size.w4),
            Icon(
              Icons.file_download_outlined,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            )
          ],
        ),
      ),
    );
  }
}

class CourseMaterialWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CourseMaterialWidget(
      {super.key, required this.items, required this.buildItem});

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
                CourseText(
                  text: label(e: "কোর্সে যা থাকবে", b: "কোর্সে যা থাকবে"),
                  textColor: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  padding: EdgeInsets.zero,
                ),
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
            padding: EdgeInsets.symmetric(
                horizontal: size.w4 + size.w22, vertical: size.h12),
            margin: EdgeInsets.symmetric(horizontal: size.w24),
            child: ListView.builder(
              itemCount: widget.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return widget.buildItem(context, index, widget.items[index]);
              },
            ),
          )
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
