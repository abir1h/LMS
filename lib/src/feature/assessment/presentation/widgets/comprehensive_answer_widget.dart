import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/question_data_entity.dart';
import 'written_text_field_widget.dart';

class ComprehensiveAnswerWidget extends StatefulWidget {
  final QuestionDataEntity data;
  final ValueChanged<String>? onChange;
  const ComprehensiveAnswerWidget({
    Key? key,
    required this.data,
    this.onChange,
  }) : super(key: key);

  @override
  State<ComprehensiveAnswerWidget> createState() =>
      _ComprehensiveAnswerWidgetState();
}

class _ComprehensiveAnswerWidgetState extends State<ComprehensiveAnswerWidget>
    with AppTheme, Language {
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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.data.options.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: widget.data.options[index].optionValue,
            textColor: clr.blackColor,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size.h8),
          WrittenTextFieldWidget(
            onChanged: (e) {
              widget.data.options[index].optionValue == e;
            },
          ),
        ],
      ),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}
