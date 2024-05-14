import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/utility/app_label.dart';
import 'package:lms/src/feature/dashboard/presentation/widgets/custom_text_widget.dart';

import '../../domain/entities/question_data_entity.dart';
import 'written_text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../models/blank_model.dart';
import 'dashed_border.dart';

class FillInTheGapAnswerWidget extends StatefulWidget {
  final QuestionDataEntity data;

  const FillInTheGapAnswerWidget({super.key, required this.data});

  @override
  State<FillInTheGapAnswerWidget> createState() =>
      _FillInTheGapAnswerWidgetState();
}

class _FillInTheGapAnswerWidgetState extends State<FillInTheGapAnswerWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSentence(sentence: widget.data.question ?? ''),
        SizedBox(height: size.h16),
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.data.options.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text:
                    "ব্ল্যান্ক ${replaceEnglishNumberWithBengali((index + 1).toString())} এর উত্তর লিখুন:",
                textColor: clr.blackColor,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: size.h8),
              WrittenTextFieldWidget(onChanged: (e) {
                widget.data.options[index].userInput = e;
                print("Blank  ${widget.data.options[index].userInput}");
              }),
            ],
          ),
          separatorBuilder: (context, index) {
            return SizedBox(height: size.h12);
          },
        ),
        // Text(
        //   "ব্ল্যান্ক ১ এর উত্তর লিখুন:",
        //   style: TextStyle(
        //       fontWeight: FontWeight.w400,
        //       fontSize: size.textSmall,
        //       color: clr.blackColor,
        //       fontFamily: StringData.fontFamilyRoboto),
        // ),
        // SizedBox(height: size.h8),
        // WrittenTextFieldWidget(onChanged: widget.onChangeDv1),
        // SizedBox(height: size.h16),
        // Text(
        //   "ব্ল্যান্ক ২ এর উত্তর লিখুন:",
        //   style: TextStyle(
        //       fontWeight: FontWeight.w400,
        //       fontSize: size.textSmall,
        //       color: clr.blackColor,
        //       fontFamily: StringData.fontFamilyRoboto),
        // ),
        // SizedBox(height: size.h8),
        // WrittenTextFieldWidget(onChanged: widget.onChangeDv2),
      ],
    );
  }

  // Widget buildSentence(String value) {
  //   String sentence =
  //       'রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|';
  //   List<String> sentenceParts = sentence.split(' ');
  //
  //   return Wrap(
  //     runSpacing: -8,
  //     crossAxisAlignment: WrapCrossAlignment.start,
  //     children: List.generate(
  //       sentenceParts.length,
  //       (index) {
  //         if (sentenceParts[index] == '_____') {
  //           return buildBlank(index);
  //         } else {
  //           return Padding(
  //             padding: EdgeInsets.only(bottom: size.h12, right: 10),
  //             child: Text(
  //               sentenceParts[index],
  //               softWrap: true,
  //               textAlign: TextAlign.justify,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontFamily: StringData.fontFamilyRoboto,
  //                 fontSize: size.textSmall,
  //                 color: clr.blackColor,
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  //
  // Widget buildBlank(int index) {
  //   return Container(
  //     color: clr.whiteColor,
  //     child: DashedRect(
  //       color: clr.gapStrokeGrey,
  //       strokeWidth: 2.0,
  //       gap: 3.0,
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
  //         child: Text(
  //           "ব্ল্যান্ক ১",
  //           style: TextStyle(
  //             fontWeight: FontWeight.w400,
  //             fontFamily: StringData.fontFamilyRoboto,
  //             fontSize: size.textXXSmall,
  //             color: clr.blackColor,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class BuildSentence extends StatelessWidget with AppTheme {
  final String sentence;
  const BuildSentence({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    List<String> sentenceParts = sentence.split(' ');

    return Wrap(
      runSpacing: -8,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(
        sentenceParts.length,
        (index) {
          if (sentenceParts[index].contains("{{")) {
            return const BuildBlank();
          } else {
            return Padding(
              padding: EdgeInsets.only(bottom: size.h12, right: 10),
              child: Text(
                sentenceParts[index],
                softWrap: true,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyRoboto,
                  fontSize: size.textSmall,
                  color: clr.blackColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class BuildBlank extends StatelessWidget with AppTheme {
  const BuildBlank({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: clr.whiteColor,
      margin: EdgeInsets.only(right: size.w6),
      child: DashedRect(
        color: clr.gapStrokeGrey,
        strokeWidth: 2.0,
        gap: 3.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
          child: Text(
            "ব্ল্যান্ক",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyRoboto,
              fontSize: size.textXXSmall,
              color: clr.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
