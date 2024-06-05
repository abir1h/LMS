import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../assignment/domain/entities/assignment_data_entity.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../services/course_assignment_screen_service.dart';

class CourseAssignmentScreen extends StatefulWidget {
  final Object? arguments;
  const CourseAssignmentScreen({super.key, this.arguments});

  @override
  State<CourseAssignmentScreen> createState() => _CourseAssignmentScreenState();
}

class _CourseAssignmentScreenState extends State<CourseAssignmentScreen>
    with AppTheme, Language, CourseAssignmentScreenService {
  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAssignmentData(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.assignment, b: bn.assignment),
      body: AppStreamBuilder<AssignmentDataEntity>(
        stream: assignmentDetailsDataStreamController.stream,
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
                  text: label(e: en.assignmentIns, b: bn.assignmentIns),
                  textColor: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                InstructionWidget(
                  instruction:
                      label(e: data.instructionsEn, b: data.instructionsBn),
                ),
                SizedBox(height: size.h16),

                ///Instructions
                CustomTextWidget(
                  text: label(e: en.allInfo, b: bn.allInfo),
                  textColor: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                AssignmentInfoWidget(data: data),
                SizedBox(height: size.h40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w40),
                  child: CustomButton(
                    onTap: () {
                      if (data.type == AssignmentType.group.name) {
                        if (data.circularSubAssignments != null) {
                          onTap(_screenArgs.courseContentId);
                        }
                      } else {
                        onTap(_screenArgs.courseContentId);
                      }
                    },
                    title: label(e: en.enter, b: bn.enter),
                    textColor: clr.whiteColor,
                    bgColor:
                        // (data.type == AssignmentType.group.name &&
                        //         data.circularSubAssignments == null)
                        //     ? clr.greyColor
                        //     :
                        clr.appPrimaryColorGreen,
                    radius: size.r4,
                  ),
                ),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title: label(
              e: 'No Assignment Found', b: 'কোন অ্যাসাইনমেন্ট পাওয়া যায়নি'),

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
  void navigateToAssignmentScreen(int courseContentId) {
    Navigator.of(context).pushNamed(AppRoute.collaborativeAssignmentScreen,
        arguments: AssignmentArgs(courseContentId: courseContentId));
  }
}

class InstructionWidget extends StatelessWidget with AppTheme, Language {
  final String instruction;
  const InstructionWidget({super.key, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      padding: EdgeInsets.symmetric(horizontal: size.w10, vertical: size.h12),
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
      child: stringToWidget(input: instruction),
    );
  }
}

class AssignmentInfoRowWidget extends StatelessWidget with AppTheme, Language {
  final String leftText;
  final String? rightText;
  const AssignmentInfoRowWidget(
      {super.key, required this.leftText, this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(
        //   Icons.circle,
        //   size: size.r8,
        //   color: clr.appPrimaryColorGreen,
        // ),
        // SizedBox(width: size.w4),
        Expanded(
          child: CustomTextWidget(
            text: leftText,
            textColor: clr.gapStrokeGrey,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w400,
          ),
        ),
        CustomTextWidget(
          text: label(e: ":", b: ":"),
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.only(left: size.w8, right: size.w24),
        ),
        if (rightText != null)
          Expanded(
            child: CustomTextWidget(
              text: rightText.toString(),
              textColor: clr.appPrimaryColorGreen,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
      ],
    );
  }
}

class AssignmentInfoWidget extends StatelessWidget with AppTheme, Language {
  final AssignmentDataEntity data;
  const AssignmentInfoWidget({super.key, required this.data});

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
          AssignmentInfoRowWidget(
            leftText: label(e: en.duration, b: bn.duration),
            rightText: label(e: "1st January, 2024", b: "৩ মার্চ, রাত ৮:০০"),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.assignmentType, b: bn.assignmentType),
            rightText: label(e: data.type, b: data.type),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.submissionType, b: bn.submissionType),
            rightText: label(e: data.submissionType, b: data.submissionType),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.totalMark, b: bn.totalMark),
            rightText: label(
                e: data.mark.toString(),
                b: replaceEnglishNumberWithBengali(data.mark.toString())),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.passMark, b: bn.passMark),
            rightText: label(
                e: data.passMark.toString(),
                b: replaceEnglishNumberWithBengali(data.passMark.toString())),
          ),
        ],
      ),
    );
  }
}
