import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/service/notifier/app_events_notifier.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/ongoing_course_controller.dart';

class OngoingCourseScreen extends StatefulWidget with AppTheme {
  const OngoingCourseScreen({super.key});

  @override
  State<OngoingCourseScreen> createState() => _OngoingCourseScreenState();
}

class _OngoingCourseScreenState extends State<OngoingCourseScreen>
    with AppTheme, Language ,AppEventsNotifier{
  final OngoingCourseController controller =
      Get.find<OngoingCourseController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "LMS", b: "এলএমএস"),
        actionChild: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: clr.appPrimaryColorGreen,
                size: size.r24,
              ),
              Positioned(
                right: -1,
                top: 2.w,
                child: Container(
                  width: size.w12,
                  height: size.h12,
                  decoration: BoxDecoration(
                      color: clr.appPrimaryColorGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: clr.whiteColor)),
                ),
              ),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label(
                      e: "Learning Area 1: Educational Policy and Management in Education",
                      b: "শিখন ক্ষেত্র ১:  শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
                  style: TextStyle(
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
                SizedBox(height: size.h8),
                Text(
                  label(
                      e: "Course Start Date: 5th January",
                      b: "কোর্স শুরুর তারিখ: ৫ই জানুয়ারী"),
                  style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textXXSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
                SizedBox(height: size.h8),
                Divider(height: size.h1, color: clr.boxStrokeColor),
                SizedBox(height: size.h12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(
                            e: "Learning Area 1: Education",
                            b: "শিখন ক্ষেত্র ১: শিক্ষা"),
                        style: TextStyle(
                            color: clr.appPrimaryColorGreen,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SvgPicture.asset(ImageAssets.icLockOpenRight)
                  ],
                ),
                SizedBox(height: size.h12),
                Divider(height: size.w1, color: clr.boxStrokeColor),
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                      onTap: () => Get.toNamed(AppRoutes.transcriptVideo),
                    ),
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                      onTap: () => Get.toNamed(AppRoutes.transcriptVideo),
                    ),
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                      onTap: () => Get.toNamed(AppRoutes.transcriptVideo),
                    ),
                    const ContentWidget(),
                    ContentWidget(
                      iconType: "quiz",
                      text1: label(e: "Quiz:", b: "কুইজ:"),
                      text2: label(e: "Quiz Title", b: "কুইজ শিরোনাম"),
                    ),
                  ],
                ),
                SizedBox(height: size.h20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(
                            e: "Learning Area 2: Education Policy and Education System...",
                            b: "শিখন ক্ষেত্র ২: শিক্ষানীতি ও শিক্ষা ব্যবস্থা..."),
                        style: TextStyle(
                            color: clr.textColorBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.lock,
                      color: clr.textColorBlack,
                      size: size.r24,
                    )
                  ],
                ),
                SizedBox(height: size.h12),
                Divider(height: size.w1, color: clr.boxStrokeColor),
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ContentWidget(),
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                    ),
                    ContentWidget(
                      iconType: "quiz",
                      text1: label(e: "Quiz:", b: "কুইজ:"),
                      text2: label(e: "Quiz Title", b: "কুইজ শিরোনাম"),
                    ),
                    ContentWidget(
                      iconType: "quiz",
                      text1: label(e: "Quiz:", b: "কুইজ:"),
                      text2: label(e: "Quiz Title", b: "কুইজ শিরোনাম"),
                    ),
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                    ),
                    ContentWidget(
                      iconType: "video",
                      text1: label(e: "Video 1:", b: "ভিডিও ১:"),
                      text2:
                          label(e: "Course Introduction", b: "কোর্সের পরিচিতি"),
                    ),
                  ],
                ),
                SizedBox(height: size.h20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(
                            e: "Learning Area 1: Educational Psychology",
                            b: "শিখন ক্ষেত্র ১: শিক্ষা মনোবিজ্ঞান"),
                        style: TextStyle(
                            color: clr.textColorBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w600,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.check_circle_sharp,
                      color: clr.appPrimaryColorGreen,
                      size: size.r24,
                    )
                  ],
                ),
                SizedBox(height: size.h12),
                Divider(height: size.w1, color: clr.boxStrokeColor),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ContentWidget();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void onEventReceived(EventAction action) {
    if(action==EventAction.onGoingCoursesScreen){
      if(mounted){
        setState(() {
        });
      }
    }
  }
}

class ContentWidget extends StatelessWidget with AppTheme {
  final String? iconType;
  final String? text1;
  final String? text2;
  final VoidCallback? onTap;
  const ContentWidget(
      {Key? key, this.iconType, this.text1, this.text2, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: size.w16,
            top: size.h2 + size.h12,
            bottom: size.h2 + size.h12,
            right: size.w1 + size.w24),
        decoration: BoxDecoration(
            color: clr.shadeWhiteColor2,
            border: Border(
                left: BorderSide(color: clr.boxStrokeColor),
                right: BorderSide(color: clr.boxStrokeColor),
                bottom: BorderSide(color: clr.boxStrokeColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconType == "video"
                  ? Icons.play_circle_outline
                  : iconType == "quiz"
                      ? Icons.quiz
                      : Icons.auto_stories,
              size: size.r20,
              color: iconType == "video"
                  ? clr.appSecondaryColorFlagRed
                  : clr.appPrimaryColorGreen,
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 25,
              child: Text(
                text1 ?? label(e: "Reading:", b: "রিডিং:"),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 60,
              child: Text(
                text2 ??
                    label(e: "Reading Element Name", b: "পড়ার উপাদানের নাম"),
                style: TextStyle(
                    color: clr.textColorBlack,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
