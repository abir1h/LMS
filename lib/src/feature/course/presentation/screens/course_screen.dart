import 'package:flutter/material.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../widgets/course_card.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with AppTheme, Language, AppEventsNotifier {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
            style: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textXMedium,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyRoboto),
          ),
          SizedBox(height: size.h8),
          CourseCard(
            onTap: () => Navigator.of(context).pushNamed(
                AppRoute.courseDetailsScreen,
                arguments: CourseDetailsScreenArgs(
                    curriculumType: "running", status: "open")),
            title: label(
                e: "Education policy and management in education",
                b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
            titleFontSize: size.textXMedium,
            code: label(e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
            time: label(
                e: "Duration : 12/06/2023 - 17/03/2024",
                b: "সময়কাল : ১২/০৬/২০২৩ - ১৭/০৩/২০২৪"),
            statusValue: .1,
            status: label(e: "10% ${en.completed}", b: "১০% ${bn.completed}"),
            bgColor: clr.cardFillColorOrange,
            borderColor: clr.cardStrokeColorOrange,
          ),
          SizedBox(height: size.h16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.w8),
            child:
                Divider(height: size.h1, color: clr.placeHolderTextColorGray),
          ),
          SizedBox(height: size.h16),
          Text(
            label(e: "Other Courses", b: "অন্যান্য অধিবেশনসমূহ"),
            style: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textXMedium,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyPoppins),
          ),
          SizedBox(height: size.h8),
          CourseCard(
            onTap: () => Navigator.of(context).pushNamed(
                AppRoute.courseDetailsScreen,
                arguments: CourseDetailsScreenArgs(
                    curriculumType: "upcoming", status: "")),
            title: label(
                e: "Development of Bengali language", b: "বাংলা ভাষার বিকাশ"),
            iconData: Icons.lock,
            iconColor: clr.iconColorDimGrey,
            code: label(e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
            time: label(
                e: "Duration : 01/01/2024 - 06/04/2024",
                b: "সময়কাল : ০১/০১/২০২৪ - ০৬/০৪/২০২৪"),
            statusValue: 0.0,
            status: label(e: "Will Begin", b: "শুরু হবে"),
            bgColor: clr.cardFillColorBlue,
            borderColor: clr.cardStrokeColorBlue,
          ),
          SizedBox(height: size.h12),
          CourseCard(
            onTap: () => Navigator.of(context).pushNamed(
                AppRoute.courseDetailsScreen,
                arguments: CourseDetailsScreenArgs(
                    curriculumType: "completed", status: "done")),
            title: label(e: "Right to Information", b: "তথ্য অধিকার"),
            iconData: Icons.check_circle,
            code: label(e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
            time: label(
                e: "Duration : 12/01/2023 - 17/03/2023",
                b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
            statusValue: 1,
            status: label(e: "Completed", b: "সম্পন্ন হয়েছে"),
          ),
          SizedBox(height: size.h12),
          CourseCard(
            onTap: () => Navigator.of(context).pushNamed(
                AppRoute.courseDetailsScreen,
                arguments: CourseDetailsScreenArgs(
                    curriculumType: "completed", status: "done")),
            title: label(
                e: "Education policy and management in education",
                b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা"),
            iconData: Icons.check_circle,
            code: label(e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
            time: label(
                e: "Duration : 12/01/2023 - 17/03/2023",
                b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
            statusValue: 1,
            status: label(e: "Completed", b: "সম্পন্ন হয়েছে"),
          ),
        ],
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
