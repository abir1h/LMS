import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../course/presentation/controllers/course_controller.dart';
import '../../../course/presentation/screens/course_screen.dart';
import '../../../../core/utility/app_label.dart';
import '../../../notes/presentation/screens/note_screen.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({
    super.key,
  });

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen>
    with AppTheme, Language, AppEventsNotifier {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<Widget> pages = [
    const DashboardScreen(),
    const CourseScreen(),
    const NoteScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPage();
    Get.put(DashboardController());
    Get.put(CourseController());
  }

  setPage() {
    final args = Get.arguments ?? 0;
    print(args);
    _currentPageIndex = args;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: pages[_currentPageIndex]),
        BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentPageIndex,
          selectedItemColor: clr.appSecondaryColorFlagRed,
          unselectedItemColor: clr.appPrimaryColorGreen,
          iconSize: 24.h,
          selectedLabelStyle: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontFamily: StringData.fontFamilyRoboto,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: size.r24,
              ),
              label: label(e: en.homeText, b: bn.homeText),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_stories,
                size: size.r24,
              ),
              label: label(e: en.coursesText, b: bn.coursesText),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
                size: size.r24,
              ),
              label: label(e: en.notesText, b: bn.notesText),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.profile_circled,
                size: size.r24,
              ),
              label: label(e: en.profileText, b: bn.profileText),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavBar) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
