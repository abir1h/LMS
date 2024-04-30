import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../services/overall_progress_screen_service.dart';
import '../widgets/tab_switch_widget.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../widgets/sf_graph.dart';

class OverallProgressScreen extends StatefulWidget {
  const OverallProgressScreen({super.key});

  @override
  State<OverallProgressScreen> createState() => _OverallProgressScreenState();
}

class _OverallProgressScreenState extends State<OverallProgressScreen>
    with AppTheme, Language, OverallProgressScreenService {
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

            /// Your Course Progress
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidget(
                text: label(e: en.yourCourseProgress, b: bn.yourCourseProgress),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            const YourCourseProgressWidget(),
            SizedBox(height: size.h16),

            ///Progress Line 1
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidget(
                text: label(e: en.progressLine, b: bn.progressLine),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            const SfGraph(),
            SizedBox(height: size.h16),

            ///Progress Line 2
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: CustomTextWidget(
                text: label(e: en.progressLine, b: bn.progressLine),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.h8),
            const SfGraph(),
            SizedBox(height: size.h20),

            /// Tab Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w24),
              child: TabSwitchWidget(
                leftTitle: label(e: "Weekly Progress", b: "সাপ্তাহিক অগ্রগতি"),
                rightTitle:
                    label(e: "Overall Progress", b: "সামগ্রিক অগ্রগতি "),
                onTabChange: onTabValueChange,
              ),
            ),
            SizedBox(height: size.h12),
            AppStreamBuilder<StateType>(
              stream: stateDataStreamController.stream,
              loadingBuilder: (context) {
                return const Center(child: CircularLoader());
              },
              dataBuilder: (context, data) {
                if (data is WeeklyDataState) {
                  return WeeklyProgressItemSectionWidget(
                      items: const ["", "", ""],
                      buildItem: (BuildContext context, int index, item) {
                        return const WeeklyProgressItemWidget();
                      });
                } else if (data is OverallDataState) {
                  return const OverallProgressWidget();
                } else {
                  return const CustomEmptyWidget(
                    icon: Icons.school_outlined,
                    message: "No matching data found!",
                  );
                }
              },
              emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                message: message,
                // constraints: constraints,
                // offset: 350.w,
              ),
            ),
            // WeeklyProgressItemSectionWidget(
            //     items: const ["", "", ""],
            //     buildItem: (BuildContext context, int index, item) {
            //       return const WeeklyProgressItemWidget();
            //     }),
            // SizedBox(height: size.h12),
            // const OverallProgressWidget(),
            SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
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
                              label(e: "50%", b: "৫০%"),
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
                              label(e: "75%", b: "৭৫%"),
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
                    label(e: "60%", b: "৬০%"),
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

class RowItemWidget extends StatelessWidget with AppTheme {
  final IconData? icon;
  final String? svg;
  final String title;
  final String subTitle;
  const RowItemWidget(
      {super.key,
      this.icon,
      this.svg,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (svg != null) SvgPicture.asset(svg!),
        if (icon != null)
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
            fontSize: size.textSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: size.w8),
        CustomTextWidget(
          text: subTitle,
          textColor: clr.textColorAppleBlack,
          fontSize: size.textSmall,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class DotWidget extends StatelessWidget with AppTheme {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 370,
    this.dashWidth = 10,
    this.emptyWidth = 2,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          totalWidth ~/ (dashWidth + emptyWidth),
          (index) => Container(
            width: dashWidth,
            height: dashHeight,
            color: index % 2 == 0 ? dashColor : clr.whiteColor,
            margin:
                EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
          ),
        ),
      ),
    );
  }
}

class WeeklyProgressItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const WeeklyProgressItemSectionWidget(
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
        return SizedBox(height: size.h16);
      },
    );
  }
}

