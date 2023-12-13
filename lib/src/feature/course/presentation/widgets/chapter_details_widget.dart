import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class ChapterDetailsWidget extends StatelessWidget with AppTheme {
  final String description;
  const ChapterDetailsWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(
                color: clr.textColorBlack,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyPoppins),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
