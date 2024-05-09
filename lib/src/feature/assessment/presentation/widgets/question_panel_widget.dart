import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import 'question_widget.dart';
import 'true_false_answer_widget.dart';
import '../screens/assessment_quiz_screen.dart';
import '../screens/assessment_all_question_screen.dart';
import 'descriptive_answer_widget.dart';
import 'fill_in_the_gap_answer_widget.dart';
import 'matching_answer_widget.dart';
import 'one_word_answer_widget.dart';

class QuestionAnswerPanel extends StatefulWidget {
  final PageController controller;
  final List<Question> questions;
  final ValueChanged<int> onQuestionChanged;

  const QuestionAnswerPanel(
      {Key? key,
      required this.controller,
      required this.questions,
      required this.onQuestionChanged})
      : super(key: key);
  @override
  State<QuestionAnswerPanel> createState() => _QuestionAnswerPanelState();
}

class _QuestionAnswerPanelState extends State<QuestionAnswerPanel>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          margin: const EdgeInsets.only(top: 8),
          child: PageView.builder(
            controller: widget.controller,
            itemCount: widget.questions.length,
            onPageChanged: widget.onQuestionChanged,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, position) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (widget.questions.elementAt(position).type ==
                        QuestionType.mcq) ...[
                      QuestionWidget(
                        questionNo: "${position + 1}",
                        questionText: widget.questions
                            .elementAt(position)
                            .data
                            .questionText,
                        child: MCQAnswerWidget(
                          data: widget.questions.elementAt(position).data,
                        ),
                      )
                    ] else if (widget.questions.elementAt(position).type ==
                        QuestionType.fig) ...[
                      QuestionWidget(
                          questionNo: "${position + 1}",
                          questionText:
                              widget.questions.elementAt(position).data.docTitle,
                          child: FillInTheGapAnswerWidget(
                            mainModel:
                                widget.questions.elementAt(position).data,
                            onChangeDv1: (v) {
                              // controller.qusList[index].blank1 = v;
                            },
                            onChangeDv2: (v) {
                              // controller.qusList[index].blank2 = v;
                            },
                          ))
                    ] else if (widget.questions.elementAt(position).type ==
                        QuestionType.matching) ...[
                      QuestionWidget(
                        questionNo: "${position + 1}",
                        questionText: widget.questions
                            .elementAt(position)
                            .data
                            .questionTitle,
                        child: MatchingAnswerWidget(
                          data: widget.questions.elementAt(position).data,
                        ),
                      )
                    ] else if (widget.questions.elementAt(position).type ==
                        QuestionType.oneWordAnswer) ...[
                      QuestionWidget(
                        questionNo: "${position + 1}",
                        questionText:
                            "রবীন্দ্রনাথ ঠাকুর কোথায় জন্ম গ্রহণ করেন?",
                        questionDescription:
                            "(পারিবারিক প্রেক্ষাপট রবীন্দ্রনাথ ঠাকুরের জন্ম পারিবারিক বাসভবনে যা কলকাতায় অবস্থিত ছিল)",
                        child: const OneWordAnswerWidget(
                            // data: controller.questions[index],
                            ),
                      )
                    ] else if (widget.questions.elementAt(position).type ==
                        QuestionType.trueFalse) ...[
                      QuestionWidget(
                        questionNo: "${position + 1}",
                        questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
                        child: const TrueFalseAnswerWidget(),
                      )
                    ] else if (widget.questions.elementAt(position).type ==
                        QuestionType.written) ...[
                      QuestionWidget(
                        questionNo: "${position + 1}",
                        questionText:
                            "আপনি গঠনমূলক মূল্যায়ন সিস্টেম সম্পর্কে কি জানেন?",
                        child: const DescriptiveAnswerWidget(
                            // data: controller.questions[index],
                            ),
                      )
                    ]
                  ],
                ),
              );
            }, // Can be null
          ),
        ),
      ),
    );
  }
}
