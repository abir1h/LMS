import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AssessmentQuizScreen extends StatefulWidget {
  const AssessmentQuizScreen({super.key});

  @override
  State<AssessmentQuizScreen> createState() => _AssessmentQuizScreenState();
}

class _AssessmentQuizScreenState extends State<AssessmentQuizScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "Quiz", b: "কুইজ"),
        child: SingleChildScrollView(
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
              ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    questionNo: "${index + 1}",
                    questionText:
                        "শেখার জন্য শিক্ষাদানের প্রযুক্তি হল তাদের শিক্ষা, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো সময়?",
                    child: MCQAnswerWidget(
                        // data: data,
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
                    onTap: () {},
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

///QuestionList
class QuestionListWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T data, int index) builder;
  const QuestionListWidget(
      {Key? key, required this.items, required this.builder})
      : super(key: key);

  @override
  State<QuestionListWidget<T>> createState() => _QuestionListWidgetState<T>();
}

class _QuestionListWidgetState<T> extends State<QuestionListWidget<T>>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          widget.builder(context, widget.items[index], index),
      separatorBuilder: (context, index) {
        return Container(
          height: size.h1,
          margin: EdgeInsets.only(left: size.w56, right: size.h20),
          width: double.maxFinite,
          color: clr.dividerStrokeColorGrey,
        );
      },
    );
  }
}

///Question Title
class QuestionWidget extends StatelessWidget with AppTheme {
  final String questionText;
  final Widget child;
  final String questionNo;
  const QuestionWidget(
      {Key? key,
      required this.questionText,
      required this.child,
      required this.questionNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: label(
                e: "Question ${questionNo.trim()}. ",
                b: "প্রশ্ন ${questionNo.trim()}. "),
            style: TextStyle(
              color: clr.blackColor,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w700,
              fontFamily: StringData.fontFamilyPoppins,
            ),
            children: [
              TextSpan(
                text: questionText.trim(),
                style: TextStyle(
                  color: clr.blackColor,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins,
                ),
              ),
            ])),
        SizedBox(height: size.h10),
        Flexible(
          child: child,
        ),
      ],
    );
  }
}

///MCQ Section
class MCQAnswerWidget extends StatefulWidget {
  // final Questions data;
  const MCQAnswerWidget({
    Key? key,
    // required this.data,
  }) : super(key: key);

  @override
  State<MCQAnswerWidget> createState() => _MCQAnswerWidgetState();
}

class _MCQAnswerWidgetState extends State<MCQAnswerWidget> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MCQAnswerOptionWidget(
          value: "উত্তর বিকল্প ১",
          isSelected: false,
          onTap: () => setState(() {
            true;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: "উত্তর বিকল্প ২",
          isSelected: false,
          onTap: () => setState(() {
            true;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: "উত্তর বিকল্প ৩",
          isSelected: true,
          onTap: () => setState(() {
            true;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: "উত্তর বিকল্প ৪",
          isSelected: false,
          onTap: () => setState(() {
            true;
          }),
        ),
        SizedBox(height: size.h12),
        MCQAnswerOptionWidget(
          value: "উত্তর বিকল্প ৫",
          isSelected: false,
          onTap: () => setState(() {
            true;
          }),
        ),

        // ///Option 1
        // MCQAnswerOptionWidget(
        //   value: widget.data.option1,
        //   isSelected: widget.data.userAnswer1,
        //   onTap: () => setState(() {
        //     widget.data.userAnswer1 = !widget.data.userAnswer1;
        //   }),
        // ),
        //
        // ///Option 2
        // MCQAnswerOptionWidget(
        //   value: widget.data.option2,
        //   isSelected: widget.data.userAnswer2,
        //   onTap: () => setState(() {
        //     widget.data.userAnswer2 = !widget.data.userAnswer2;
        //   }),
        // ),
        //
        // ///Option 3
        // MCQAnswerOptionWidget(
        //   value: widget.data.option3,
        //   isSelected: widget.data.userAnswer3,
        //   onTap: () => setState(() {
        //     widget.data.userAnswer3 = !widget.data.userAnswer3;
        //   }),
        // ),
        //
        // ///Option 4
        // MCQAnswerOptionWidget(
        //   value: widget.data.option4,
        //   isSelected: widget.data.userAnswer4,
        //   onTap: () => setState(() {
        //     widget.data.userAnswer4 = !widget.data.userAnswer4;
        //   }),
        // ),
      ],
    );
  }
}

///MCQ Options
class MCQAnswerOptionWidget extends StatefulWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;
  const MCQAnswerOptionWidget(
      {Key? key,
      required this.value,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  State<MCQAnswerOptionWidget> createState() => _MCQAnswerOptionWidgetState();
}

class _MCQAnswerOptionWidgetState extends State<MCQAnswerOptionWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
        decoration: BoxDecoration(
            color: widget.isSelected ? clr.drawerFillColor : clr.whiteColor,
            borderRadius: BorderRadius.circular(size.r8),
            border: Border.all(color: clr.boxStrokeColor, width: size.r1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: size.r24,
              color: widget.isSelected
                  ? clr.appPrimaryColorGreen
                  : clr.boxStrokeColor,
            ),
            SizedBox(width: size.w24),
            Expanded(
              child: Text(
                widget.value,
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
