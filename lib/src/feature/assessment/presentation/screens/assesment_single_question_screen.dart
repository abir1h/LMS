import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../models/blank_model.dart';
import '../models/matching_question.dart';
import '../models/quiz_model.dart';
import '../widgets/question_panel_widget.dart';
import '../widgets/time_digit_widget.dart';
import 'assessment_all_question_screen.dart';

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
  final StreamController<Map<String, dynamic>> _buttonTextStream =
      StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _pageArrowButtonStream =
      StreamController.broadcast();
  final StreamController<int> _pageSelectedIndexStream =
      StreamController.broadcast();

  final ScrollController _scrollController = ScrollController();

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
    _scrollController.addListener(_scrollValue);
  }

  _scrollValue() {
    if (_scrollController.position.pixels == 0.0) {
      _pageArrowButtonStream.add({
        "next": true,
        "previous": false,
      });
    } else if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _pageArrowButtonStream.add({
        "next": false,
        "previous": true,
      });
    } else {
      _pageArrowButtonStream.add({
        "next": true,
        "previous": true,
      });
    }
  }

  void _onTimerTick(Timer timer) {
    var remaining = timerStreamController.value - const Duration(seconds: 1);
    timerStreamController.add(remaining);
  }

  Future<bool> _onBackPress() {
    // if (_isExamRunning) {
    return CustomDialogWidget.show(
      title: label(e: "Are you Sure?", b: "আপনি কি নিশ্চিত?"),
      icon: Icons.question_mark_sharp,
      context: context,
      leftButtonText: label(e: "Cancel", b: "বাতিল"),
      rightButtonText: label(e: "Yes", b: "হ্যাঁ"),
      infoText: label(
          e: "Do you really want to exit? Your quiz progress will be lost.",
          b: "আপনি কি সত্যিই প্রস্থান করতে চান? আপনার কুইজের অগ্রগতি নষ্ট হবে।"),
    ).then((value) => value);
    // } else {
    //   return Future.value(false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assessment, b: bn.assessment),
        onBack: _onBackPress,
        leadingBack: () {
          _onBackPress().then((value) {
            if (!value) {
              Navigator.pop(context);
            } else {}
          });
        },
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: clr.whiteColor,
                  child: Center(
                    child: StreamBuilder<String>(
                      initialData:
                          "${label(e: "Question", b: "প্রশ্ন")}: ${"${replaceEnglishNumberWithBengali("1")}/${replaceEnglishNumberWithBengali(questions.length.toString())}"}",
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
                StreamBuilder<Map<String, dynamic>>(
                  initialData: const {
                    "next": "Next",
                    "previous": false,
                  },
                  stream: _buttonTextStream.stream,
                  builder: (context, snapshot) {
                    return Container(
                      color: clr.whiteColor,
                      child: Row(
                        children: [
                          snapshot.data!["previous"] != false
                              ? CustomButton(
                                  onTap: () {
                                    _onPreviousButtonTap();
                                  },
                                  title: label(e: "Previous", b: "পূর্ববর্তী"))
                              : const Offstage(),
                          const Spacer(),
                          CustomButton(
                              onTap: () {
                                _onNextTap();
                                if (snapshot.data!["next"] == "Submit") {
                                  _showModal();
                                }
                              },
                              title: snapshot.data!["next"])
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  height: size.h6,
                  color: clr.whiteColor,
                ),
                SizedBox(
                    height: size.h48,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          color: clr.whiteColor,
                          padding: EdgeInsets.symmetric(horizontal: size.h24),
                          child: StreamBuilder<int>(
                            initialData: 0,
                            stream: _pageSelectedIndexStream.stream,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: questions.length,
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _questionPagerController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.h12),
                                        alignment: Alignment.center,
                                        child: snapshot.data != index
                                            ? Text(
                                                label(
                                                    e: "${index + 1}",
                                                    b: replaceEnglishNumberWithBengali(
                                                        "${index + 1}")),
                                                // "${index + 1}",
                                                style: TextStyle(
                                                    color:
                                                        clr.textColorAppleBlack,
                                                    fontSize: size.textMedium,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: clr
                                                        .appPrimaryColorGreen,
                                                    shape: BoxShape.circle),
                                                padding:
                                                    EdgeInsets.all(size.h12),
                                                child: Text(
                                                  label(
                                                      e: "${index + 1}",
                                                      b: replaceEnglishNumberWithBengali(
                                                          "${index + 1}")),
                                                  // "${index + 1}",
                                                  style: TextStyle(
                                                      color: clr.whiteColor,
                                                      fontSize: size.textMedium,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        StreamBuilder<Map<String, dynamic>>(
                          initialData: const {
                            "next": true,
                            "previous": false,
                          },
                          stream: _pageArrowButtonStream.stream,
                          builder: (context, snapshot) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                snapshot.data!["previous"] != false
                                    ? GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(
                                              _scrollController
                                                      .position.pixels -
                                                  150,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: clr.whiteColor),
                                            child: const Icon(
                                                Icons.arrow_back_ios_new)),
                                      )
                                    : const Offstage(),
                                const Spacer(),
                                snapshot.data!["next"] != false
                                    ? GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(
                                              _scrollController
                                                      .position.pixels +
                                                  150,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: clr.whiteColor),
                                            child: const Icon(
                                                Icons.arrow_forward_ios)),
                                      )
                                    : const Offstage(),
                              ],
                            );
                          },
                        ),
                      ],
                    )),
                Container(
                  height: size.h24,
                  color: clr.whiteColor,
                ),
              ],
            ),
          ),
        ));
  }

  _onQuestionChanged(int index) {
    _scrollController.animateTo(index * 32,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    _pageSelectedIndexStream.sink.add(index);
    _questionNumberTextStream.add(
        "${label(e: "Question", b: "প্রশ্ন")}: ${replaceEnglishNumberWithBengali("${index + 1}")} / ${replaceEnglishNumberWithBengali(questions.length.toString())}");
    if (index == questions.length - 1) {
      _buttonTextStream.add({
        "next": label(e: "Submit", b: "সাবমিট"),
        "previous": index == 0 ? false : true,
      });
    } else {
      _buttonTextStream.add({
        "next": label(e: "Next", b: "পরবর্তী"),
        "previous": index == 0 ? false : true,
      });
    }
  }

  _onNextTap() {
    if (_questionPagerController.page?.floor() != questions.length - 1) {
      _questionPagerController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {}
  }

  _onPreviousButtonTap() {
    _questionPagerController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _showModal() {
    CustomDialogWidget.show(
      title: label(e: "Are you Sure?", b: "আপনি কি নিশ্চিত?"),
      icon: Icons.question_mark_sharp,
      context: context,
      leftButtonText: label(e: "Cancel", b: "বাতিল"),
      rightButtonText: label(e: "Submit", b: "সাবমিট"),
      infoText: label(
          e: "Do you want to submit your assessment answer sheet?",
          b: "আপনি কি আপনার মূল্যায়নের উত্তরপত্র জমা দিতে চান ?"),
    ).then((value) => value);
  }
}
