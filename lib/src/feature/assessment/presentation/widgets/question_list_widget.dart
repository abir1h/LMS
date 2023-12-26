import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';

class QuestionListWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T data, int index) builder;
  const QuestionListWidget(
      {Key? key, required this.items, required this.builder})
      : super(key: key);

  @override
  State<QuestionListWidget<T>> createState() => _QuestionListWidgetState<T>();
}

class _QuestionListWidgetState<T> extends State<QuestionListWidget<T>>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          widget.builder(context, widget.items[index], index),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h20);
      },
    );
  }
}