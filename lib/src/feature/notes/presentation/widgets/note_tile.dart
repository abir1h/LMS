import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';

class NoteTile extends StatelessWidget with AppTheme {
  final String noteContent;
  final String title;
  final String timestamp;
  final VoidCallback onPressed;
  const NoteTile(
      {super.key,
      required this.noteContent,
      required this.title,
      required this.timestamp,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.h16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: size.w1,
          color: clr.boxStrokeColor,
        ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteContent,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h4),
                  Text(
                    timestamp,
                    style: TextStyle(
                      color: clr.placeHolderTextColorGray,
                      fontWeight: FontWeight.w400,
                      fontSize: size.textXXSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
