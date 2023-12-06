import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/service/notifier/app_events_notifier.dart';

import '../../../discussion/presentation/screens/discussion_screen.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_expanded_text.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/youtube_player.dart';

class TranscriptVideoScreen extends StatefulWidget {
  const TranscriptVideoScreen({super.key});

  @override
  State<TranscriptVideoScreen> createState() => _TranscriptVideoScreenState();
}

class _TranscriptVideoScreenState extends State<TranscriptVideoScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomYoutubePlayer(
          videoUrl: "uGqidUUFzwY",
          body: Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: size.h16, right: size.w16, left: size.w16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(
                            e: "Video 1: Course Introduction",
                            b: "ভিডিও ১: কোর্সের পরিচিতি"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: StringData.fontFamilyPoppins,
                            fontWeight: FontWeight.w600,
                            fontSize: size.textSmall,
                            color: clr.appPrimaryColorGreen),
                      ),
                    ),
                    Icon(
                      Icons.download,
                      size: size.r20,
                      color: clr.appPrimaryColorGreen,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.w8),
                      child: CustomSwitchButton(
                        value: App.currentAppLanguage == AppLanguage.english,
                        textOn: 'EN',
                        textSize: size.textXXSmall,
                        textOff: 'বাং',
                        bgColor: clr.whiteColor,
                        width: 64.w,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (bool state) {
                          App.setAppLanguage(state ? 1 : 0).then((value) {
                            if (mounted) {
                              setState(() {});
                            }
                            AppEventsNotifier.notify(EventAction.onGoingCoursesScreen);
                            AppEventsNotifier.notify(EventAction.dashBoardScreen);
                            AppEventsNotifier.notify(EventAction.bottomNavBar);
                            AppEventsNotifier.notify(EventAction.coursesScreen);
                          });
                        },
                        buttonHolder: const Icon(
                          Icons.check,
                          color: Colors.transparent,
                        ),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.h8),
                Text(
                  label(
                      e: "Traditional Concepts of Interconnected Formal Education",
                      b: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা"),
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w400,
                      color: clr.textColorBlack),
                ),
                SizedBox(height: size.h12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onTap: () {},
                      icon: Icons.add,
                      title: label(e: en.takeNotes, b: bn.takeNotes),
                      textSize: size.textXXXSmall,
                      horizontalPadding: size.w10,
                      verticalPadding: 6.5.h,
                      radius: size.w8,
                    ),
                    SizedBox(width: size.w16),
                    CustomButton(
                      onTap: onTapDiscussion,
                      icon: Icons.add,
                      title: label(e: en.discussion, b: bn.discussion),
                      textSize: size.textXXXSmall,
                      horizontalPadding: size.w10,
                      verticalPadding: 6.5.h,
                      radius: size.w8,
                    )
                  ],
                ),
                SizedBox(height: size.h16),
                Text(
                  label(e: en.transcript, b: bn.transcript),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontWeight: FontWeight.w600,
                      fontSize: size.textSmall,
                      color: clr.appPrimaryColorGreen),
                ),
                SizedBox(height: size.h8),
                ExpandableText(
                  text: label(
                      e: StringData.transcriptTitle2Description,
                      b: StringData.transcriptTitle2DescriptionBn),
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w400,
                      color: clr.textColorBlack),
                  minimumTextLengthToFold: 200,
                ),
                SizedBox(height: size.h56),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 106.w),
                  child: CustomButton(
                    onTap: () {},
                    title: label(e: en.next, b: bn.next),
                    verticalPadding: 2.h,
                    radius: size.w4,
                  ),
                ),
                SizedBox(height: size.h56),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapDiscussion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const DiscussionScreen(),
    );
  }
}
