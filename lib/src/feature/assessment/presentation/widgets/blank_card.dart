import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/feature/assessment/presentation/widgets/written_text_field_widget.dart';

import '../../../../core/constants/common_imports.dart';
import '../models/blank_model.dart';
import 'dashed_border.dart';

class BlankCard extends StatefulWidget {
  final BlankModel? mainModel;
  final ValueChanged<String>? onChangeDv1;
  final ValueChanged<String>? onChangeDv2;

  const BlankCard(
      {super.key, this.mainModel, this.onChangeDv1, this.onChangeDv2});

  @override
  State<BlankCard> createState() => _BlankCardState();
}

class _BlankCardState extends State<BlankCard> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
            textAlign: TextAlign.justify,
            TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: StringData.fontFamilyPoppins,
                  fontSize: size.textSmall,
                  color: clr.blackColor,
                ),
                text: 'প্রশ্ন ১.',
                children: <InlineSpan>[
                  TextSpan(
                    text: widget.mainModel!.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      color: clr.blackColor,
                    ),
                  )
                ])),
        SizedBox(
          height: size.h12,
        ),
        buildSentence(widget.mainModel!.description ?? ''),
        SizedBox(
          height: size.h16,
        ),
        Text(
          "ব্ল্যান্ক ১ এর উত্তর লিখুন:",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.textSmall,
              color: clr.blackColor,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(
          height: size.h8,
        ),
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
        SizedBox(
          height: size.h8,
        ),
        WrittenTextFieldWidget(onChanged: widget.onChangeDv2),
        SizedBox(height: size.h16),
      ],
    );
  }

  Widget buildSentence(String value) {
    String sentence =
        'রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|';
    List<String> sentenceParts = sentence.split(' ');

    return Wrap(
      runSpacing: -8,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(
        sentenceParts.length,
        (index) {
          if (sentenceParts[index] == '_____') {
            return buildBlank(index);
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

  Widget buildBlank(int index) {
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
