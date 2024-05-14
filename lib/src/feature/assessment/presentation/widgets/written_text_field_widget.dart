import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class WrittenTextFieldWidget extends StatelessWidget with AppTheme {
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final int minLines;
  final int maxLines;
  const WrittenTextFieldWidget(
      {super.key,
      this.textEditingController,
      this.onChanged,
      this.minLines = 1,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        // isDense: true,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: clr.appPrimaryColorGreen, width: size.w1),
          borderRadius: BorderRadius.all(Radius.circular(size.w8)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: clr.boxStrokeColor, width: size.w1),
            borderRadius: BorderRadius.all(Radius.circular(size.w8))),
        hintText: "",
        contentPadding:
            EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
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
    );
  }
}
