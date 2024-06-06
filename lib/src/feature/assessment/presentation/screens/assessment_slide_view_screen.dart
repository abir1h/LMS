import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/option_data_entity.dart';
import '../services/assessment_screen_service.dart';
import '../widgets/comprehensive_answer_widget.dart';
import '../widgets/fill_in_the_gap_answer_widget.dart';
import '../widgets/matching_answer_widget.dart';
import '../widgets/mcq_answer_widget.dart';
import '../widgets/question_widget.dart';
import '../widgets/time_digit_widget.dart';
import '../widgets/time_expired_panel_widget.dart';
import '../widgets/true_false_answer_widget.dart';
import '../widgets/written_text_field_widget.dart';

class AssessmentSlideViewScreen extends StatefulWidget {
  final Object? arguments;
  const AssessmentSlideViewScreen({super.key, this.arguments});

  @override
  State<AssessmentSlideViewScreen> createState() =>
      _AssessmentSlideViewScreenState();
}

class _AssessmentSlideViewScreenState extends State<AssessmentSlideViewScreen>
    with AppTheme, Language, AssessmentScreenService {
  @override
  void initState() {
    super.initState();

    initService(widget.arguments as AssessmentScreenArgs);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.assessment, b: bn.assessment),
      resizeToAvoidBottomInset: true,
      leadingBack: onGoBack,
      actionChild: TimeDigitWidget(
        examStateStream: pageStateStreamController.stream,
        timerStream: timerStreamController.stream,
        isExamRunning: (x) => x != null && (x is DataLoadedState),
      ),
      body: AppStreamBuilder<PageState>(
        stream: pageStateStreamController.stream,
        loadingBuilder: (context) => const Center(child: CircularLoader()),
        emptyBuilder: (context, message, icon) => const Offstage(),
        dataBuilder: (context, data) {
          if (data is ExamRunningState) {
            return SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.h12),
                  /*Row(
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
                  SizedBox(height: size.h24),*/
                  Container(
                    color: clr.whiteColor,
                    child: Center(
                      child: StreamBuilder<String>(
                        initialData:
                            "${label(e: "Question", b: "প্রশ্ন")}: ${"${replaceEnglishNumberWithBengali("1")}/${replaceEnglishNumberWithBengali(data.examData.assessment!.questions.length.toString())}"}",
                        stream: questionNumberTextStream.stream,
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
                  Expanded(
                    child: Center(
                      child: PageView.builder(
                        controller: questionPagerController,
                        itemCount: data.examData.assessment!.questions.length,
                        onPageChanged: onQuestionChanged,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, position) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                QuestionWidget(
                                  questionNo: "${position + 1}",
                                  questionText: data
                                              .examData.assessment!.questions
                                              .elementAt(position)
                                              .questionType!
                                              .id !=
                                          4
                                      ? data.examData.assessment!.questions
                                          .elementAt(position)
                                          .question
                                      : "",
                                  child: data.examData.assessment!.questions
                                              .elementAt(position)
                                              .questionType!
                                              .id ==
                                          2
                                      ? MCQWidget(
                                          items: data.examData.assessment!.questions
                                              .elementAt(position)
                                              .options,
                                          builder: (BuildContext context,
                                              int index, item) {
                                            return MCQAnswerOptionWidget(
                                              value: item.optionValue,
                                              imageValue: item.optionImg,
                                              isSelected: item.isSelected,
                                              onTap: () => setState(() {
                                                for (OptionDataEntity optionDataEntity
                                                    in data.examData.assessment!
                                                        .questions
                                                        .elementAt(position)
                                                        .options) {
                                                  if (data.examData.assessment!
                                                          .questions
                                                          .elementAt(position)
                                                          .options
                                                          .indexOf(
                                                              optionDataEntity) !=
                                                      index) {
                                                    optionDataEntity
                                                        .isSelected = false;
                                                    optionDataEntity
                                                            .userCorrectValue =
                                                        optionDataEntity
                                                            .isSelected;
                                                  } else {
                                                    optionDataEntity
                                                            .isSelected =
                                                        !optionDataEntity
                                                            .isSelected;
                                                    item.userCorrectValue =
                                                        optionDataEntity
                                                            .isSelected;
                                                  }
                                                }
                                              }),
                                            );
                                          })
                                      : data.examData.assessment!.questions
                                                  .elementAt(position)
                                                  .questionType!
                                                  .id ==
                                              3
                                          ? MatchingAnswerWidget(
                                              data: data.examData.assessment!
                                                  .questions
                                                  .elementAt(position),
                                              onMatched:
                                                  (int optionId, String value) {
                                                OptionDataEntity option = data
                                                    .examData
                                                    .assessment!
                                                    .questions
                                                    .elementAt(position)
                                                    .options
                                                    .singleWhere((option) =>
                                                        option.id == optionId);
                                                option.userCorrectInput = value;
                                              },
                                            )
                                          : data.examData.assessment!.questions
                                                      .elementAt(position)
                                                      .questionType!
                                                      .id ==
                                                  4
                                              ? FillInTheGapAnswerWidget(
                                                  question: data.examData
                                                      .assessment!.questions
                                                      .elementAt(position)
                                                      .question,
                                                  items: data.examData
                                                      .assessment!.questions
                                                      .elementAt(position)
                                                      .options,
                                                  builder: (BuildContext context, int index, item) {
                                                    return FillInTheGapOptionWidget(
                                                      optionTitle: label(
                                                          e: "ব্ল্যান্ক ${replaceEnglishNumberWithBengali((index + 1).toString())} এর উত্তর লিখুন:",
                                                          b: "ব্ল্যান্ক ${replaceEnglishNumberWithBengali((index + 1).toString())} এর উত্তর লিখুন:"),
                                                      onChanged: (e) {
                                                        item.userInput = e;
                                                      },
                                                    );
                                                  })
                                              : data.examData.assessment!.questions.elementAt(position).questionType!.id == 5
                                                  ? MCQWidget(
                                                      items: data.examData.assessment!.questions.elementAt(position).options,
                                                      builder: (BuildContext context, int index, item) {
                                                        return TruFalseOptionWidget(
                                                          optionValue:
                                                              item.optionKey,
                                                          groupValue: item
                                                              .radioGroupValue,
                                                          index: index,
                                                          onChanged: (v) {
                                                            setState(() {
                                                              item.radioGroupValue =
                                                                  v!;

                                                              for (OptionDataEntity optionDataEntity
                                                                  in data
                                                                      .examData
                                                                      .assessment!
                                                                      .questions
                                                                      .elementAt(
                                                                          position)
                                                                      .options) {
                                                                if (data
                                                                        .examData
                                                                        .assessment!
                                                                        .questions
                                                                        .elementAt(
                                                                            position)
                                                                        .options
                                                                        .indexOf(
                                                                            optionDataEntity) !=
                                                                    index) {
                                                                  optionDataEntity
                                                                          .userCorrectValue =
                                                                      false;
                                                                  optionDataEntity
                                                                      .radioGroupValue = -1;
                                                                } else {
                                                                  item.userCorrectValue =
                                                                      true;
                                                                }
                                                              }
                                                            });
                                                          },
                                                        );
                                                      })
                                                  : data.examData.assessment!.questions.elementAt(position).questionType!.id == 6
                                                      ? WrittenTextFieldWidget(
                                                          minLines: 5,
                                                          maxLines: 10,
                                                          onChanged: (e) {
                                                            data
                                                                .examData
                                                                .assessment!
                                                                .questions
                                                                .elementAt(
                                                                    position)
                                                                .userInput = e;
                                                          },
                                                        )
                                                      : data.examData.assessment!.questions.elementAt(position).questionType!.id == 7
                                                          ? MCQWidget(
                                                              items: data.examData.assessment!.questions.elementAt(position).options,
                                                              builder: (BuildContext context, int index, item) {
                                                                return ComprehensiveAnswerWidget(
                                                                  optionValue: item
                                                                      .optionKey,
                                                                  onChanged:
                                                                      (e) {
                                                                    item.userInput =
                                                                        e;
                                                                  },
                                                                );
                                                              })
                                                          : Container(),
                                )
                              ],
                            ),
                          );
                        }, // Can be null
                      ),
                    ),
                  ),
                  StreamBuilder<Map<String, dynamic>>(
                    initialData: const {
                      "next": "Next",
                      "previous": false,
                    },
                    stream: buttonTextStream.stream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.w16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            snapshot.data!["previous"] != false
                                ? CustomButton(
                                    onTap: () {
                                      onPreviousButtonTap();
                                    },
                                    title:
                                        label(e: "Previous", b: "পূর্ববর্তী"))
                                : const Offstage(),
                            CustomButton(
                                onTap: () => onNextTap(),
                                title: snapshot.data!["next"])
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.h6),
                  SizedBox(
                      height: size.h48,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          StreamBuilder<int>(
                            initialData: 0,
                            stream: pageSelectedIndexStream.stream,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data
                                      .examData.assessment!.questions.length,
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        questionPagerController.animateToPage(
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
                          StreamBuilder<Map<String, dynamic>>(
                            initialData: const {
                              "next": true,
                              "previous": false,
                            },
                            stream: pageArrowButtonStream.stream,
                            builder: (context, snapshot) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  snapshot.data!["previous"] != false
                                      ? GestureDetector(
                                          onTap: () {
                                            scrollController.animateTo(
                                                scrollController
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
                                            scrollController.animateTo(
                                                scrollController
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
                  SizedBox(height: size.h24),
                ],
              ),
            );
          } else if (data is TimeExpiredState) {
            return TimeExpiredPanelWidget(
              examDataEntity: data.examData,
              doSubmitResult: (v) => onSubmitExam(v),
            );
          } else {
            return const Offstage();
          }
        },
      ),
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
  void showExamSubmitDialog() {
    CustomDialogWidget.show(
            context: context,
            icon: Icons.quiz_outlined,
            title: label(
                e: "Answer Submitted Successfully",
                b: "উত্তরপত্র সফলভাবে জমা দেওয়া হয়েছে"),
            infoText: "",
            singleButtonText: label(e: "Close", b: "বন্ধ করুন"),
            singleButton: true)
        .then((value) {
      if (value) {
        ///Force close
        forceClose();
      }
    });
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
