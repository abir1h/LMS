import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'written_text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../models/blank_model.dart';
import 'dashed_border.dart';

class FillInTheGapAnswerWidget extends StatefulWidget {
  final BlankModel? mainModel;
  final ValueChanged<String>? onChangeDv1;
  final ValueChanged<String>? onChangeDv2;

  const FillInTheGapAnswerWidget(
      {super.key, this.mainModel, this.onChangeDv1, this.onChangeDv2});

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
        BuildSentence(sentence: widget.mainModel!.description ?? ''),
        SizedBox(height: size.h16),
        Text(
          "ব্ল্যান্ক ১ এর উত্তর লিখুন:",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.textSmall,
              color: clr.blackColor,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(height: size.h8),
        WrittenTextFieldWidget(onChanged: widget.onChangeDv1),
        SizedBox(height: size.h16),
        Text(
          "ব্ল্যান্ক ২ এর উত্তর লিখুন:",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.textSmall,
              color: clr.blackColor,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(height: size.h8),
        WrittenTextFieldWidget(onChanged: widget.onChangeDv2),
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
          if (sentenceParts[index] == '_____') {
            return BuildBlank(index: index);
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
  final int index;
  const BuildBlank({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: clr.whiteColor,
      child: DashedRect(
        color: clr.gapStrokeGrey,
        strokeWidth: 2.0,
        gap: 3.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
          child: Text(
            "ব্ল্যান্ক ১",
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
