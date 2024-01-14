import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../discussion/presentation/controller/discussion_controller.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../discussion/presentation/screens/detailed_discussion.dart';
import '../../../discussion/presentation/screens/discussion_bottom_sheet.dart';

class DiscussionWidget extends StatefulWidget {
  final ScrollPhysics? physics;
  const DiscussionWidget({super.key, this.physics});

  @override
  State<DiscussionWidget> createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget>
    with AppTheme, Language {
  final controller = Get.put(DiscussionController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscussionController>(builder: (_) {
      return Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.discussionList.length,
            physics: widget.physics ?? const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: size.h64 * 2),
            itemBuilder: (_, index) {
              return DiscussionWidgetTile(
                  title: controller.discussionList[index].title!,
                  totalDiscussion:
                      controller.discussionList[index].comments != null
                          ? controller.discussionList[index].comments!.length
                              .toString()
                          : "0",
                  time: controller.discussionList[index].createdAt!,
                  onTap: () => Get.to(DetailedDiscussion(
                        mainModel: controller.discussionList[index],
                      )));
            },
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
    });
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
            color: clr.scaffoldBackgroundColor,
            border: Border(
                bottom: BorderSide(color: clr.placeHolderTextColorGray))),
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
                      Expanded(
                        child: Text.rich(
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: clr.placeHolderTextColorGray,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            TextSpan(
                                text: label(
                                    e: "মোট $totalDiscussion টি",
                                    b: "মোট $totalDiscussion টি"),
                                children: [
                                  const TextSpan(
                                    text: " | ",
                                  ),
                                  TextSpan(
                                    text: "তারিখ: $time",
                                  ),
                                ])),
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
