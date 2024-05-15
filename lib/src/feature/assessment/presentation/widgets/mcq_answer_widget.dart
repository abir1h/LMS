import 'package:flutter/material.dart';

import '../../domain/entities/option_data_entity.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/question_data_entity.dart';

class MCQWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  const MCQWidget({super.key, required this.items, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => builder(context, index, items[index]),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

///MCQ Options
class MCQAnswerOptionWidget extends StatefulWidget {
  final String value;
  final String imageValue;
  final bool isSelected;
  final VoidCallback onTap;
  const MCQAnswerOptionWidget(
      {Key? key,
      required this.value,
      required this.imageValue,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  State<MCQAnswerOptionWidget> createState() => _MCQAnswerOptionWidgetState();
}

class _MCQAnswerOptionWidgetState extends State<MCQAnswerOptionWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
        decoration: BoxDecoration(
            color: widget.isSelected ? clr.drawerFillColor : clr.whiteColor,
            borderRadius: BorderRadius.circular(size.r8),
            border: Border.all(color: clr.boxStrokeColor, width: size.r1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.isSelected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
              size: size.r24,
              color: widget.isSelected
                  ? clr.appPrimaryColorGreen
                  : clr.gapStrokeGrey,
            ),
            SizedBox(width: size.w24),
            if (widget.imageValue.isNotEmpty) Image.asset(widget.imageValue),
            if (widget.value.isNotEmpty)
              Expanded(
                child: Text(
                  widget.value,
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

///Previous One
class MCQAnswerWidget extends StatefulWidget {
  // final QuestionsEntity data;
  final QuestionDataEntity data;
  const MCQAnswerWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<MCQAnswerWidget> createState() => _MCQAnswerWidgetState();
}

class _MCQAnswerWidgetState extends State<MCQAnswerWidget> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.data.options.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => MCQAnswerOptionWidget(
        value: widget.data.options[index].optionValue,
        imageValue: widget.data.options[index].optionImg,
        isSelected: widget.data.options[index].isSelected,
        onTap: () => setState(() {
          for (OptionDataEntity optionDataEntity in widget.data.options) {
            if (widget.data.options.indexOf(optionDataEntity) != index) {
              optionDataEntity.isSelected = false;
            } else {
              optionDataEntity.isSelected = !optionDataEntity.isSelected;
              widget.data.options[index].userCorrectValue =
                  widget.data.options[index].optionValue;
            }
          }
          print(
              "Ansewwlelkfekf ${widget.data.options[index].userCorrectValue}");
        }),
      ),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.data.options.length,
        (index) => MCQAnswerOptionWidget(
          value: widget.data.options[index].optionValue,
          imageValue: "",
          isSelected: false,
          onTap: () => setState(() {
            // widget.data.userAnswer1 = !widget.data.userAnswer1;
            // widget.data.userAnswer2
            //     ? widget.data.userAnswer2 = !widget.data.userAnswer2
            //     : widget.data.userAnswer2;
            // widget.data.userAnswer3
            //     ? widget.data.userAnswer3 = !widget.data.userAnswer3
            //     : widget.data.userAnswer3;
            // widget.data.userAnswer4
            //     ? widget.data.userAnswer4 = !widget.data.userAnswer4
            //     : widget.data.userAnswer4;
          }),
        ),
      ),
      // children: [
      //   MCQAnswerOptionWidget(
      //     value: widget.data.option1,
      //     imageValue: widget.data.option1Image,
      //     isSelected: widget.data.userAnswer1,
      //     onTap: () => setState(() {
      //       widget.data.userAnswer1 = !widget.data.userAnswer1;
      //       widget.data.userAnswer2
      //           ? widget.data.userAnswer2 = !widget.data.userAnswer2
      //           : widget.data.userAnswer2;
      //       widget.data.userAnswer3
      //           ? widget.data.userAnswer3 = !widget.data.userAnswer3
      //           : widget.data.userAnswer3;
      //       widget.data.userAnswer4
      //           ? widget.data.userAnswer4 = !widget.data.userAnswer4
      //           : widget.data.userAnswer4;
      //     }),
      //   ),
      //   SizedBox(height: size.h12),
      //   MCQAnswerOptionWidget(
      //     value: widget.data.option2,
      //     imageValue: widget.data.option2Image,
      //     isSelected: widget.data.userAnswer2,
      //     onTap: () => setState(() {
      //       widget.data.userAnswer2 = !widget.data.userAnswer2;
      //       widget.data.userAnswer1
      //           ? widget.data.userAnswer1 = !widget.data.userAnswer1
      //           : widget.data.userAnswer1;
      //       widget.data.userAnswer3
      //           ? widget.data.userAnswer3 = !widget.data.userAnswer3
      //           : widget.data.userAnswer3;
      //       widget.data.userAnswer4
      //           ? widget.data.userAnswer4 = !widget.data.userAnswer4
      //           : widget.data.userAnswer4;
      //     }),
      //   ),
      //   SizedBox(height: size.h12),
      //   MCQAnswerOptionWidget(
      //     value: widget.data.option3,
      //     imageValue: widget.data.option3Image,
      //     isSelected: widget.data.userAnswer3,
      //     onTap: () => setState(() {
      //       widget.data.userAnswer3 = !widget.data.userAnswer3;
      //       widget.data.userAnswer1
      //           ? widget.data.userAnswer1 = !widget.data.userAnswer1
      //           : widget.data.userAnswer1;
      //       widget.data.userAnswer2
      //           ? widget.data.userAnswer2 = !widget.data.userAnswer2
      //           : widget.data.userAnswer2;
      //       widget.data.userAnswer4
      //           ? widget.data.userAnswer4 = !widget.data.userAnswer4
      //           : widget.data.userAnswer4;
      //     }),
      //   ),
      //   SizedBox(height: size.h12),
      //   MCQAnswerOptionWidget(
      //     value: widget.data.option4,
      //     imageValue: widget.data.option4Image,
      //     isSelected: widget.data.userAnswer4,
      //     onTap: () => setState(() {
      //       widget.data.userAnswer4 = !widget.data.userAnswer4;
      //       widget.data.userAnswer1
      //           ? widget.data.userAnswer1 = !widget.data.userAnswer1
      //           : widget.data.userAnswer1;
      //       widget.data.userAnswer2
      //           ? widget.data.userAnswer2 = !widget.data.userAnswer2
      //           : widget.data.userAnswer2;
      //       widget.data.userAnswer3
      //           ? widget.data.userAnswer3 = !widget.data.userAnswer3
      //           : widget.data.userAnswer3;
      //     }),
      //   ),
      // ],
    );
  }
}
