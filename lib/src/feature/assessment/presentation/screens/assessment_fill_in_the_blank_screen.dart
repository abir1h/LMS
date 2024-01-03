import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/assessment_controller.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/fill_in_the_gap_answer_widget.dart';
import '../widgets/question_widget.dart';

class AssessmentFillInTheBlankScreen extends StatefulWidget {
  const AssessmentFillInTheBlankScreen({super.key});

  @override
  State<AssessmentFillInTheBlankScreen> createState() =>
      _AssessmentFillInTheBlankScreenState();
}

class _AssessmentFillInTheBlankScreenState
    extends State<AssessmentFillInTheBlankScreen> with AppTheme, Language {
  final controller = Get.put(AssessmentController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "Assessment", b: "মূল্যায়ন"),
        bgColor: clr.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        body: GetBuilder<AssessmentController>(builder: (_) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: size.h16, vertical: size.w16),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.qusList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return QuestionWidget(
                        questionNo: "${index + 1}",
                        questionText: controller.qusList[index].title!,
                        child: FillInTheGapAnswerWidget(
                          mainModel: controller.qusList[index],
                          onChangeDv1: (v) {
                            controller.qusList[index].blank1 = v;
                          },
                          onChangeDv2: (v) {
                            controller.qusList[index].blank2 = v;
                          },
                        ),
                      );
                    }),
                SizedBox(height: size.h16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onTap: () {
                        CustomToasty.of(context)
                            .showSuccess("সফলভাবে  জমাদান সম্পন্ন হয়েছে");
                        Get.back();
                      },
                      title: label(e: en.submit, b: bn.submit),
                      radius: size.r4,
                      verticalPadding: size.h4,
                      bgColor: clr.appPrimaryColorGreen,
                      textColor: clr.whiteColor,
                      borderColor: clr.appPrimaryColorGreen,
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
