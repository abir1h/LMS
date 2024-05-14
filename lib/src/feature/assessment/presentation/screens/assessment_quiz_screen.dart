import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/question_data_entity.dart';
import '../models/quiz_model.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/question_widget.dart';
import 'assessment_result_screen.dart';

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
        body: SingleChildScrollView(
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
              // GetBuilder<AssessmentController>(
              //     builder: (_) => ListView.separated(
              //           shrinkWrap: true,
              //           itemCount: controller.questions.length,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemBuilder: (context, index) {
              //             return QuestionWidget(
              //               questionNo: "${index + 1}",
              //               questionText:
              //                   controller.questions[index].questionText,
              //               questionImage:
              //                   controller.questions[index].questionImage,
              //               child: MCQAnswerWidget(
              //                 data: controller.questions[index],
              //               ),
              //             );
              //           },
              //           separatorBuilder: (context, index) {
              //             return SizedBox(height: size.h20);
              //           },
              //         )),
              SizedBox(height: size.h16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: () {
                      CustomToasty.of(context)
                          .showSuccess("সফলভাবে  জমাদান সম্পন্ন হয়েছে");
                      Get.to(const AssessmentResultScreen());
                    },
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

