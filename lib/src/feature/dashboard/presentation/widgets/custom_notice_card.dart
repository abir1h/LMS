import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';

class CustomNoticeCard extends StatelessWidget with AppTheme {
  final Widget leading;
  final String title;
  const CustomNoticeCard(
      {super.key, required this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          SizedBox(width: size.w16),
          Expanded(
              flex: 1,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: clr.textColorBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyRoboto),
              ))
        ],
      ),
    );
  }
}
