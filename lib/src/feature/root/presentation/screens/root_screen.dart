import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../course/presentation/controllers/course_controller.dart';
import '../../../course/presentation/screens/course_screen.dart';
import '../../../../core/utility/app_label.dart';
import '../../../notes/presentation/screens/note_edit_screen.dart';
import '../../../notes/presentation/screens/note_screen.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../profile/presentation/widgets/recognition_widget.dart';

class RootScreen extends StatefulWidget {
  final Object? arguments;
  const RootScreen({super.key, this.arguments});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with AppTheme, Language, AppEventsNotifier {
  late RootScreenArgs _screenArgs;

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
    super.initState();
    _screenArgs = widget.arguments as RootScreenArgs;
    setPage();
    Get.put(DashboardController());
    Get.put(CourseController());
  }

  setPage() {
    _currentPageIndex = _screenArgs.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _currentPageIndex == 3
          ? clr.iconColorWhiteIce
          : clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      endDrawer: const RecognitionWidget(),
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: _currentPageIndex == 0
              ? label(e: en.appBarText, b: bn.appBarText)
              : _currentPageIndex == 1
                  ? label(e: en.coursesText, b: bn.coursesText)
                  : _currentPageIndex == 2
                      ? label(e: en.allNotes, b: bn.allNotes)
                      : label(e: en.profileAppBarText, b: bn.profileAppBarText),
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          leading: Icon(
            Icons.menu,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
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
          trailingOnPressed: () {
            if (_currentPageIndex != 2) {
              Navigator.of(context).pushNamed(AppRoute.notificationScreen);
            }
          },
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
              _currentPageIndex == 0 ? Icons.home_outlined : Icons.home,
              size: size.r24,
            ),
            label: label(e: en.homeText, b: bn.homeText),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 1
                  ? Icons.auto_stories_outlined
                  : Icons.auto_stories,
              size: size.r24,
            ),
            label: label(e: en.coursesText, b: bn.coursesText),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 2
                  ? Icons.assignment_outlined
                  : Icons.assignment,
              size: size.r24,
            ),
            label: label(e: en.notesText, b: bn.notesText),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 3
                  ? Icons.account_circle_outlined
                  : CupertinoIcons.profile_circled,
              size: size.r24,
            ),
            label: label(e: en.profileText, b: bn.profileText),
          ),
        ],
      ),
      floatingActionButton: _currentPageIndex == 2
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoute.noteEditScreen);
              },
              child: Container(
                padding: EdgeInsets.all(size.r16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: clr.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  ImageAssets.icEditSquare,
                ),
              ),
            )
          : null,
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
