import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../assessment/domain/entities/assessment_data_entity.dart';
import '../services/course_assessment_screen_service.dart';

class CourseAssessmentScreen extends StatefulWidget {
  final Object? arguments;
  const CourseAssessmentScreen({super.key, this.arguments});

  @override
  State<CourseAssessmentScreen> createState() => _CourseAssessmentScreenState();
}

class _CourseAssessmentScreenState extends State<CourseAssessmentScreen>
    with AppTheme, Language, CourseAssessmentScreenService {
  late CourseAssessmentScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseAssessmentScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAssessmentData(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.assessment, b: bn.assessment),
      body: AppStreamBuilder<AssessmentDataEntity>(
        stream: assessmentDetailsDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w16, vertical: size.h16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: clr.boxStrokeColor))),
                  child: Text(
                    label(e: data.titleEn, b: data.titleBn),
                    style: TextStyle(
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
                SizedBox(height: size.h12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Text(
                    label(e: en.assessment, b: bn.assessment),
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
                SizedBox(height: size.h20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Text(
                    label(
                        e: "Reflect on your own identity and aspirations as a teacher",
                        b: "একজন শিক্ষক হিসাবে আপনার নিজের পরিচয় এবং আকাঙ্খাগুলিকে প্রতিফলিত করুন"),
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
                SizedBox(height: size.h16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Text(
                    label(e: en.instructions, b: bn.instructions),
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
                SizedBox(height: size.h16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.w16),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w20, vertical: size.h20),
                  decoration: BoxDecoration(
                      color: clr.whiteColor,
                      borderRadius: BorderRadius.circular(size.r8),
                      border: Border.all(
                          color: clr.boxStrokeColor, width: size.w1)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: clr.iconColorDarkGrey,
                            size: size.r20,
                          ),
                          SizedBox(width: size.w8),
                          Expanded(
                            child: Text(
                              label(
                                  e: "Last date for submission: ${data.endDate}",
                                  b: "জমাদানের শেষ তারিখ: ${data.endDate}"),
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.h16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.icAlarm,
                            colorFilter: ColorFilter.mode(
                                clr.iconColorDarkGrey, BlendMode.srcIn),
                          ),
                          SizedBox(width: size.w8),
                          Text(
                            label(e: "Time: ${data.totalTime} minutes", b: "সময়ঃ ${data.totalTime} মিনিট"),
                            style: TextStyle(
                                color: clr.blackColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                          ),
                          SizedBox(width: size.w16),
                          SvgPicture.asset(
                            ImageAssets.icDictionary,
                            colorFilter: ColorFilter.mode(
                                clr.iconColorDarkGrey, BlendMode.srcIn),
                          ),
                          SizedBox(width: size.w8),
                          Expanded(
                            child: Text(
                              label(e: "Marks: ${data.totalMark}", b: "মার্কস : ${data.totalMark}"),
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.h16),
                      Row(
                        children: [
                          Icon(
                            Icons.quiz,
                            color: clr.iconColorDarkGrey,
                            size: size.r20,
                          ),
                          SizedBox(width: size.w8),
                          Expanded(
                            child: Text(
                              label(
                                  e: "Total Questions: 10",
                                  b: "প্রশ্নের সংখ্যা: ১০"),
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.h20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.w10),
                        child: CustomButton(
                          onTap: _screenArgs.onTap,
                          title: label(e: en.getStarted, b: bn.getStarted),
                          radius: size.r4,
                        ),
                      )
                    ],
                  ),
                ),
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
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
