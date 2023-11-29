import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart';

class CustomEmptyWidget extends StatelessWidget with AppTheme {
  final IconData icon;
  final String title;
  final String message;

  const CustomEmptyWidget(
      {super.key,
      this.icon = Icons.content_paste_off,
      this.title = StringData.noFileFoundText,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 100.r, color: clr.iconColorWhiteIce),
              SizedBox(height: size.h20),
              Text(
                title,
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Text(
                message,
                style: TextStyle(
                    color: clr.textColorBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h4 + size.h32),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w32, vertical: size.h8),
                decoration: BoxDecoration(
                    color: clr.appPrimaryColorGreen,
                    borderRadius: BorderRadius.circular(size.w1 + size.w4)),
                child: Text(
                  StringData.backToHomeText,
                  style: TextStyle(
                      color: clr.whiteColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
