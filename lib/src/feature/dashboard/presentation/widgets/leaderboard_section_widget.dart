import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'custom_text_widget.dart';

class LeaderboardSectionWidget<T> extends StatelessWidget
    with AppTheme, Language {
  final VoidCallback onTapSeeAll;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const LeaderboardSectionWidget(
      {Key? key,
      required this.onTapSeeAll,
      required this.items,
      required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: clr.cardFillColorWhite,
          borderRadius: BorderRadius.circular(size.w8),
          border: Border.all(color: clr.cardStrokeColorGrey, width: size.w1)),
      padding: EdgeInsets.symmetric(
          horizontal: size.w4 + size.w22, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidgets(
                text: label(e: en.leaderboard, b: bn.leaderboard),
                textColor: clr.blackColor,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                onTap: onTapSeeAll,
                child: Wrap(
                  children: [
                    CustomTextWidgets(
                      text: label(e: en.seeAll, b: bn.seeAll),
                      textColor: clr.appPrimaryColorGreen,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: size.w8),
                    Icon(
                      Icons.arrow_forward,
                      size: size.r16,
                      color: clr.appPrimaryColorGreen,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.h16 - size.h1),
          ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return buildItem(context, index, items[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: size.h16);
            },
          ),
          SizedBox(height: size.h20 - size.h2),
        ],
      ),
    );
  }
}
