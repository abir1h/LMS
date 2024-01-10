import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../widgets/one_word_answer_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/question_widget.dart';

class AssessmentAnsInOneWordScreen extends StatefulWidget {
  const AssessmentAnsInOneWordScreen({super.key});

  @override
  State<AssessmentAnsInOneWordScreen> createState() =>
      _AssessmentAnsInOneWordScreenState();
}

class _AssessmentAnsInOneWordScreenState
    extends State<AssessmentAnsInOneWordScreen> with AppTheme, Language {
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
                    e: "Please read the question and write the correct answer in one word.",
                    b: "অনুগ্রহ করে প্রশ্নটি পড়ুন এবং সঠিক উত্তরটি এক কথায় লিখুন।"),
                style: TextStyle(
                    color: clr.iconColorDarkGrey,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h16),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    questionNo: "${index + 1}",
                    questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
                    questionDescription:
                        "(পারিবারিক প্রেক্ষাপট রবীন্দ্রনাথ ঠাকুরের জন্ম পারিবারিক বাসভবনে যা কলকাতায় অবস্থিত ছিল)",
                    child: const OneWordAnswerWidget(
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
                    onTap: () {
                      CustomToasty.of(context)
                          .showSuccess("সফলভাবে  জমাদান সম্পন্ন হয়েছে");
                      Get.back();
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
