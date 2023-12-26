import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/written_text_field_widget.dart';
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
        child: SingleChildScrollView(
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
                    child: const FillInTheGapAnswerWidget(
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

///Fill in the gap section
class FillInTheGapAnswerWidget extends StatefulWidget {
  // final FillInTheGapQuestion data;
  const FillInTheGapAnswerWidget({
    Key? key,
    // required this.data,
  }) : super(key: key);

  @override
  State<FillInTheGapAnswerWidget> createState() =>
      _FillInTheGapAnswerWidgetState();
}

class _FillInTheGapAnswerWidgetState extends State<FillInTheGapAnswerWidget>
    with AppTheme, Language {
  late final TextEditingController _controller;

  @override
  void initState() {
    // _controller = TextEditingController(text: widget.data.writtenAnswer);
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label(e: en.writeOneWordAnswer, b: bn.writeOneWordAnswer),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.textSmall,
              color: clr.blackColor,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(height: size.h8),
        const WrittenTextFieldWidget(),
      ],
    );
  }
}
