import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart';
import 'custom_switch_button.dart';

class NoInternetWidget extends StatelessWidget with AppTheme {
  final IconData icon;
  final String title;

  const NoInternetWidget(
      {super.key,
      this.icon = Icons.signal_wifi_bad,
      this.title = StringData.noInternetText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 80.r, color: clr.iconColorRed),
                    SizedBox(height: size.h40),
                    Text(
                      title,
                      style: TextStyle(
                          color: clr.appPrimaryColorGreen,
                          fontSize: size.textXMedium,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                    SizedBox(height: size.h12),
                    Text(
                      StringData.noInternetContentText,
                      style: TextStyle(
                          color: clr.blackColor,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                    SizedBox(height: size.h1 + size.h42),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: size.r20,
                              color: clr.appPrimaryColorGreen,
                            ),
                            SizedBox(width: size.w8),
                            Text(
                              "আপনার মডেম এবং রাউটার চেক করুন",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                            ),
                          ],
                        ),
                        SizedBox(height: size.h12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: size.r20,
                              color: clr.appPrimaryColorGreen,
                            ),
                            SizedBox(width: size.w8),
                            Text(
                              "ওয়াইফাই পুনরায় সংযোগ করুন",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 97.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w20, vertical: size.h8),
                      decoration: BoxDecoration(
                          color: clr.appPrimaryColorGreen,
                          borderRadius:
                              BorderRadius.circular(size.w1 + size.w4)),
                      child: Text(
                        StringData.pageReloadText,
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
