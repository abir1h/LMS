import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';

class QuestionListWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, T data, int index) builder;
  const QuestionListWidget(
      {Key? key, required this.items, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => builder(context, items[index], index),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}
