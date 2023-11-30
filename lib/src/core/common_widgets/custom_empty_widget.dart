import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart';
import 'custom_switch_button.dart';

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
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
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
            Positioned(
              top: size.h16 - size.h1,
              right: size.w16,
              child: CustomSwitchButton(
                value: false,
                textOn: 'English',
                textSize: size.textXXSmall,
                textOff: 'বাংলা',
                bgColor: clr.whiteColor,
                width: 85.w,
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
                buttonHolder: const Icon(
                  Icons.check,
                  color: Colors.transparent,
                ),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
