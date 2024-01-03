import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../models/matching_question.dart';
import '../widgets/matching_answer_widget.dart';
import '../widgets/question_widget.dart';

class AssessmentMatchingScreen extends StatefulWidget {
  const AssessmentMatchingScreen({super.key});

  @override
  State<AssessmentMatchingScreen> createState() =>
      _AssessmentMatchingScreenState();
}

class _AssessmentMatchingScreenState extends State<AssessmentMatchingScreen>
    with AppTheme, Language {
  List<MatchingQuestions> matchingQuestions = [
    MatchingQuestions(
      questionTitle: "সঠিক উত্তর ম্যাচিং:",
      leftSides: [
        MatchingLeftSide(
            id: 1,
            leftSide:
                "একজন শিক্ষক হিসাবে আপনি কীভাবে আপনার বিদ্যমান জ্ঞানকে গড়ে তুলবেন এবং প্রসারিত করবেন?",
            selectedRightSide: MatchingRightSide(),
            mark: 0.0),
        MatchingLeftSide(
            id: 2,
            leftSide:
                "একজন শিক্ষক হিসাবে আপনি কীভাবে আপনার বিদ্যমান জ্ঞানকে গড়ে তুলবেন এবং প্রসারিত করবেন?",
            selectedRightSide: MatchingRightSide(),
            mark: 0.0),
        MatchingLeftSide(
            id: 3,
            leftSide:
                "একজন শিক্ষক হিসাবে আপনি কীভাবে আপনার বিদ্যমান জ্ঞানকে গড়ে তুলবেন এবং প্রসারিত করবেন?",
            selectedRightSide: MatchingRightSide(),
            mark: 0.0),
        MatchingLeftSide(
            id: 4,
            leftSide:
                "একজন শিক্ষক হিসাবে আপনি কীভাবে আপনার বিদ্যমান জ্ঞানকে গড়ে তুলবেন এবং প্রসারিত করবেন?",
            selectedRightSide: MatchingRightSide(),
            mark: 0.0),
      ],
      rightSides: [
        MatchingRightSide(index: 1, isUsed: false, rightSideText: "উত্তর 4"),
        MatchingRightSide(index: 2, isUsed: false, rightSideText: "উত্তর 3"),
        MatchingRightSide(index: 3, isUsed: false, rightSideText: "উত্তর 2"),
        MatchingRightSide(index: 4, isUsed: false, rightSideText: "উত্তর 1"),
      ],
    )
  ];

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
              ListView.separated(
                shrinkWrap: true,
                itemCount: matchingQuestions.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    questionNo: "${index + 1}",
                    questionText: "সঠিক উত্তর ম্যাচিং:",
                    child: MatchingAnswerWidget(
                      data: matchingQuestions[index],
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
