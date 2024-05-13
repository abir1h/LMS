import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class RunningItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const RunningItemSectionWidget(
      {Key? key,  required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h16);
      },
    );
  }
}
