import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'opinion_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class DetailedDiscussion extends StatefulWidget {
  const DetailedDiscussion({super.key});

  @override
  State<DetailedDiscussion> createState() => _DetailedDiscussionState();
}

class _DetailedDiscussionState extends State<DetailedDiscussion>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.detailedDiscussion, b: bn.detailedDiscussion),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ///Title
                  Container(
                    padding: EdgeInsets.only(
                        left: size.w16,
                        top: size.h16,
                        right: size.w16,
                        bottom: size.h10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: clr.placeHolderTextColorGray))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.imgEmptyProfile,
                          height: size.r24,
                        ),
                        SizedBox(width: size.w8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label(
                                    e: "Student Qualifications Physiology is an integrated science that considers the function of each organ and organ system and their interaction in the maintenance of life.",
                                    b: "শিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে।"),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyPoppins,
                                    fontSize: size.textSmall,
                                    color: clr.textColorAppleBlack),
                              ),
                              SizedBox(height: size.h12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    label(e: "3 in Total", b: "মোট ৩ টি"),
                                    style: TextStyle(
                                        color: clr.placeHolderTextColorGray,
                                        fontSize: size.textXXSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    " | ",
                                    style: TextStyle(
                                        color: clr.placeHolderTextColorGray,
                                        fontSize: size.textXXSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    label(
                                        e: "Date: 20 November 2023",
                                        b: "তারিখ: ২০ নভেম্বর ২০২৩"),
                                    style: TextStyle(
                                        color: clr.placeHolderTextColorGray,
                                        fontSize: size.textXXSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const CommentTile(),
                  const CommentTile(),
                  const CommentTile(),
                ],
              ),
            ),
            Positioned(
              bottom: size.h20,
              right: size.w16,
              child: CustomButton(
                onTap: onTapOpinion,
                icon: Icons.add_comment,
                title: label(e: en.yourOpinion, b: bn.yourOpinion),
                radius: size.r4,
              ),
            )
          ],
        ));
  }

  void onTapOpinion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const OpinionBottomSheet(),
    );
  }
}

class CommentTile extends StatelessWidget with AppTheme, Language {
  const CommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: size.w48, top: size.h8, right: size.w16, bottom: size.h16),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: clr.cardStrokeColor))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                ImageAssets.imgEmptyProfile,
                height: size.h24,
              ),
              SizedBox(width: size.w12),
              Expanded(
                child: Text(
                  "ব্যবহারকারীর নাম",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      color: clr.blackColor),
                ),
              ),
              Text(
                "২০ নভেম্বর ২০২৩",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textXXSmall,
                    color: clr.iconColorHint),
              ),
            ],
          ),
          SizedBox(height: size.h16),
          Text(
            "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyPoppins,
                fontSize: size.textSmall,
                color: clr.blackColor),
          ),
          SizedBox(height: size.h16),
          Divider(color: clr.placeHolderDeselectGray),
          SizedBox(height: size.h8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.thumb_up,
                color: clr.placeHolderTextColorGray,
                size: size.r20,
              ),
              SizedBox(width: size.w4),
              Expanded(
                child: Text(
                  "0 ভোট",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textXSmall,
                      color: clr.placeHolderTextColorGray),
                ),
              ),
              Icon(
                Icons.flag,
                color: clr.placeHolderTextColorGray,
                size: size.r20,
              ),
              SizedBox(width: size.w4),
              Text(
                "রিপোর্ট",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textXSmall,
                    color: clr.placeHolderTextColorGray),
              ),
            ],
          )
        ],
      ),
    );
  }
}
