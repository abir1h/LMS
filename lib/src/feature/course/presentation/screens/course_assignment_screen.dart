import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
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
  late CourseAssessmentScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseAssessmentScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAssignmentData(_screenArgs.courseContentId!);
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
                // SizedBox(height: size.h12),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                //   child: Text(
                //     label(
                //         e: "Assignment Instructions",
                //         b: "অ্যাসাইনমেন্টের নির্দেশাবলী"),
                //     style: TextStyle(
                //         color: clr.textColorAppleBlack,
                //         fontSize: size.textSmall,
                //         fontWeight: FontWeight.w600,
                //         fontFamily: StringData.fontFamilyPoppins),
                //   ),
                // ),
                // SizedBox(height: size.h20),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                //   child: Text(
                //     label(
                //         e: "Reflect on your own identity and aspirations as a teacher",
                //         b: "একজন শিক্ষক হিসাবে আপনার নিজের পরিচয় এবং আকাঙ্খাগুলিকে প্রতিফলিত করুন"),
                //     style: TextStyle(
                //         color: clr.textColorAppleBlack,
                //         fontSize: size.textSmall,
                //         fontWeight: FontWeight.w500,
                //         fontFamily: StringData.fontFamilyPoppins),
                //   ),
                // ),
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
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: size.w16),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.w20, vertical: size.h20),
                //   decoration: BoxDecoration(
                //       color: clr.whiteColor,
                //       borderRadius: BorderRadius.circular(size.r8),
                //       border: Border.all(
                //           color: clr.boxStrokeColor, width: size.w1)),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.calendar_month_rounded,
                //             color: clr.iconColorDarkGrey,
                //             size: size.r20,
                //           ),
                //           SizedBox(width: size.w8),
                //           Expanded(
                //             child: Text(
                //               label(
                //                   e: "Closing Date: 31st January",
                //                   b: "সমাপ্তির শেষ তারিখ: ৩১ জানুয়ারী"),
                //               style: TextStyle(
                //                   color: clr.blackColor,
                //                   fontSize: size.textSmall,
                //                   fontWeight: FontWeight.w500,
                //                   fontFamily: StringData.fontFamilyPoppins),
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: size.h16),
                //       Row(
                //         children: [
                //           SvgPicture.asset(
                //             ImageAssets.icAlarm,
                //             colorFilter: ColorFilter.mode(
                //                 clr.iconColorDarkGrey, BlendMode.srcIn),
                //           ),
                //           SizedBox(width: size.w8),
                //           Text(
                //             label(e: "5 pm", b: "বিকেল ৫টা"),
                //             style: TextStyle(
                //                 color: clr.blackColor,
                //                 fontSize: size.textSmall,
                //                 fontWeight: FontWeight.w500,
                //                 fontFamily: StringData.fontFamilyPoppins),
                //           ),
                //           SizedBox(width: size.w16),
                //           SvgPicture.asset(
                //             ImageAssets.icDictionary,
                //             colorFilter: ColorFilter.mode(
                //                 clr.iconColorDarkGrey, BlendMode.srcIn),
                //           ),
                //           SizedBox(width: size.w8),
                //           Expanded(
                //             child: Text(
                //               label(
                //                   e: "Word range: 200", b: "শব্দ পরিসীমা: ২০০"),
                //               style: TextStyle(
                //                   color: clr.blackColor,
                //                   fontSize: size.textSmall,
                //                   fontWeight: FontWeight.w500,
                //                   fontFamily: StringData.fontFamilyPoppins),
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: size.h16),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.quiz,
                //             color: clr.iconColorDarkGrey,
                //             size: size.r20,
                //           ),
                //           SizedBox(width: size.w8),
                //           Expanded(
                //             child: Text(
                //               label(
                //                   e: "Total Questions: 01",
                //                   b: "প্রশ্নের সংখ্যা: ০১"),
                //               style: TextStyle(
                //                   color: clr.blackColor,
                //                   fontSize: size.textSmall,
                //                   fontWeight: FontWeight.w500,
                //                   fontFamily: StringData.fontFamilyPoppins),
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: size.h20),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: size.w10),
                //         child: CustomButton(
                //           onTap: () => Navigator.of(context)
                //               .pushNamed(AppRoute.assignmentScreen),
                //           title: label(e: en.getStarted, b: bn.getStarted),
                //           radius: size.r4,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                AssignmentInstructionWidget(),
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
                    onTap: () => onTap(data),
                    title: label(e: en.enter, b: bn.enter),
                    textColor: clr.whiteColor,
                    radius: size.r4,
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

  @override
  void navigateToAssignmentScreen(AssignmentDataEntity assignmentDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.assignmentScreen,
        arguments: AssignmentArgs(assignmentDataEntity: assignmentDataEntity));
  }
}

class AssignmentInstructionRowWidget extends StatelessWidget
    with AppTheme, Language {
  final String text;
  const AssignmentInstructionRowWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: size.r8,
          color: clr.appPrimaryColorGreen,
        ),
        SizedBox(width: size.w8),
        Expanded(
          child: CustomTextWidget(
            text: text,
            textColor: clr.gapStrokeGrey,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class AssignmentInstructionWidget extends StatelessWidget
    with AppTheme, Language {
  const AssignmentInstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          AssignmentInstructionRowWidget(
            text: label(
                e: "You can submit maximum 2 times within the deadline. If you miss the deadline, you can submit once.",
                b: "আপনি সর্বোচ্চ ২ বার ডেডলাইনের মধ্যে সাবমিট করতে পারবেন। ডেডলাইন মিস হলে ১ বার সাবমিট করতে পারবেন।"),
          ),
          SizedBox(height: size.h16),
          AssignmentInstructionRowWidget(
            text: label(
                e: "Once your submission limit is over, you can no longer submit.",
                b: "আপনার সাবমিশন লিমিট শেষ হয়ে গেলে আর সাবমিট করতে পারবেন না।"),
          ),
          SizedBox(height: size.h16),
          AssignmentInstructionRowWidget(
            text: label(
                e: "You can write or upload files as an assignment.",
                b: "এসাইনমেন্ট হিসেবে আপনি লিখতে পারবেন কিংবা ফাইল আপলোড করতে পারবেন"),
          ),
        ],
      ),
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
        Icon(
          Icons.circle,
          size: size.r8,
          color: clr.appPrimaryColorGreen,
        ),
        SizedBox(width: size.w4),
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
            rightText: label(e: data.mark.toString(), b: data.mark.toString()),
          ),
          SizedBox(height: size.h20),
          AssignmentInfoRowWidget(
            leftText: label(e: en.passMark, b: bn.passMark),
            rightText:
                label(e: data.passMark.toString(), b: data.passMark.toString()),
          ),
        ],
      ),
    );
  }
}
