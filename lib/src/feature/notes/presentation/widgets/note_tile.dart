import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class NoteTile extends StatelessWidget with AppTheme {
  final String noteContent;
  final String title;
  final String timestamp;
  final VoidCallback onPressed;
  final String? reference;
  const NoteTile(
      {super.key,
      required this.noteContent,
      required this.title,
      required this.timestamp,
      required this.onPressed, this.reference});

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
                padding: EdgeInsets.all(size.r12),
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
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h4),
                  reference!=null?Text(reference.toString(),style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: size.textXSmall,fontFamily: StringData.fontFamilyPoppins,
                    color: clr.appPrimaryColorGreen
                  ),):const SizedBox(),
                  Row(
                    mainAxisAlignment: reference!=null?MainAxisAlignment.end:MainAxisAlignment.start,
                    children: [
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
