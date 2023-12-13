import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'chapter_details_widget.dart';
import 'discussion_widget.dart';
import 'note_widget.dart';

class TabSectionWidget extends StatefulWidget {
  final String? tabTitle1, tabTitle2, tabTitle3;
  const TabSectionWidget({
    super.key,
    this.tabTitle1,
    this.tabTitle2,
    this.tabTitle3,
  });

  @override
  State<TabSectionWidget> createState() => _TabSectionWidgetState();
}

class _TabSectionWidgetState extends State<TabSectionWidget>
    with AppTheme, Language, TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar.secondary(
            controller: _tabController,
            labelStyle: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyPoppins),
            unselectedLabelStyle: TextStyle(
                color: clr.textColorBlack,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
            dividerColor: clr.placeHolderTextColorGray,
            indicatorPadding: EdgeInsets.symmetric(horizontal: size.w16),
            tabs: [
              Tab(
                  text:
                      widget.tabTitle1 ?? label(e: en.details, b: bn.details)),
              Tab(
                  text: widget.tabTitle2 ??
                      label(e: en.notesText, b: bn.notesText)),
              Tab(
                  text: widget.tabTitle3 ??
                      label(e: en.discussion, b: bn.discussion)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChapterDetailsWidget(
                    description: label(
                        e: "Humans are the most complete of living beings. But he is born as the most imperfect. The tiger bear derives its livelihood from the storehouse of nature. Humans appear in the biosphere with two empty hands clenched into fists. With huge flesh, hard armour, huge tail, the body of Prithul in the water and on the land was strong and tired. The proof is that the defeat of excess is inevitable. Experiments also determined that the greater the indulgence, the worse the vulnerability burden. In the new phase, nature kept itself in the background by reducing human allocation as much as possible. People have to look very small, but that's just a trick. In this life cycle, greatness has turned into greatness. In the universe the beasts were vastly solitary, the people a far-flung multitude.",
                        b: "জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে মানুষ আসবার পূর্বেই জীবসৃষ্টিযজ্ঞে প্রকৃতির ভূরিব্যয়ের পালা শেষ হয়ে এসেছে। বিপুল মাংস, কঠিন বর্ম, প্রকাণ্ড লেজ নিয়ে জলে স্থলে পৃথুল দেহের যে অমিতাচার প্রবল হয়ে উঠেছিল তাতে ধরিত্রীকে দিলে ক্লান্ত করে। প্রমাণ হল আতিশয্যের পরাভব অনিবার্য। পরীক্ষায় এটাও স্থির হয়ে গেল যে, প্রশ্রয়ের পরিমাণ যত বেশি হয় দুর্বলতার বোঝাও তত দুর্বহ হয়ে ওঠে। নূতন পর্বে প্রকৃতি যথাসম্ভব মানুষের বরাদ্দ কম করে দিয়ে নিজে রইল নেপথ্যে। মানুষকে দেখতে হল খুব ছোটো, কিন্তু সেটা একটা কৌশল মাত্র। এবারকার জীবযাত্রার পালায় বিপুলতাকে করা হল বহুলতায় পরিণত। মহাকায় জন্তু ছিল প্রকাণ্ড একলা, মানুষ হল দূরপ্রসারিত অনেক।")),
                const NoteWidget(),
                const DiscussionWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
