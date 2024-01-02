import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class TrueFalseAnswerWidget extends StatefulWidget {
  // final TrueFalseQuestion data;
  const TrueFalseAnswerWidget({
    Key? key,
    // required this.data,
  }) : super(key: key);

  @override
  State<TrueFalseAnswerWidget> createState() => _TrueFalseAnswerWidgetState();
}

class _TrueFalseAnswerWidgetState extends State<TrueFalseAnswerWidget>
    with AppTheme, Language {
  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.boxStrokeColorSilver, width: size.r1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1,
                child: Radio(
                  activeColor: clr.appPrimaryColorGreen,
                  groupValue: groupValue,
                  value: 0,
                  onChanged: (newValue) =>
                      setState(() => groupValue = newValue!),
                ),
              ),
              Text(
                label(e: en.trueText, b: bn.trueText),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1,
                child: Radio(
                  activeColor: clr.appPrimaryColorGreen,
                  groupValue: groupValue,
                  value: 1,
                  onChanged: (newValue) =>
                      setState(() => groupValue = newValue!),
                ),
              ),
              Text(
                label(e: en.falseText, b: bn.falseText),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSelection() {
    if (mounted) {
      setState(() {
        // widget.data.isSelected = !widget.data.isSelected;
      });
    }
  }
}
