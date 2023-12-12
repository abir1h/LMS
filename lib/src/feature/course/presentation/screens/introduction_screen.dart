import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../notes/presentation/screens/note_edit_screen.dart';
import '../controllers/introduction_controller.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with AppTheme, Language, TickerProviderStateMixin {
  final IntroductionController controller = Get.find<IntroductionController>();
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
              tabs: [
                Tab(
                  text: label(e: en.details, b: bn.details),
                ),
                Tab(
                  text: label(e: en.notesText, b: bn.notesText),
                ),
                Tab(
                  text: label(e: en.discussion, b: bn.discussion),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Center(child: Text("Details")),
                  NoteWidget(),
                  DiscussionWidget(),
                ],
              ),
            ),
          ],
        ));
  }
}

class NoteWidget extends StatelessWidget with AppTheme {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              SizedBox(height: size.h64)
            ],
          ),
        ),
        Positioned(
          bottom: size.h20,
          right: size.w16,
          child: GestureDetector(
            onTap: () => Get.to(() => const NoteEditScreen()),
            child: Container(
              padding: EdgeInsets.all(size.r16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: clr.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: SvgPicture.asset(
                ImageAssets.icEditSquare,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NoteWidgetTile extends StatelessWidget with AppTheme {
  final String noteContent;
  final String title;
  final String timestamp;
  final VoidCallback onPressed;
  const NoteWidgetTile(
      {super.key,
      required this.noteContent,
      required this.title,
      required this.timestamp,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: size.w1,
          color: clr.boxStrokeColor,
        ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteContent,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        timestamp,
                        style: TextStyle(
                          color: clr.placeHolderTextColorGray,
                          fontWeight: FontWeight.w400,
                          fontSize: size.textXXSmall,
                          fontFamily: StringData.fontFamilyPoppins,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DiscussionWidget extends StatelessWidget with AppTheme {
  const DiscussionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiscussionWidgetTile(
                title: label(
                    e: "Eligibility of Students",
                    b: "শিক্ষার্থীদের যোগ্যতাশিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান"),
                totalDiscussion: label(e: "3 in Total", b: "মোট ৩ টি"),
                time: label(
                    e: "Date: 20 November 2023", b: "তারিখ: ২০ নভেম্বর ২০২৩"),
              ),
              DiscussionWidgetTile(
                title: label(
                    e: "Eligibility of Students", b: "শিক্ষার্থীদের যোগ্যতা"),
                totalDiscussion: label(e: "3 in Total", b: "মোট ৩ টি"),
                time: label(
                    e: "Date: 20 November 2023", b: "তারিখ: ২০ নভেম্বর ২০২৩"),
              ),
              DiscussionWidgetTile(
                title: label(
                    e: "Eligibility of Students", b: "শিক্ষার্থীদের যোগ্যতা"),
                totalDiscussion: label(e: "3 in Total", b: "মোট ৩ টি"),
                time: label(
                    e: "Date: 20 November 2023", b: "তারিখ: ২০ নভেম্বর ২০২৩"),
              ),
              SizedBox(height: size.h64)
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            onTap: () {},
            icon: Icons.add_comment,
            radius: 0.0,
            title: 'নতুন আলোচনা',
          ),
        )
      ],
    );
  }
}

class DiscussionWidgetTile extends StatelessWidget with AppTheme {
  final String title;
  final String totalDiscussion;
  final String time;
  final VoidCallback? onTap;
  const DiscussionWidgetTile({
    super.key,
    required this.title,
    required this.totalDiscussion,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: size.w16, right: size.w16, top: size.h8, bottom: size.h6),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: clr.dividerStrokeColorGrey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.mode_comment,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
            SizedBox(width: size.w8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        totalDiscussion,
                        style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
