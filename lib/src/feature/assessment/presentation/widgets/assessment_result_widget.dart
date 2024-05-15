import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/result_data_entity.dart';

class AssessmentResultWidget extends StatelessWidget with AppTheme, Language {
  final ResultDataEntity data;
  const AssessmentResultWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.w20, vertical: size.h20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomTextWidget(
              text: label(
                  e: "সার্টিফিকেশন এসেসমেন্ট ১", b: "সার্টিফিকেশন এসেসমেন্ট ১"),
              fontSize: size.textXMedium,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: size.h24),
          ResultCardWidget(data: data),
        ],
      ),
    );
  }
}

class ResultCardWidget extends StatelessWidget with AppTheme, Language {
  final ResultDataEntity data;
  const ResultCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      margin: EdgeInsets.only(top: size.h16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.quiz_outlined,
              size: size.r20 * 2,
              color: clr.appPrimaryColorGreen,
            ),
          ),
          SizedBox(height: size.h16),
          Center(
            child: CustomTextWidget(
              text:
                  label(e: "Assessment Completed", b: "মূল্যায়ন সম্পন্ন হয়েছে"),
              fontSize: size.textXMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Total Question", b: "মোট প্রশ্ন"),
              rightText:
                  label(e: "5", b: replaceEnglishNumberWithBengali("5"))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Correct Answer", b: "সঠিক উত্তর"),
              rightText: label(e: "", b: replaceEnglishNumberWithBengali("0"))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Wrong Answer", b: "ভুল উত্তর"),
              rightText: label(e: "", b: replaceEnglishNumberWithBengali("5"))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Total Mark", b: "মোট মার্ক"),
              rightText: label(
                  e: "",
                  b: replaceEnglishNumberWithBengali(
                      data.totalMark.toString()))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Availed Mark", b: "প্রাপ্ত মার্ক"),
              rightText: label(
                  e: "",
                  b: replaceEnglishNumberWithBengali(
                      data.availedMark.toString()))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Exam Time", b: "মূল্যায়নের সময়"),
              rightText: label(e: "", b: replaceEnglishNumberWithBengali("5"))),
          SizedBox(height: size.h16),
          AssessmentResultRowWidget(
              leftText: label(e: "Completion Time", b: "সময় লেগেছে"),
              rightText: label(e: "", b: replaceEnglishNumberWithBengali("0"))),
        ],
      ),
    );
  }
}

class AssessmentResultRowWidget extends StatelessWidget with AppTheme {
  final String leftText;
  final String rightText;
  const AssessmentResultRowWidget(
      {super.key, required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: leftText,
          textColor: clr.textColorBlack,
          fontWeight: FontWeight.w500,
        ),
        CustomTextWidget(
          text: rightText,
          textColor: clr.textColorBlack,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
