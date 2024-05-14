import 'package:flutter/material.dart';

import '../../domain/entities/question_data_entity.dart';
import 'written_text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';

class DescriptiveAnswerWidget extends StatefulWidget {
  final QuestionDataEntity data;
  const DescriptiveAnswerWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DescriptiveAnswerWidget> createState() =>
      _DescriptiveAnswerWidgetState();
}

class _DescriptiveAnswerWidgetState extends State<DescriptiveAnswerWidget>
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
    return WrittenTextFieldWidget(
      minLines: 5,
      maxLines: 10,
      onChanged: (e) {
        widget.data.userInput == e;
      },
    );
  }
}
