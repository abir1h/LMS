import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../discussion/presentation/screens/discussion_bottom_sheet.dart';

class DiscussionWidget extends StatefulWidget {
  const DiscussionWidget({super.key});

  @override
  State<DiscussionWidget> createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget>
    with AppTheme, Language {
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
                onTap: () => Get.toNamed(AppRoutes.detailedDiscussion),
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
            onTap: onTapCreateDiscussion,
            icon: Icons.add_comment,
            radius: 0.0,
            title: label(e: en.newDiscussion, b: bn.newDiscussion),
          ),
        )
      ],
    );
  }

  void onTapCreateDiscussion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const DiscussionBottomSheet(),
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
