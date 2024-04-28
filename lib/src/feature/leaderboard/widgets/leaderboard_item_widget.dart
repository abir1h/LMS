import 'package:flutter/material.dart';

import '../../../core/constants/common_imports.dart';
import '../../../core/utility/app_label.dart';
import '../../dashboard/presentation/widgets/custom_text_widget.dart';

class LeaderboardItemWidget extends StatelessWidget with AppTheme, Language {
  const LeaderboardItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: clr.drawerFillColor,
        borderRadius: BorderRadius.circular(size.w8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.15))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h10),
      child: Row(
        children: [
          CustomTextWidget(
            text: label(e: "1st", b: "১ম"),
            textColor: clr.blackColor,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(width: size.w10 + size.w1),
          Image.asset(ImageAssets.leaderImage),
          SizedBox(width: size.w10 + size.w1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: label(e: en.userNameText, b: bn.userNameText),
                  textColor: clr.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
                SizedBox(height: size.h4),
                CustomTextWidget(
                  text: label(
                      e: "${en.emisId}101353764", b: "${bn.emisId}১০১৩৫৩৭৬৪"),
                  textColor: clr.textColorGray2,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
