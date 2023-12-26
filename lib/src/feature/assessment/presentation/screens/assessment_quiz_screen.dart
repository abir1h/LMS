import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/quiz_model.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/question_widget.dart';

class AssessmentQuizScreen extends StatefulWidget {
  const AssessmentQuizScreen({super.key});

  @override
  State<AssessmentQuizScreen> createState() => _AssessmentQuizScreenState();
}

class _AssessmentQuizScreenState extends State<AssessmentQuizScreen>
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
              GetBuilder<AssessmentController>(
                  builder: (_) => ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.questions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return QuestionWidget(
                            questionNo: "${index + 1}",
                            questionText:
                                controller.questions[index].questionText,
                            child: MCQAnswerWidget(
                              data: controller.questions[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: size.h20);
                        },
                      )),
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

///MCQ Section
class MCQAnswerWidget extends StatefulWidget {
  final QuestionsEntity data;
  const MCQAnswerWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<MCQAnswerWidget> createState() => _MCQAnswerWidgetState();
}

class _MCQAnswerWidgetState extends State<MCQAnswerWidget> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MCQAnswerOptionWidget(
          value: widget.data.option1,
          isSelected: widget.data.userAnswer1,
          onTap: () => setState(() {
            widget.data.userAnswer1 = !widget.data.userAnswer1;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: widget.data.option2,
          isSelected: widget.data.userAnswer2,
          onTap: () => setState(() {
            widget.data.userAnswer2 = !widget.data.userAnswer2;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: widget.data.option3,
          isSelected: widget.data.userAnswer3,
          onTap: () => setState(() {
            widget.data.userAnswer3 = !widget.data.userAnswer3;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: widget.data.option4,
          isSelected: widget.data.userAnswer4,
          onTap: () => setState(() {
            widget.data.userAnswer4 = !widget.data.userAnswer4;
          }),
        ),
      ],
    );
  }
}

///MCQ Options
class MCQAnswerOptionWidget extends StatefulWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;
  const MCQAnswerOptionWidget(
      {Key? key,
      required this.value,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  State<MCQAnswerOptionWidget> createState() => _MCQAnswerOptionWidgetState();
}

class _MCQAnswerOptionWidgetState extends State<MCQAnswerOptionWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
        decoration: BoxDecoration(
            color: widget.isSelected ? clr.drawerFillColor : clr.whiteColor,
            borderRadius: BorderRadius.circular(size.r8),
            border: Border.all(color: clr.boxStrokeColor, width: size.r1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: size.r24,
              color: widget.isSelected
                  ? clr.appPrimaryColorGreen
                  : clr.boxStrokeColor,
            ),
            SizedBox(width: size.w24),
            Expanded(
              child: Text(
                widget.value,
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
