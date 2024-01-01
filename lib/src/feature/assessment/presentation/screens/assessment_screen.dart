import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/feature/assessment/presentation/widgets/question_widget.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../models/blank_model.dart';
import '../models/matching_question.dart';
import '../models/quiz_model.dart';
import '../widgets/blank_card.dart';
import '../widgets/question_list_widget.dart';
import '../widgets/time_digit_widget.dart';
import 'assessment_answer_in_one_word_screen.dart';
import 'assessment_matching_screen.dart';
import 'assessment_quiz_screen.dart';
import 'assessment_true_false_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({
    super.key,
  });

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen>
    with AppTheme, Language {
  final BehaviorSubject<Duration> timerStreamController = BehaviorSubject();
  final Stream<DataState> pageStateStreamController = Stream.empty();

  List<Question> questions = [
    Question(
      type: QuestionType.mcq,
      data: QuestionsEntity(
        id: 0,
        questionText:
            "শেখার জন্য শিক্ষাদানের প্রযুক্তি হল তাদের শিক্ষা, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো সময়?",
        questionImage: "",
        option1: "উত্তর বিকল্প ১",
        option2: "উত্তর বিকল্প ২",
        option3: "উত্তর বিকল্প ৩",
        option4: "উত্তর বিকল্প ৪",
        option5: "উত্তর বিকল্প ৫",
        option1Image: "",
        option2Image: "",
        option3Image: "",
        option4Image: "",
        option5Image: "",
        userAnswer1: true,
        userAnswer2: false,
        userAnswer3: false,
        userAnswer4: false,
        userAnswer5: false,
        answer1: true,
        answer2: false,
        answer3: false,
        answer4: false,
        answer5: false,
      ),
    ),
    Question(
      type: QuestionType.fig,
      data: BlankModel(
          fillInTheGapModelId: 0,
          title:
              "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
          description:
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.fig,
      data: BlankModel(
          fillInTheGapModelId: 0,
          title:
              "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
          description:
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"),
    ),
    Question(
        type: QuestionType.matching,
        data: MatchingQuestions(
          questionTitle:
          "সঠিক উত্তর ম্যাচিং:",
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
            MatchingRightSide(
                index: 1, isUsed: false, rightSideText: "উত্তর 4"),
            MatchingRightSide(
                index: 2, isUsed: false, rightSideText: "উত্তর 3"),
            MatchingRightSide(
                index: 3, isUsed: false, rightSideText: "উত্তর 2"),
            MatchingRightSide(
                index: 4, isUsed: false, rightSideText: "উত্তর 1"),
          ],
        )),
    Question(
      type: QuestionType.trueFalse,
      data: "",
    ),
    Question(
      type: QuestionType.oneWordAnswer,
      data: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assessment, b: bn.assessment),
        actionChild: TimeDigitWidget(
          timerStream: timerStreamController,
          examStateStream: pageStateStreamController,
          isExamRunning: (DataState<dynamic>? snapshot) {
            return true;
          },
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w20, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionListWidget(
                  items: questions,
                  builder: (context, data, index) {
                    if (data.type == QuestionType.mcq) {
                      return QuestionWidget(
                        questionNo: "${index + 1}",
                        questionText: questions[index].data.questionText,
                        child: MCQAnswerWidget(
                          data: questions[index].data,
                        ),
                      );
                    } else if (data.type == QuestionType.matching){
                      return QuestionWidget(
                        questionNo: "${index + 1}",
                        questionText: questions[index].data.questionTitle,
                        child:MatchingAnswerWidget(
                          data: questions[index].data,
                        ),
                      );
                    }else if (data.type == QuestionType.fig){
                       return BlankCard(
                        mainModel:  questions[index].data,
                        onChangeDv1: (v) {
                          // controller.qusList[index].blank1 = v;
                        },
                        onChangeDv2: (v) {
                          // controller.qusList[index].blank2 = v;
                        },
                      );
                    }else if (data.type == QuestionType.trueFalse){
                      return QuestionWidget(
                        questionNo: "${index + 1}",
                        questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
                        child:  const TrueFalseAnswerWidget(
                        ),
                      );
                    }else if(data.type == QuestionType.oneWordAnswer){
                     return QuestionWidget(
                        questionNo: "${index + 1}",
                        questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
                        questionDescription:
                        "(পারিবারিক প্রেক্ষাপট রবীন্দ্রনাথ ঠাকুরের জন্ম পারিবারিক বাসভবনে যা কলকাতায় অবস্থিত ছিল)",
                        child: const FillInTheGapAnswerWidget(
                          // data: controller.questions[index],
                        ),
                      );
                    }else {
                     return Text("Written");
                    }
                    // return Text(data[index].name);
                  }),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: 4,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     if(questions[index].type==QuestionType.mcq){
              //       return QuestionWidget(
              //         questionNo: "${index + 1}",
              //         questionText:
              //         questions[index].data.questionText,
              //         child: MCQAnswerWidget(
              //           data: questions[index].data,
              //         ),
              //       );
              //     }else{
              //       Container(color: Colors.black,
              //       height: 100,
              //         width: 100,
              //       );
              //     }
              //   },
              //   // separatorBuilder: (context, index) {
              //   //   return SizedBox(height: size.h20);
              //   // },
              // )
            ],
          ),
        ));
  }
}

class Question {
  QuestionType type;
  final dynamic data;

  Question({
    required this.type,
    required this.data,
  });
}

enum QuestionType {
  mcq,
  fig,
  trueFalse,
  matching,
  oneWordAnswer,
  written,
}
