import 'package:flutter/material.dart';

import '../../../assessment/domain/entities/exam_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../assessment/domain/entities/assessment_data_entity.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../services/course_assessment_screen_service.dart';
import 'course_assignment_screen.dart';

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

                ///Instructions
                CustomTextWidget(
                  text: label(e: en.instructions, b: bn.instructions),
                  textColor: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w600,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                InstructionWidget(
                  instruction: label(
                      e: data.assessmentInstruction,
                      b: data.assessmentInstruction),
                ),
                SizedBox(height: size.h16),
                CustomTextWidget(
                  text: label(e: en.allInfo, b: bn.allInfo),
                  textColor: clr.textColorAppleBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w600,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                AssessmentInfoWidget(data: data),
                SizedBox(height: size.h20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w40),
                  child: CustomButton(
                    onTap: () => onTapStartExam(data.id),
                    title: label(e: en.getStarted, b: bn.getStarted),
                    radius: size.r4,
                  ),
                ),
                SizedBox(height: size.h40),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title:
              label(e: 'No Assessment Found', b: 'কোন মূল্যায়ন পাওয়া যায়নি'),
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

  @override
  void onTapExamDetailsScreen(ExamDataEntity data) {
    if (data.assessment!.isHorizontal) {
      Navigator.of(context).pushNamed(AppRoute.assessmentSlideViewScreen,
          arguments: AssessmentScreenArgs(examData: data));
    } else {
      Navigator.of(context).pushNamed(AppRoute.assessmentScrollViewScreen,
          arguments: AssessmentScreenArgs(examData: data));
    }
  }
}

class AssessmentInfoWidget extends StatelessWidget with AppTheme, Language {
  final AssessmentDataEntity data;
  const AssessmentInfoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.15))
        ],
      ),
      child: Column(
        children: [
          // AssignmentInfoRowWidget(
          //   leftText: label(e: "View Type", b: "ভিউ টাইপ"),
          //   rightText: label(e: "", b: ""),
          // ),
          // SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.totalMark, b: bn.totalMark),
            rightText: label(
                e: data.totalMark.toString(),
                b: "${replaceEnglishNumberWithBengali(data.totalMark.toString())} পয়েন্টস"),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.passMark, b: bn.passMark),
            rightText: label(
                e: data.passMark.toString(),
                b: "${replaceEnglishNumberWithBengali(data.passMark.toString())} পয়েন্টস"),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
              leftText: label(e: "Total Time", b: "সর্বমোট সময়"),
              rightText: label(
                  e: "${data.totalTime.toString()} Minutes",
                  b: "${replaceEnglishNumberWithBengali(data.totalTime.toString())} মিনিট")),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: "Total Opportunity", b: "সর্বমোট চেষ্টার সুযোগ"),
            rightText: label(
                e: "${data.tries.toString()} Times",
                b: "${replaceEnglishNumberWithBengali(data.tries.toString())} বার"),
          ),
        ],
      ),
    );
  }
}
