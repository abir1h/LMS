import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CircularItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final String? title;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CircularItemSectionWidget(
      {Key? key, this.title, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CustomTextWidget(
            text: title.toString(),
            fontSize: size.textXMedium,
            fontWeight: FontWeight.w500,
            padding: EdgeInsets.only(
                left: size.w16, right: size.w16, bottom: size.h12),
          ),
        items.isNotEmpty
            ? ListView.separated(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                itemBuilder: (context, index) {
                  return buildItem(context, index, items[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.h16);
                },
              )
            : Center(
                child: Column(
                  children: [
                    Lottie.asset(ImageAssets.animEmpty, height: size.h56 * 1.2),
                    CustomTextWidget(
                      text: label(
                          e: "No Running Course Found",
                          b: "কোনো বিজ্ঞপ্তি পাওয়া যায়নি"),
                      textColor: clr.textColorBlack,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