class WeeklyProgressItemWidget extends StatelessWidget with AppTheme, Language {
  const WeeklyProgressItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      width: size.w56,
                      padding: EdgeInsets.all(size.r12),
                      decoration: BoxDecoration(
                        color: clr.cardFillColorCruise,
                        borderRadius: BorderRadius.circular(size.r8),
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
                      child: CustomTextWidget(
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
                RowItemWidget(
                  icon: Icons.smart_display_outlined,
                  title: label(
                      e: "Duration of Video Viewing", b: "ভিডিও দেখার সময়"),
                  subTitle: label(e: "15 Minutes", b: "১৫ মিনিট"),
                ),
                SizedBox(height: size.h8),
                RowItemWidget(
                  svg: ImageAssets.icTwoPager,
                  title: label(
                      e: "Time to read the script", b: "স্ক্রিপ্ট পড়ার সময়"),
                  subTitle: "-",
                ),
                SizedBox(height: size.h12),
                DotWidget(
                  dashColor: clr.cardStrokeColorGrey2,
                  dashHeight: size.h1,
                  dashWidth: size.w4,
                ),
                SizedBox(height: size.h12),
                CustomTextWidget(
                  text: label(e: "Marks", b: "প্রাপ্ত মার্ক"),
                  textColor: clr.appPrimaryColorGreen,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: size.h16),
                RowItemWidget(
                  icon: Icons.assignment_outlined,
                  title: label(e: "Assignment 1", b: "এসাইনমেন্ট ১"),
                  subTitle: "-",
                ),
                SizedBox(height: size.h8),
                RowItemWidget(
                  icon: Icons.quiz_outlined,
                  title: label(e: "Assessment 1", b: "মূল্যায়ন ১"),
                  subTitle: "-",
                ),
                SizedBox(height: size.h8),
                RowItemWidget(
                  icon: Icons.quiz_outlined,
                  title: label(e: "Assessment 1", b: "মূল্যায়ন ১"),
                  subTitle: "-",
                ),
                SizedBox(height: size.h12),
                CustomTextWidget(
                  text: label(
                      e: "Instructor's Comments", b: "প্রশিক্ষকের মন্তব্য"),
                  textColor: clr.appPrimaryColorGreen,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: size.h12),
                CustomTextWidget(
                  text: label(
                      e: "No comments were made", b: "কোন মন্তব্য করা হয় নি"),
                  textColor: clr.gapStrokeGrey,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: size.h12),
                DotWidget(
                  dashColor: clr.cardStrokeColorGrey2,
                  dashHeight: size.h1,
                  dashWidth: size.w4,
                ),
                SizedBox(height: size.h12),
                CustomTextWidget(
                  text: label(e: "Overall Progress", b: "সামগ্রিক অগ্রগতি"),
                  textColor: clr.appPrimaryColorGreen,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: size.h12),
                LinearPercentIndicator(
                  animation: true,
                  lineHeight: size.h10,
                  percent: 0.6,
                  trailing: Padding(
                    padding: EdgeInsets.only(left: size.w48),
                    child: Text(
                      label(e: "60%", b: "৬০%"),
                      style: TextStyle(
                          color: clr.blackColor,
                          fontSize: size.textXSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyRoboto),
                    ),
                  ),
                  progressColor: clr.progressColorOrange,
                  backgroundColor: clr.progressBGColor,
                  barRadius: Radius.circular(size.r12),
                  padding: EdgeInsets.zero,
                ),
                SizedBox(height: size.h12),
                DotWidget(
                  dashColor: clr.cardStrokeColorGrey2,
                  dashHeight: size.h1,
                  dashWidth: size.w4,
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
              padding:
                  EdgeInsets.symmetric(horizontal: size.w20, vertical: size.h6),
              child: CustomTextWidget(
                text: label(e: "Running", b: "চলমান"),
                textColor: clr.shadeWhiteColor2,
                fontSize: size.textXSmall,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OverallProgressWidget extends StatelessWidget with AppTheme, Language {
  const OverallProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: label(
                e: "Marks of all Assignments", b: "সকল এসাইনমেন্ট এর মার্ক"),
            textColor: clr.appPrimaryColorGreen,
            fontSize: size.textSmall,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: size.h12),
          AssignmentMarksItemSectionWidget(
              items: const ["", "", ""],
              buildItem: (BuildContext context, int index, item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: label(e: "${index + 1}.", b: "${index + 1}."),
                      textColor: clr.textColorBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: size.w8),
                    Expanded(
                      child: CustomTextWidget(
                        text: label(
                            e: "Assignment Title - Assignment 1",
                            b: "এসাইনমেন্ট এর শিরোনাম - এসাইনমেন্ট ১"),
                        textColor: clr.textColorBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(width: size.w16),
                    CustomTextWidget(
                      text: label(e: "5 / 10", b: "৫ / ১০"),
                      textColor: clr.textColorBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                );
              }),
          SizedBox(height: size.h16),
          CustomTextWidget(
            text:
                label(e: "Marks of all Assessments", b: "সকল মূল্যায়নের মার্ক"),
            textColor: clr.appPrimaryColorGreen,
            fontSize: size.textSmall,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: size.h12),
          AssignmentMarksItemSectionWidget(
              items: const ["", "", ""],
              buildItem: (BuildContext context, int index, item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: label(e: "${index + 1}.", b: "${index + 1}."),
                      textColor: clr.textColorBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: size.w8),
                    Expanded(
                      child: CustomTextWidget(
                        text: label(
                            e: "Assessment Title - Assessment 1",
                            b: "মূল্যায়নের শিরোনাম - মূল্যায়ন ১"),
                        textColor: clr.textColorBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(width: size.w16),
                    CustomTextWidget(
                      text: label(e: "5 / 10", b: "৫ / ১০"),
                      textColor: clr.textColorBlack,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class AssignmentMarksItemSectionWidget<T> extends StatelessWidget
    with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const AssignmentMarksItemSectionWidget(
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
        return SizedBox(height: size.h16);
      },
    );
  }
}
