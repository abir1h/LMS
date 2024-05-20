import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../domain/entities/result_data_entity.dart';
import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../widgets/assessment_result_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/option_data_entity.dart';
import '../../domain/entities/question_data_entity.dart';
import '../services/assessment_screen_service.dart';
import '../widgets/comprehensive_answer_widget.dart';
import '../widgets/fill_in_the_gap_answer_widget.dart';
import '../widgets/matching_answer_widget.dart';
import '../widgets/mcq_answer_widget.dart';
import '../widgets/question_list_widget.dart';
import '../widgets/question_widget.dart';
import '../widgets/time_digit_widget.dart';
import '../widgets/time_expired_panel_widget.dart';
import '../widgets/true_false_answer_widget.dart';
import '../widgets/written_text_field_widget.dart';

class AssessmentAllQuestionScreen extends StatefulWidget {
  final Object? arguments;
  const AssessmentAllQuestionScreen({super.key, this.arguments});

  @override
  State<AssessmentAllQuestionScreen> createState() =>
      _AssessmentAllQuestionScreenState();
}

class _AssessmentAllQuestionScreenState
    extends State<AssessmentAllQuestionScreen>
    with AppTheme, Language, AssessmentScreenService {
  @override
  void initState() {
    super.initState();
    initService(widget.arguments as AssessmentScreenArgs);
    // timerStreamController.add(const Duration(minutes: 45));
    // _examTimer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _onTimerTick(_examTimer);
    // });
  }

  //
  // void _onTimerTick(Timer timer) {
  //   var remaining = timerStreamController.value - const Duration(seconds: 1);
  //   timerStreamController.add(remaining);
  // }

  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.assessment, b: bn.assessment),
      resizeToAvoidBottomInset: true,
      leadingBack: onGoBack,
      body: AppStreamBuilder<PageState>(
        stream: pageStateStreamController.stream,
        loadingBuilder: (context) => const Center(child: CircularLoader()),
        emptyBuilder: (context, message, icon) => const Offstage(),
        dataBuilder: (context, data) {
          if (data is ExamRunningState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: size.h12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextWidget(
                        text: label(e: "Total Time:", b: "সর্বমোট সময়:"),
                        textColor: clr.textColorBlack,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: size.w16),
                      TimeDigitWidget(
                        examStateStream: pageStateStreamController.stream,
                        timerStream: timerStreamController.stream,
                        isExamRunning: (x) =>
                            x != null && (x is DataLoadedState),
                      ),
                      SizedBox(width: size.w20)
                    ],
                  ),
                  SizedBox(height: size.h24),
                  CustomTextWidget(
                    text: label(
                        e: data.examData.assessment!.titleEn,
                        b: data.examData.assessment!.titleBn),
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w400,
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                  ),
                  SizedBox(height: size.h16),
                  QuestionListWidget<QuestionDataEntity>(
                    items: data.examData.assessment!.questions,
                    builder: (context, data, index) {
                      ///Todo Fixed After Demo
                      return QuestionWidget(
                        questionNo: replaceEnglishNumberWithBengali(
                            (index + 1).toString()),
                        questionText:
                            data.questionType?.id != 4 ? data.question : "",
                        child: data.questionType?.id == 2
                            ? MCQWidget(
                                items: data.options,
                                builder:
                                    (BuildContext context, int index, item) {
                                  return MCQAnswerOptionWidget(
                                    value: item.optionValue,
                                    imageValue: item.optionImg,
                                    isSelected: item.isSelected,
                                    onTap: () => setState(() {
                                      for (OptionDataEntity optionDataEntity
                                          in data.options) {
                                        if (data.options
                                                .indexOf(optionDataEntity) !=
                                            index) {
                                          optionDataEntity.isSelected = false;
                                          optionDataEntity.userCorrectValue =
                                              "";
                                        } else {
                                          optionDataEntity.isSelected =
                                              !optionDataEntity.isSelected;
                                          item.userCorrectValue =
                                              item.optionValue;
                                        }
                                      }
                                      print(
                                          "Ansewwlelkfekf ${item.userCorrectValue}");
                                    }),
                                  );
                                })
                            : data.questionType?.id == 3
                                ? MatchingAnswerWidget(
                                    data: data,
                                    onMatched: (int optionId, String value) {
                                      OptionDataEntity option = data.options
                                          .singleWhere((option) =>
                                              option.id == optionId);
                                      option.userCorrectInput = value;
                                    },
                                  )
                                : data.questionType?.id == 4
                                    ? FillInTheGapAnswerWidget(
                                        question: data.question,
                                        items: data.options,
                                        builder: (BuildContext context,
                                            int index, item) {
                                          return FillInTheGapOptionWidget(
                                            optionTitle: label(
                                                e: "ব্ল্যান্ক ${replaceEnglishNumberWithBengali((index + 1).toString())} এর উত্তর লিখুন:",
                                                b: "ব্ল্যান্ক ${replaceEnglishNumberWithBengali((index + 1).toString())} এর উত্তর লিখুন:"),
                                            onChanged: (e) {
                                              item.userInput = e;
                                              print(
                                                "Blank  ${item.userInput}",
                                              );
                                            },
                                          );
                                        })
                                    : data.questionType?.id == 5
                                        ? MCQWidget(
                                            items: data.options,
                                            builder: (BuildContext context,
                                                int index, item) {
                                              return TruFalseOptionWidget(
                                                optionValue: item.optionValue,
                                                groupValue: groupValue,
                                                index: index,
                                                onChanged: (v) {
                                                  setState(() {
                                                    groupValue = v!;
                                                    item.userCorrectValue =
                                                        v == 0
                                                            ? "true"
                                                            : "false";
                                                  });
                                                  print(groupValue);
                                                  print(item.userCorrectValue);
                                                },
                                              );
                                            })
                                        : data.questionType?.id == 6
                                            ? WrittenTextFieldWidget(
                                                minLines: 5,
                                                maxLines: 10,
                                                onChanged: (e) {
                                                  data.userInput = e;
                                                },
                                              )
                                            : data.questionType?.id == 7
                                                ? MCQWidget(
                                                    items: data.options,
                                                    builder:
                                                        (BuildContext context,
                                                            int index, item) {
                                                      return ComprehensiveAnswerWidget(
                                                        optionValue:
                                                            item.optionValue,
                                                        onChanged: (e) {
                                                          item.userInput = e;
                                                        },
                                                      );
                                                    })
                                                : Container(),
                      );
                    },
                  ),
                  SizedBox(height: size.h20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w40),
                    child: CustomActionButton<ResultDataEntity>(
                        radius: size.r4,
                        title: label(e: "Submit Answer", b: "জমা দিন"),
                        // controller: _submitButtonController,
                        // onCheck: _showConfirmationDialog,
                        tapAction: () => onSubmitExam(data.examData),
                        onSuccess: (x) {
                          examTimer.cancel();
                          onExamResultSubmitted(x);
                        }),
                  ),
                  SizedBox(height: size.h64),
                ],
              ),
            );
          } else if (data is TimeExpiredState) {
            return TimeExpiredPanelWidget(
              examDataEntity: data.examData,
              doSubmitResult: (v) => onSubmitExam(v),
            );
          } else if (data is AnswerSubmittedState) {
            return AssessmentResultWidget(data: data.resultData);
          } else {
            return const Offstage();
          }
        },
      ),
      // SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   padding:
      //       EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // QuestionListWidget(
      //       //     // items: questions,
      //       //     items: [],
      //       //     builder: (context, data, index) {
      //       //       if (data.type == QuestionType.mcq) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText: questions[index].data.questionText,
      //       //         //   child: MCQAnswerWidget(
      //       //         //     data: questions[index].data,
      //       //         //   ),
      //       //         // );
      //       //       } else if (data.type == QuestionType.matching) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText: questions[index].data.questionTitle,
      //       //         //   child: MatchingAnswerWidget(
      //       //         //     data: questions[index].data,
      //       //         //   ),
      //       //         // );
      //       //       } else if (data.type == QuestionType.fig) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText: questions[index].data.docTitle,
      //       //         //   child: FillInTheGapAnswerWidget(
      //       //         //     mainModel: questions[index].data,
      //       //         //     onChangeDv1: (v) {
      //       //         //       // controller.qusList[index].blank1 = v;
      //       //         //     },
      //       //         //     onChangeDv2: (v) {
      //       //         //       // controller.qusList[index].blank2 = v;
      //       //         //     },
      //       //         //   ),
      //       //         // );
      //       //       } else if (data.type == QuestionType.trueFalse) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText: "বাংলাদেশের জাতীয় ফল কাঁঠাল",
      //       //         //   child: const TrueFalseAnswerWidget(),
      //       //         // );
      //       //       } else if (data.type == QuestionType.oneWordAnswer) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText:
      //       //         //       "রবীন্দ্রনাথ ঠাকুর কোথায় জন্ম গ্রহণ করেন?",
      //       //         //   questionDescription:
      //       //         //       "(পারিবারিক প্রেক্ষাপট রবীন্দ্রনাথ ঠাকুরের জন্ম পারিবারিক বাসভবনে যা কলকাতায় অবস্থিত ছিল)",
      //       //         //   child: const OneWordAnswerWidget(
      //       //         //       // data: controller.questions[index],
      //       //         //       ),
      //       //         // );
      //       //       } else if (data.type == QuestionType.written) {
      //       //         return Container();
      //       //         // return QuestionWidget(
      //       //         //   questionNo: "${index + 1}",
      //       //         //   questionText:
      //       //         //       "আপনি গঠনমূলক মূল্যায়ন সিস্টেম সম্পর্কে কি জানেন?",
      //       //         //   child: const DescriptiveAnswerWidget(
      //       //         //       // data: controller.questions[index],
      //       //         //       ),
      //       //         // );
      //       //       } else {
      //       //         return const Text("Written");
      //       //       }
      //       //       // return Text(data[index].name);
      //       //     }),
      //       // SizedBox(height: size.h16),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           CustomButton(
      //             onTap: () {
      //               CustomToasty.of(context)
      //                   .showSuccess("সফলভাবে জমাদান সম্পন্ন হয়েছে");
      //               Navigator.of(context).pop();
      //             },
      //             title: label(e: en.submit, b: bn.submit),
      //             horizontalPadding: size.w20,
      //             verticalPadding: size.h4,
      //             radius: size.r4,
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: size.h64),
      //     ],
      //   ),
      // )
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showExamCancellationDialog() {
    CustomDialogWidget.show(
      context: context,
      title: label(e: "Are You Sure?", b: "আপনি কি নিশ্চিত?"),
      infoText: label(
          e: "Do you want to cancel the test? Your answer(s) will not be submitted.\n\nBut, your participation quota will still be reduced.",
          b: "আপনি পরীক্ষা বাতিল করতে চান? আপনার উত্তরগুলি জমা দেওয়া হবে না৷\n\nকিন্তু, আপনার অংশগ্রহণের কোটা হ্রাস করা হবে৷"),
      leftButtonText: label(e: en.cancelText, b: bn.cancelText),
      rightButtonText: label(e: en.exitText, b: bn.exitText),
    ).then((value) {
      if (value) {
        ///Force close
        forceClose();
      }
    });
  }

  @override
  void forceClose() {
    Navigator.of(context).pop();
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
