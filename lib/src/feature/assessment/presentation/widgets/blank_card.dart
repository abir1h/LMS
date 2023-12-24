import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:lms/src/feature/assessment/presentation/models/blank_model.dart';

import '../../../../core/common_widgets/text_field_widget.dart';
import 'dashed_border.dart';

class BlankCard extends StatefulWidget {
  final BlankModel? mainModel;
  final ValueChanged<String>? onChangedv1;
  final ValueChanged<String>? onChangedv2;

  const BlankCard(
      {super.key, this.mainModel, this.onChangedv1, this.onChangedv2});

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
                    text:
                        widget.mainModel!.title,
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
        TextField(
          onChanged: widget.onChangedv1,
          decoration: InputDecoration(
            // isDense: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: clr.appPrimaryColorGreen, width: size.w1),
              borderRadius: BorderRadius.all(Radius.circular(size.w8)),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: clr.boxStrokeColor, width: size.w1),
                borderRadius: BorderRadius.all(Radius.circular(size.w8))),
            hintText: "",
            contentPadding: EdgeInsets.symmetric(horizontal: size.w12),
            hintStyle: TextStyle(
                color: clr.placeHolderTextColorGray,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyRoboto),
          ),
          style: TextStyle(
              color: clr.textColorBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(
          height: size.h16,
        ),
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
        TextField(
          onChanged: widget.onChangedv2,
          decoration: InputDecoration(
            // isDense: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: clr.appPrimaryColorGreen, width: size.w1),
              borderRadius: BorderRadius.all(Radius.circular(size.w8)),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: clr.boxStrokeColor, width: size.w1),
                borderRadius: BorderRadius.all(Radius.circular(size.w8))),
            hintText: "",
            contentPadding: EdgeInsets.symmetric(horizontal: size.w12),
            hintStyle: TextStyle(
                color: clr.placeHolderTextColorGray,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyRoboto),
          ),
          style: TextStyle(
              color: clr.textColorBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyRoboto),
        ),
        SizedBox(
          height: size.h16,
        ),
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
