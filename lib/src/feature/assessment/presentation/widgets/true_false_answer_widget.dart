import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/question_data_entity.dart';

class TrueFalseAnswerWidget extends StatefulWidget {
  final QuestionDataEntity data;
  const TrueFalseAnswerWidget({
    Key? key,
    required this.data,
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
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.data.options.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1,
              child: Radio(
                activeColor: clr.appPrimaryColorGreen,
                groupValue: groupValue,
                value: index,
                onChanged: (newValue) {
                  setState(() {
                    groupValue = newValue!;
                    widget.data.options[index].userCorrectValue =
                        newValue == 0 ? "true" : "false";
                  });
                  print(groupValue);
                  print(widget.data.options[index].userCorrectValue);
                },
              ),
            ),
            Text(
              label(
                  e: widget.data.options[index].optionValue,
                  b: widget.data.options[index].optionValue),
              style: TextStyle(
                  color: clr.textColorAppleBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
          ],
        ),
        separatorBuilder: (context, index) {
          return SizedBox(height: size.h12);
        },
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Transform.scale(
      //           scale: 1,
      //           child: Radio(
      //             activeColor: clr.appPrimaryColorGreen,
      //             groupValue: groupValue,
      //             value: 0,
      //             onChanged: (newValue) =>
      //                 setState(() => groupValue = newValue!),
      //           ),
      //         ),
      //         Text(
      //           label(e: en.trueText, b: bn.trueText),
      //           style: TextStyle(
      //               color: clr.textColorAppleBlack,
      //               fontSize: size.textSmall,
      //               fontWeight: FontWeight.w500,
      //               fontFamily: StringData.fontFamilyPoppins),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Transform.scale(
      //           scale: 1,
      //           child: Radio(
      //             activeColor: clr.appPrimaryColorGreen,
      //             groupValue: groupValue,
      //             value: 1,
      //             onChanged: (newValue) =>
      //                 setState(() => groupValue = newValue!),
      //           ),
      //         ),
      //         Text(
      //           label(e: en.falseText, b: bn.falseText),
      //           style: TextStyle(
      //               color: clr.textColorAppleBlack,
      //               fontSize: size.textSmall,
      //               fontWeight: FontWeight.w500,
      //               fontFamily: StringData.fontFamilyPoppins),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
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
