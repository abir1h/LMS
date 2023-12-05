import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class LiveClassScreen extends StatefulWidget {
  const LiveClassScreen({super.key});

  @override
  State<LiveClassScreen> createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "লাইভ ক্লাস",
      actionChild: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Icon(
              Icons.notifications,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
            Positioned(
              right: -1,
              top: 2.w,
              child: Container(
                width: size.w12,
                height: size.h12,
                decoration: BoxDecoration(
                    color: clr.appPrimaryColorGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: clr.whiteColor)),
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ধারণা",
              style: TextStyle(
                  color: clr.appPrimaryColorGreen,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h32 - size.h2),
            Text(
              "লাইভ ক্লাসের বর্ণনা",
              style: TextStyle(
                  color: clr.appPrimaryColorGreen,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h12),
            Text(
              "এই অনলাইন সংক্ষিপ্ত কোর্সে কার্যকর পোস্ট-সেকেন্ডারি শিক্ষা শিক্ষণ পদ্ধতির সাথে যুক্ত হন, যা বর্তমানে সেন্টার ফর টিচিং অ্যান্ড লার্নিং মন্ত্রকের দ্বারা দেওয়া ব্যক্তিগত সেমিনার প্রোগ্রাম দ্বারা অনুপ্রাণিত।",
              style: TextStyle(
                  color: clr.blackColor,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h12),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.w24, vertical: size.h24),
              decoration: BoxDecoration(
                  color: clr.shadeWhiteColor2,
                  borderRadius: BorderRadius.circular(size.r8),
                  border: Border.all(
                      color: clr.cardFillColorCruise, width: size.w1)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.video_call,
                        color: clr.textColorAppleBlack,
                        size: size.r20,
                      ),
                      SizedBox(width: size.w8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "লাইভ ক্লাসের শিরোনাম",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: size.h8),
                            Text(
                              "প্রথম অধ্যায়ের শিরোনাম",
                              style: TextStyle(
                                  color: clr.blackColor,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: size.h4),
                            Text(
                              "(অধ্যায়ের কোড)",
                              style: TextStyle(
                                  color: clr.iconColorHint,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.h8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: clr.textColorAppleBlack,
                        size: size.r20,
                      ),
                      SizedBox(width: size.w8),
                      Text(
                        "শুক্রবার, ৩ জানুয়ারি",
                        style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: size.w8),
                      Icon(
                        Icons.schedule,
                        color: clr.textColorAppleBlack,
                        size: size.r20,
                      ),
                      SizedBox(width: size.w8),
                      Text(
                        "সকাল ১০.৩০",
                        style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: size.h20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w44),
                    child: CustomButton(
                      onTap: () {},
                      title: "ক্লাসে জয়েন করুন",
                      radius: size.r16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
