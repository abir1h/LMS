import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../course/presentation/controllers/course_controller.dart';
import '../../../course/presentation/screens/course_screen.dart';
import '../../../../core/utility/app_label.dart';
import '../../../notes/presentation/screens/note_screen.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../profile/presentation/widgets/recognition_widget.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with AppTheme, Language, AppEventsNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      endDrawer: const RecognitionWidget(),
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: _currentPageIndex == 0
              ? label(e: en.appBarText, b: bn.appBarText)
              : _currentPageIndex == 1
                  ? label(e: en.courseText, b: bn.courseText)
                  : _currentPageIndex == 2
                      ? label(e: en.allNotes, b: bn.allNotes)
                      : label(e: en.profileAppBarText, b: bn.profileAppBarText),
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          trailingOnPressed: () {
            if (_currentPageIndex != 2) {
              Get.toNamed(AppRoutes.notification);
            }
          },
          trailing: _currentPageIndex == 2
              ? Icon(
                  Icons.search,
                  color: clr.appPrimaryColorGreen,
                  size: size.r24,
                )
              : Stack(
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
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
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
    );
    //region old
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
    //endregion
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
