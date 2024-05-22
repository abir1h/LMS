import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/common_widgets/custom_empty_widget.dart';

import '../../../../core/utility/app_label.dart';
import 'recognition_card.dart';
import '../../../../core/constants/common_imports.dart';

class RecognitionWidget extends StatelessWidget with AppTheme, Language {
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
                label(e: en.acknowledgment, b: bn.acknowledgment),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyRoboto,
                    color: clr.shadeWhiteColor2),
              ),
            ),
            Expanded(
              child: CustomEmptyWidget(
                message: '',
                title: label(
                    e: 'No certificates found',
                    b: 'কোনো সার্টিফিকেট পাওয়া যায়নি'),
              ), /*child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    RecognitionCard(
                        title: label(
                            e: "Distribution of new curriculum",
                            b: "নতুন কারিকুলাম বিতরণ"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title:
                            label(e: "Right to Information", b: "তথ্য অধিকার"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title: label(
                            e: "Right to Information 2", b: "তথ্য অধিকার 2"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title:
                            label(e: "Right to Information", b: "তথ্য অধিকার"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title: label(
                            e: "Right to Information 2", b: "তথ্য অধিকার 2"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title:
                            label(e: "Right to Information", b: "তথ্য অধিকার"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                    RecognitionCard(
                        title: label(
                            e: "Right to Information 2", b: "তথ্য অধিকার 2"),
                        fileName: "স্বীকৃতিপত্র.pdf",
                        time: label(
                            e: "Period 15/11/23 - 30/11/23",
                            b: "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩")),
                  ],
                ),
              ),*/
            )
          ],
        ),
      ),
    );
  }
}
