import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import 'written_text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import 'dashed_border.dart';

class FillInTheGapAnswerWidget<T> extends StatelessWidget with AppTheme {
  final String question;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  const FillInTheGapAnswerWidget(
      {super.key,
      required this.question,
      required this.items,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSentence(sentence: question),
        SizedBox(height: size.h16),
        ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              builder(context, index, items[index]),
          separatorBuilder: (context, index) {
            return SizedBox(height: size.h12);
          },
        ),
      ],
    );
  }
}

class FillInTheGapOptionWidget extends StatelessWidget with AppTheme {
  final String optionTitle;
  final ValueChanged<String>? onChanged;
  const FillInTheGapOptionWidget(
      {super.key, required this.optionTitle, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: optionTitle,
          textColor: clr.blackColor,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size.h8),
        WrittenTextFieldWidget(onChanged: onChanged),
      ],
    );
  }
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
