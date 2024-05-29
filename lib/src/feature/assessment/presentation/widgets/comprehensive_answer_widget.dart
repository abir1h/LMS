import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import 'written_text_field_widget.dart';

class ComprehensiveAnswerWidget extends StatelessWidget with AppTheme {
  final String optionValue;
  final ValueChanged<String>? onChanged;
  const ComprehensiveAnswerWidget(
      {Key? key, required this.optionValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: optionValue,
          textColor: clr.blackColor,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size.h8),
        WrittenTextFieldWidget(onChanged: onChanged),
      ],
    );
  }
}
