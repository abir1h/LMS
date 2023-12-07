import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/course_controller.dart';
import '../../../../core/constants/common_imports.dart';
import '../widgets/course_card.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with AppTheme, Language, AppEventsNotifier {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label(e: "Current Course", b: "চলমান কোর্স"),
              style: TextStyle(
                  color: clr.appPrimaryColorGreen,
                  fontSize: size.textXMedium,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyRoboto),
            ),
            SizedBox(height: size.h8),
            CourseCard(
              onTap: () => Get.toNamed(AppRoutes.courseDetails),
              title: label(
                  e: "Education policy and management in education",
                  b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
              titleFontSize: size.textXMedium,
              code: label(e: "Course Code : 5568", b: "কোর্সের কোড : ৫৫৬৮"),
              time: label(
                  e: "Duration : 12/06/2023 - 17/03/2024",
                  b: "সময়কাল : ১২/০৬/২০২৩ - ১৭/০৩/২০২৪"),
              statusValue: .1,
              status: label(e: "10% ${en.completed}", b: "১০% ${bn.completed}"),
            ),
            SizedBox(height: size.h12),
            Divider(height: 1, color: clr.boxStrokeColor),
            SizedBox(height: size.h12),
            Text(
              label(e: "Other Courses", b: "অন্যান্য কোর্সসমূহ"),
              style: TextStyle(
                  color: clr.appPrimaryColorGreen,
                  fontSize: size.textXMedium,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h8),
            CourseCard(
              onTap: () =>
                  Get.toNamed(AppRoutes.courseDetails, arguments: "lock"),
              title: label(
                  e: "Development of Bengali language", b: "বাংলা ভাষার বিকাশ"),
              iconData: Icons.lock,
              iconColor: clr.iconColorDimGrey,
              code: label(e: "Course Code : 1568", b: "কোর্সের কোড : ১৫৬৮"),
              time: label(
                  e: "Duration : 01/01/2024 - 06/04/2024",
                  b: "সময়কাল : ০১/০১/২০২৪ - ০৬/০৪/২০২৪"),
              statusValue: 0.0,
              status: label(e: "Will Begin", b: "শুরু হবে"),
            ),
            SizedBox(height: size.h12),
            CourseCard(
              onTap: () => Get.toNamed(AppRoutes.courseDetails),
              title: label(e: "Right to Information", b: "তথ্য অধিকার"),
              iconData: Icons.check_circle,
              code: label(e: "Course Code : 1568", b: "কোর্সের কোড : ১৫৬৮"),
              time: label(
                  e: "Duration : 12/01/2023 - 17/03/2023",
                  b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
              statusValue: 1,
              status: label(e: "Completed", b: "সম্পন্ন হয়েছে"),
            ),
            SizedBox(height: size.h12),
            CourseCard(
              onTap: () => Get.toNamed(AppRoutes.courseDetails),
              title: label(
                  e: "Education policy and management in education",
                  b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
              iconData: Icons.check_circle,
              code: label(e: "Course Code : 1568", b: "কোর্সের কোড : ১৫৬৮"),
              time: label(
                  e: "Duration : 12/01/2023 - 17/03/2023",
                  b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
              statusValue: 1,
              status: label(e: "Completed", b: "সম্পন্ন হয়েছে"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.coursesScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
