import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'recognition_card.dart';
import '../../../../core/constants/common_imports.dart';

class RecognitionWidget extends StatelessWidget with AppTheme {
  const RecognitionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(left: 28.w),
        decoration: BoxDecoration(
            color: clr.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(size.r8))),
        child: Column(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(
                  horizontal: size.h16, vertical: size.h20),
              decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(size.r8))),
              child: Text(
                StringData.recognitionText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyRoboto,
                    color: clr.shadeWhiteColor2),
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RecognitionCard(
                        title: "নতুন কারিকুলাম বিতরণ ",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"), RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"), RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"), RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"), RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"), RecognitionCard(
                        title: "তথ্য অধিকার",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                    RecognitionCard(
                        title: "তথ্য অধিকার 2",
                        description: "স্বীকৃতিপত্র .pdf",
                        time: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
