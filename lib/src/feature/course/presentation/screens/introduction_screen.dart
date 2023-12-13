import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/introduction_controller.dart';
import '../widgets/tab_section_widget.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with AppTheme, Language {
  final IntroductionController controller = Get.find<IntroductionController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: controller.screenName.value,
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
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: size.w10),
                  Icon(
                    Icons.save_alt,
                    color: clr.appPrimaryColorGreen,
                    size: size.r24,
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
            const TabSectionWidget()
            // TabBar.secondary(
            //   controller: _tabController,
            //   labelStyle: TextStyle(
            //       color: clr.appPrimaryColorGreen,
            //       fontSize: size.textSmall,
            //       fontWeight: FontWeight.w600,
            //       fontFamily: StringData.fontFamilyPoppins),
            //   unselectedLabelStyle: TextStyle(
            //       color: clr.textColorBlack,
            //       fontSize: size.textSmall,
            //       fontWeight: FontWeight.w500,
            //       fontFamily: StringData.fontFamilyPoppins),
            //   dividerColor: clr.placeHolderTextColorGray,
            //   indicatorPadding: EdgeInsets.symmetric(horizontal: size.w16),
            //   tabs: [
            //     Tab(
            //       text: label(e: en.details, b: bn.details),
            //     ),
            //     Tab(
            //       text: label(e: en.notesText, b: bn.notesText),
            //     ),
            //     Tab(
            //       text: label(e: en.discussion, b: bn.discussion),
            //     ),
            //   ],
            // ),
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     physics: const NeverScrollableScrollPhysics(),
            //     children: [
            //       DetailsWidget(
            //           description: label(
            //               e: "Humans are the most complete of living beings. But he is born as the most imperfect. The tiger bear derives its livelihood from the storehouse of nature. Humans appear in the biosphere with two empty hands clenched into fists. With huge flesh, hard armour, huge tail, the body of Prithul in the water and on the land was strong and tired. The proof is that the defeat of excess is inevitable. Experiments also determined that the greater the indulgence, the worse the vulnerability burden. In the new phase, nature kept itself in the background by reducing human allocation as much as possible. People have to look very small, but that's just a trick. In this life cycle, greatness has turned into greatness. In the universe the beasts were vastly solitary, the people a far-flung multitude.",
            //               b: "জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে মানুষ আসবার পূর্বেই জীবসৃষ্টিযজ্ঞে প্রকৃতির ভূরিব্যয়ের পালা শেষ হয়ে এসেছে। বিপুল মাংস, কঠিন বর্ম, প্রকাণ্ড লেজ নিয়ে জলে স্থলে পৃথুল দেহের যে অমিতাচার প্রবল হয়ে উঠেছিল তাতে ধরিত্রীকে দিলে ক্লান্ত করে। প্রমাণ হল আতিশয্যের পরাভব অনিবার্য। পরীক্ষায় এটাও স্থির হয়ে গেল যে, প্রশ্রয়ের পরিমাণ যত বেশি হয় দুর্বলতার বোঝাও তত দুর্বহ হয়ে ওঠে। নূতন পর্বে প্রকৃতি যথাসম্ভব মানুষের বরাদ্দ কম করে দিয়ে নিজে রইল নেপথ্যে। মানুষকে দেখতে হল খুব ছোটো, কিন্তু সেটা একটা কৌশল মাত্র। এবারকার জীবযাত্রার পালায় বিপুলতাকে করা হল বহুলতায় পরিণত। মহাকায় জন্তু ছিল প্রকাণ্ড একলা, মানুষ হল দূরপ্রসারিত অনেক।")),
            //       const NoteWidget(),
            //       const DiscussionWidget(),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
