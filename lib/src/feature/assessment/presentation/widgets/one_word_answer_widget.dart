import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'written_text_field_widget.dart';

class OneWordAnswerWidget extends StatefulWidget {
  // final FillInTheGapQuestion data;
  const OneWordAnswerWidget({
    Key? key,
    // required this.data,
  }) : super(key: key);

  @override
  State<OneWordAnswerWidget> createState() => _OneWordAnswerWidgetState();
}

class _OneWordAnswerWidgetState extends State<OneWordAnswerWidget>
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
