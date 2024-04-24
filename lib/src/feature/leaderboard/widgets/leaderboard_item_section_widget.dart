import 'package:flutter/material.dart';

import '../../../core/constants/common_imports.dart';

class LeaderboardItemSectionWidget<T> extends StatelessWidget
    with AppTheme, Language {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const LeaderboardItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h16);
      },
    );
  }
}
