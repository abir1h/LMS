import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/question_widget.dart';

class AssessmentTrueFalseScreen extends StatefulWidget {
  const AssessmentTrueFalseScreen({super.key});

  @override
  State<AssessmentTrueFalseScreen> createState() =>
      _AssessmentTrueFalseScreenState();
}

class _AssessmentTrueFalseScreenState extends State<AssessmentTrueFalseScreen>
    with AppTheme, Language {
  final controller = Get.put(AssessmentController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "Quiz", b: "কুইজ"),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w20, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(
                    e: "Quiz: Please select the correct answer:",
                    b: "কুইজঃ  অনুগ্রহ করে সঠিক উত্তর নির্বাচন করুন:"),
                style: TextStyle(
                    color: clr.iconColorDarkGrey,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h16),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.questions.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    questionNo: "${index + 1}",
                    questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
                    child: const TrueFalseAnswerWidget(
                        // data: controller.questions[index],
                        ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.h20);
                },
              ),
              SizedBox(height: size.h16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: () {},
                    title: label(e: en.submit, b: bn.submit),
                    horizontalPadding: size.w20,
                    verticalPadding: size.h4,
                    radius: size.r4,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

///True False section
class TrueFalseAnswerWidget extends StatefulWidget {
  // final TrueFalseQuestion data;
  const TrueFalseAnswerWidget({
    Key? key,
    // required this.data,
  }) : super(key: key);

  @override
  State<TrueFalseAnswerWidget> createState() => _TrueFalseAnswerWidgetState();
}

class _TrueFalseAnswerWidgetState extends State<TrueFalseAnswerWidget>
    with AppTheme, Language {
  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.boxStrokeColorSilver, width: size.r1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1,
                child: Radio(
                  activeColor: clr.appPrimaryColorGreen,
                  groupValue: groupValue,
                  value: 0,
                  onChanged: (newValue) =>
                      setState(() => groupValue = newValue!),
                ),
              ),
              Text(
                label(e: en.trueText, b: bn.trueText),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1,
                child: Radio(
                  activeColor: clr.appPrimaryColorGreen,
                  groupValue: groupValue,
                  value: 1,
                  onChanged: (newValue) =>
                      setState(() => groupValue = newValue!),
                ),
              ),
              Text(
                label(e: en.falseText, b: bn.falseText),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSelection() {
    if (mounted) {
      setState(() {
        // widget.data.isSelected = !widget.data.isSelected;
      });
    }
  }
}
