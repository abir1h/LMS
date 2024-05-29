import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class TruFalseOptionWidget extends StatelessWidget with AppTheme {
  final String optionValue;
  final int groupValue;
  final int index;
  final ValueChanged<int?>? onChanged;
  TruFalseOptionWidget(
      {super.key,
      required this.optionValue,
      required this.groupValue,
      required this.index,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Radio(
            activeColor: clr.appPrimaryColorGreen,
            groupValue: groupValue,
            value: index,
            onChanged: onChanged,
          ),
        ),
        Text(
          optionValue,
          style: TextStyle(
              color: clr.textColorAppleBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              fontFamily: StringData.fontFamilyPoppins),
        ),
      ],
    );
  }
}
