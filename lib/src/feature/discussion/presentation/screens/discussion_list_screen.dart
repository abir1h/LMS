import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../controller/discussion_list_controller.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class DiscussionListScreen extends StatefulWidget {
  const DiscussionListScreen({super.key});

  @override
  State<DiscussionListScreen> createState() => _DiscussionListScreenState();
}

class _DiscussionListScreenState extends State<DiscussionListScreen>
    with AppTheme, Language {
  final DiscussionListController controller =
      Get.find<DiscussionListController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.discussion, b: bn.discussion),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            DiscussionCard(
              title: label(
                  e: "Eligibility of Students", b: "শিক্ষার্থীদের যোগ্যতা"),
              topicName: label(
                  e: "Topic Name : Video 2 | Human-welfare concepts in educational applications.",
                  b: "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা."),
              totalDiscussion: label(e: "3 in Total", b: "মোট ৩ টি"),
              time: label(
                  e: "Date: 20 November 2023", b: "তারিখ: ২০ নভেম্বর ২০২৩"),
              onTap: () => Get.toNamed(AppRoutes.detailedDiscussion),
            ),
          ],
        ));
  }
}

class DiscussionCard extends StatelessWidget with AppTheme {
  final String title;
  final String topicName;
  final String totalDiscussion;
  final String time;
  final VoidCallback? onTap;
  const DiscussionCard({
    super.key,
    required this.title,
    required this.topicName,
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
            left: size.w16, right: size.w16, top: size.h8, bottom: size.h4),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: clr.dividerStrokeColorGrey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.mode_comment,
              color: clr.iconColorHint,
              size: size.r24,
            ),
            SizedBox(width: size.w8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                              color: clr.textColorAppleBlack,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: size.w28),
                      Icon(
                        Icons.arrow_forward,
                        color: clr.appPrimaryColorGreen,
                        size: size.r24,
                      ),
                    ],
                  ),
                  SizedBox(height: size.h6),
                  Text(
                    topicName,
                    style: TextStyle(
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w400,
                        fontFamily: StringData.fontFamilyPoppins),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h4),
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
