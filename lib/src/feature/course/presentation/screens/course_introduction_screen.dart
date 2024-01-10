import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/introduction_controller.dart';
import '../widgets/sliver_tab_section_widget.dart';

class CourseIntroductionScreen extends StatefulWidget {
  const CourseIntroductionScreen({super.key});

  @override
  State<CourseIntroductionScreen> createState() =>
      _CourseIntroductionScreenState();
}

class _CourseIntroductionScreenState extends State<CourseIntroductionScreen>
    with AppTheme, Language {
  final IntroductionController controller = Get.find<IntroductionController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: controller.screenName.value,
      bgColor: clr.whiteColor,
      body: SliverTabSectionWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.h12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      label(
                          e: "Chapter 1: The Desert of Karbala",
                          b: "অধ্যায় ১: কারবালা প্রান্তর"),
                      style: TextStyle(
                          color: clr.appPrimaryColorGreen,
                          fontSize: size.textXMedium,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                  ),
                  SizedBox(width: size.w10),
                  Container(
                    padding: EdgeInsets.all(size.r1),
                    decoration: BoxDecoration(
                      color: clr.whiteColor,
                      borderRadius: BorderRadius.circular(size.r4),
                      border: Border.all(
                          color: clr.cardStrokeColor, width: size.r1),
                      boxShadow: [
                        BoxShadow(
                          color: clr.blackColor.withOpacity(.2),
                          blurRadius: size.r4,
                          offset: Offset(0.0, size.h2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.save_alt,
                      color: clr.appPrimaryColorGreen,
                      size: size.r24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.h4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: Text(
                label(e: "Introduction:", b: "ভূমিকা:"),
                style: TextStyle(
                    color: clr.textColorBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            SizedBox(height: size.h8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              child: Text(
                label(
                    e: "Physiology is an integrated science that considers the function of each organ and organ system and their interaction in the maintenance of life. This introductory course is divided into ten modules.",
                    b: "ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে। এই পরিচায়ক কোর্সটি দশটি মডিউলে বিভক্ত।"),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
            SizedBox(height: size.h16),
          ],
        ),
      ),
    );
  }
}
