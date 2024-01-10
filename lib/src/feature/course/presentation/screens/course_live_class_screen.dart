import 'package:flutter/material.dart';

import '../widgets/sliver_tab_section_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class CourseLiveClassScreen extends StatefulWidget {
  const CourseLiveClassScreen({super.key});

  @override
  State<CourseLiveClassScreen> createState() => _CourseLiveClassScreenState();
}

class _CourseLiveClassScreenState extends State<CourseLiveClassScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.liveClass, b: bn.liveClass),
      bgColor: clr.whiteColor,
      // actionChild: InkWell(
      //   onTap: () {},
      //   child: Stack(
      //     children: [
      //       Icon(
      //         Icons.notifications,
      //         color: clr.appPrimaryColorGreen,
      //         size: size.r24,
      //       ),
      //       Positioned(
      //         right: -1,
      //         top: 2.w,
      //         child: Container(
      //           width: size.w12,
      //           height: size.h12,
      //           decoration: BoxDecoration(
      //               color: clr.appPrimaryColorGreen,
      //               shape: BoxShape.circle,
      //               border: Border.all(color: clr.whiteColor)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SliverTabSectionWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: clr.boxStrokeColor))),
              child: Text(
                label(
                    e: "Concepts of Interconnected Formal Learning",
                    b: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ধারণা"),
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            SizedBox(height: size.h8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: Text(
                label(e: "Live Class Description", b: "লাইভ ক্লাসের বর্ণনা"),
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            SizedBox(height: size.h12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: Text(
                label(
                    e: "Engage in effective post-secondary education teaching methods in this online short course, inspired by the in-person seminar program currently offered by the ministry's Center for Teaching and Learning.",
                    b: "এই অনলাইন সংক্ষিপ্ত কোর্সে কার্যকর পোস্ট-সেকেন্ডারি শিক্ষা শিক্ষণ পদ্ধতির সাথে যুক্ত হন, যা বর্তমানে সেন্টার ফর টিচিং অ্যান্ড লার্নিং মন্ত্রকের দ্বারা দেওয়া ব্যক্তিগত সেমিনার প্রোগ্রাম দ্বারা অনুপ্রাণিত।"),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            SizedBox(height: size.h12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.w16),
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
                              label(
                                  e: "Live Class Title",
                                  b: "লাইভ ক্লাসের শিরোনাম"),
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
                              label(
                                  e: "First Chapter Title",
                                  b: "প্রথম অধ্যায়ের শিরোনাম"),
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
                              label(e: "(chapter code)", b: "(অধ্যায়ের কোড)"),
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
                      Expanded(
                        child: Text(
                          label(
                              e: "Friday, January 3",
                              b: "শুক্রবার, ৩ জানুয়ারি"),
                          style: TextStyle(
                              color: clr.blackColor,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: size.w8),
                      Icon(
                        Icons.schedule,
                        color: clr.textColorAppleBlack,
                        size: size.r20,
                      ),
                      SizedBox(width: size.w8),
                      Expanded(
                        child: Text(
                          label(e: "10.30 am", b: "সকাল ১০.৩০"),
                          style: TextStyle(
                              color: clr.blackColor,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.h20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w44),
                    child: CustomButton(
                      onTap: () {},
                      title: label(e: en.joinClass, b: bn.joinClass),
                      radius: size.r16,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.h16),
          ],
        ),
      ),
    );
  }
}
