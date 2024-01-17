import 'package:flutter/material.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.discussion, b: bn.discussion),
        body: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            DiscussionTile(
              iconData: Icons.groups,
              iconColor: clr.appPrimaryColorGreen,
              title: label(e: en.allDiscussion, b: bn.allDiscussion),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRoute.discussionListScreen),
            ),
            DiscussionTile(
              iconData: Icons.text_snippet,
              iconColor: clr.clickableLinkColor,
              title: label(
                  e: "Introduction, Chapter Description",
                  b: "ভূমিকা, অধ্যায়ের বিবরণ"),
              onTap: () => Navigator.of(context).pushNamed(
                  AppRoute.courseIntroductionScreen,
                  arguments: CourseIntroductionScreenArgs(
                      screenTitle: label(
                          e: "Introduction, Chapter Description",
                          b: "ভূমিকা, অধ্যায়ের বিবরণ"))),
            ),
            DiscussionTile(
              iconData: Icons.smart_display,
              iconColor: clr.iconColorSweetRed,
              title: label(
                  e: "Video 1: Course Introduction",
                  b: "ভিডিও ১: কোর্সের পরিচিতি"),
            ),
            DiscussionTile(
              iconData: Icons.cast_connected,
              iconColor: clr.textColorBlack,
              title: label(e: "Live Class", b: "লাইভ ক্লাস"),
            ),
            DiscussionTile(
              iconData: Icons.smart_display,
              iconColor: clr.iconColorSweetRed,
              title: label(
                  e: "Video 2: Learning Experience",
                  b: "ভিডিও ২: শিখন-অভিজ্ঞতা"),
            ),
            DiscussionTile(
              iconData: Icons.smart_display,
              iconColor: clr.iconColorSweetRed,
              title: label(
                  e: "Video 3: Traditional concepts",
                  b: "ভিডিও ৩: ঐতিহ্যগত ধারণা"),
            ),
          ],
        ));
    /*return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Material(
          type: MaterialType.transparency,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.maxFinite,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .84),
                  decoration: BoxDecoration(
                    color: clr.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.r8),
                      topRight: Radius.circular(size.r8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.w16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'আলোচনা',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: size.textSmall,
                                fontFamily: StringData.fontFamilyPoppins,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: size.r24,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.w16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCardTile(
                                  vertical: 6.0,
                                  horizontal: 14.0,
                                  bgColor: clr.cardStrokeColor,
                                  radius: 8.0,
                                  child: Text('সর্বশেষ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.textSmall,
                                        fontFamily:
                                            StringData.fontFamilyPoppins,
                                      )),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                commentTile(hasReply: true),
                                SizedBox(
                                  height: 20.h,
                                ),
                                commentTile(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                commentTile(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                commentTile(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                commentTile(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1.sw,
                        height: 1.h,
                        color: clr.dividerStrokeColorGrey,
                      ),
                      SizedBox(height: size.h12 + size.h2),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: size.h16, left: size.h16, right: size.h16),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.imgEmptyProfile,
                              height: size.h28,
                            ),
                            SizedBox(
                              width: size.w16,
                            ),
                            Expanded(
                              child: AppTextField(
                                  hintText: StringData.commentHintText,
                                  controller: controller,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      size: size.r24,
                                    ),
                                    onPressed: () { _scrollController.animateTo(
                                      0.0,
                                      duration:
                                      const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );},
                                  ),
                                  onTaped: () {

                                    _scrollController.animateTo(
                                      0.0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );*/
  }

  Widget commentTile({bool? hasReply = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImageAssets.imgEmptyProfile,
          height: size.h28,
        ),
        SizedBox(
          width: size.w16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "ব্যবহারকারীর নাম ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontSize: size.textSmall,
                        color: clr.iconColorHint),
                  ),
                  Text(
                    " ২০ মিনিট পূর্বে",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontSize: size.textXXSmall,
                        color: clr.iconColorHint),
                  ),
                ],
              ),
              SizedBox(
                height: size.h8,
              ),
              Text(
                "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textSmall,
                    color: clr.blackColor),
              ),
              SizedBox(
                height: size.h8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.chat_outlined,
                    size: size.h20,
                    color: clr.iconColorBlack,
                  ),
                  SizedBox(
                    width: size.w8,
                  ),
                  Text(
                    "রিপ্লাই করুন",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontSize: size.textSmall,
                        color: clr.iconColorHint),
                  ),
                ],
              ),
              SizedBox(
                height: size.h12,
              ),
              hasReply!
                  ? Text(
                      "৩টি উত্তর রয়েছে",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins,
                          fontSize: size.textSmall,
                          color: clr.appPrimaryColorGreen),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}

class DiscussionTile extends StatelessWidget with AppTheme {
  final IconData iconData;
  final Color iconColor;
  final String title;
  final VoidCallback? onTap;
  const DiscussionTile({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h24),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: clr.dividerStrokeColorGrey))),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: size.r24,
            ),
            SizedBox(width: size.w16),
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
          ],
        ),
      ),
    );
  }
}
