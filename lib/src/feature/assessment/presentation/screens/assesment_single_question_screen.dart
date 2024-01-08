import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../models/blank_model.dart';
import '../models/matching_question.dart';
import '../models/quiz_model.dart';
import '../widgets/descriptive_answer_widget.dart';
import '../widgets/fill_in_the_gap_answer_widget.dart';
import '../widgets/matching_answer_widget.dart';
import '../widgets/one_word_answer_widget.dart';
import '../widgets/question_list_widget.dart';
import '../widgets/question_panel_widget.dart';
import '../widgets/question_widget.dart';
import '../widgets/time_digit_widget.dart';
import '../widgets/true_false_answer_widget.dart';
import 'assessment_quiz_screen.dart';
import 'assessment_screen.dart';

class AssessmentSingleQuestionScreen extends StatefulWidget {
  const AssessmentSingleQuestionScreen({super.key});

  @override
  State<AssessmentSingleQuestionScreen> createState() =>
      _AssessmentSingleQuestionScreenState();
}

class _AssessmentSingleQuestionScreenState
    extends State<AssessmentSingleQuestionScreen> with AppTheme, Language {
  final BehaviorSubject<Duration> timerStreamController = BehaviorSubject();
  final Stream<DataState> pageStateStreamController = const Stream.empty();
  final StreamController<String> _questionNumberTextStream =
      StreamController.broadcast();
  late ScrollController _scrollController;

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
        userAnswer1: false,
        userAnswer2: false,
        userAnswer3: false,
        userAnswer4: false,
        userAnswer5: false,
        answer1: false,
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
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি  _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.fig,
      data: BlankModel(
          fillInTheGapModelId: 0,
          title:
              "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
          description:
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.trueFalse,
      data: "",
    ),
    Question(
        type: QuestionType.matching,
        data: MatchingQuestions(
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
      type: QuestionType.oneWordAnswer,
      data: "",
    ),
    Question(
      type: QuestionType.written,
      data: "",
    ),
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
        userAnswer1: false,
        userAnswer2: false,
        userAnswer3: false,
        userAnswer4: false,
        userAnswer5: false,
        answer1: false,
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
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি  _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.fig,
      data: BlankModel(
          fillInTheGapModelId: 0,
          title:
              "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
          description:
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.trueFalse,
      data: "",
    ),
    Question(
        type: QuestionType.matching,
        data: MatchingQuestions(
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
      type: QuestionType.oneWordAnswer,
      data: "",
    ),
    Question(
      type: QuestionType.written,
      data: "",
    ),
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
        userAnswer1: false,
        userAnswer2: false,
        userAnswer3: false,
        userAnswer4: false,
        userAnswer5: false,
        answer1: false,
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
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি  _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.fig,
      data: BlankModel(
          fillInTheGapModelId: 0,
          title:
              "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
          description:
              "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____  সালে এটি অর্জন করেন|"),
    ),
    Question(
      type: QuestionType.trueFalse,
      data: "",
    ),
    Question(
        type: QuestionType.matching,
        data: MatchingQuestions(
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
      type: QuestionType.oneWordAnswer,
      data: "",
    ),
    Question(
      type: QuestionType.written,
      data: "",
    ),
  ];
  late Timer _examTimer;
  var remaining;
  final PageController _questionPagerController = PageController();

  @override
  void initState() {
    super.initState();
    timerStreamController.add(const Duration(minutes: 45));
    _examTimer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onTimerTick(_examTimer);
    });
  }

  void _onTimerTick(Timer timer) {
    var remaining = timerStreamController.value - const Duration(seconds: 1);
    timerStreamController.add(remaining);
  }

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
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: StreamBuilder<String>(
                  initialData: "",
                  stream: _questionNumberTextStream.stream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: questions.length,
              //     scrollDirection:Axis.horizontal,
              //     physics: const BouncingScrollPhysics(),
              //     padding: EdgeInsets.only(bottom: size.h64 * 2),
              //     itemBuilder: (_, index) {
              //       GestureDetector(
              //         child: Container(
              //           color: Colors.red,
              //           child: Text("$index",style: TextStyle(color: Colors.black),),
              //         ),
              //       );
              //     }),
              QuestionAnswerPanel(
                controller: _questionPagerController,
                questions: questions,
                onQuestionChanged: _onQuestionChanged,
              ),
              Container(
                  height: size.h48,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: size.h24),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: questions.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _questionPagerController.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.h12),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        color: clr.textColorAppleBlack,
                                        fontSize: size.textMedium,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(color: clr.whiteColor),
                              child: const Icon(Icons.arrow_back_ios_new)),
                          Spacer(),
                          Container(
                              decoration: BoxDecoration(color: clr.whiteColor),
                              child: const Icon(Icons.arrow_forward_ios)),
                        ],
                      )
                    ],
                  )),
              SizedBox(height: size.h24),
            ],
          ),
        ));
  }

  _onQuestionChanged(int index) {
    _questionNumberTextStream.add(
        "${label(e: "Question", b: "প্রশ্ন")}: ${index + 1} / ${questions.length}");
    if (index == questions.length - 1) {
    } else {}
  }

}
