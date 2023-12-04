import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_screen.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> with AppTheme {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<Widget> pages = [
    const DashboardScreen(),
    Container(),
    const NoteScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController, allowImplicitScrolling: false,
            scrollBehavior: ScrollBehavior(),
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemCount: pages.length, // Set the number of pages
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        ),
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
              _pageController!.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: size.r24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_stories,
                size: size.r24,
              ),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
                size: size.r24,
              ),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.profile_circled,
                size: size.r24,
              ),
              label: 'My Profile',
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }
}
