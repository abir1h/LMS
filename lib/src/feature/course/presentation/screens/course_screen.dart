import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/course_controller.dart';
import '../widgets/chapter_widget.dart';

class CourseScreen extends StatefulWidget with AppTheme {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> with AppTheme, Language {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CourseController controller = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: label(e: en.courseText, b: bn.courseText),
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          trailingOnPressed: () => Get.toNamed(AppRoutes.notification),
          trailing: Stack(
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
          leading: Icon(
            Icons.menu,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: size.h12),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          const CourseWidget(
            title: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা",
            description:
                "শেখার জন্য শিক্ষাদান প্রোগ্রামের হল যারা শিক্ষা দিচ্ছেন, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো প্রসঙ্গে বিস্তারিত আলোচনা",
          ),
          SizedBox(height: size.h32),
          const CourseWidget(
            title: "তথ্য অধিকার",
            description:
                "শেখার জন্য শিক্ষাদান প্রোগ্রামের হল যারা শিক্ষা দিচ্ছেন, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো প্রসঙ্গে বিস্তারিত আলোচনা",
          ),
        ],
      ),
      // body: ListView.separated(
      //   shrinkWrap: true,
      //   physics: const BouncingScrollPhysics(),
      //   itemCount: 3,
      //   padding: EdgeInsets.symmetric(vertical: size.h12),
      //   itemBuilder: (context, index) {
      //     return const CourseWidget();
      //   },
      //   separatorBuilder: (context, index) {
      //     return SizedBox(height: size.h32);
      //   },
      // ),
    );
  }
}

class CourseWidget extends StatelessWidget with AppTheme {
  final String title;
  final String description;
  const CourseWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseText(
          text: title,
          fontSize: size.textXMedium,
        ),
        SizedBox(height: size.h16),
        const CourseText(text: "পাঠ্যসূচীর বর্ণনা"),
        SizedBox(height: size.h10),
        CourseText(
          text: description,
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: size.h16),
        const CourseText(text: "পাঠ্যক্রমের বিষয়বস্তু"),
        SizedBox(height: size.h12),
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ChapterWidget(
              chapterTitle: "অধ্যায় ১: কারবালা প্রান্তর",
              chapterCode: "অধ্যায়ের কোড",
              lock: false,
            ),
            ChapterWidget(
              chapterTitle: "অধ্যায় ২: মানব-কল্যাণ",
              chapterCode: "অধ্যায়ের কোড",
            ),
            ChapterWidget(
              chapterTitle: "অধ্যায় ৩: কারবালা প্রান্তর",
              chapterCode: "অধ্যায়ের কোড",
            ),
            ChapterWidget(
              chapterTitle: "অধ্যায় ৪: মানব-কল্যাণ",
              chapterCode: "অধ্যায়ের কোড",
            ),
            ChapterWidget(
              chapterTitle: "অধ্যায় ৫: জীবযাত্রার বিপুলতা",
              chapterCode: "অধ্যায়ের কোড",
            ),
          ],
        )
        // ListView.builder(
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: 4,
        //   itemBuilder: (context, index) {
        //     return const ChapterWidget(
        //       chapterTitle: "অধ্যায় ১: কারবালা প্রান্তর",
        //       chapterCode: "অধ্যায়ের কোড",
        //     );
        //   },
        // ),
      ],
    );
  }
}

class CourseText extends StatelessWidget with AppTheme {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CourseText(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.w16),
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? clr.appPrimaryColorGreen,
            fontSize: fontSize ?? size.textSmall,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontFamily: StringData.fontFamilyPoppins),
      ),
    );
  }
}
