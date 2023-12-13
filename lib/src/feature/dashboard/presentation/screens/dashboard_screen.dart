import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../landing/presentation/widgets/row_item_template.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../widgets/custom_notice_card.dart';
import '../controller/dashboard_controller.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../widgets/running_course_card.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/graph_chart.dart';
import '../../../../core/constants/common_imports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AppTheme, Language, AppEventsNotifier {
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RunningCourseCard(
              onPressed: () => Get.toNamed(AppRoutes.transcriptVideo),
              image: Image.asset("assets/images/image.png"),
              text1: label(e: StringData.cardText1, b: StringData.cardText1Bn),
              text2: label(e: StringData.cardText2, b: StringData.cardText2Bn),
              text3: label(e: "10% ${en.completed}", b: "১০% ${bn.completed}"),
            ),
            SizedBox(height: size.h20),
            RowItemTemplate(
                leftChild: DashboardCard(
                  title:
                      label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
                  // onPressed: () => Get.toNamed(AppRoutes.ongoingCourse,
                  //     arguments: "ongoing"),
                  onPressed: () =>
                      Get.toNamed(AppRoutes.courseDetails, arguments: ""),
                  subTitle: label(
                      e: StringData.dashboardCardValue1,
                      b: StringData.dashboardCardValue1Bn),
                  borderColor: clr.cardStrokeColorOrange,
                  primaryColor: clr.cardFillColorOrange,
                  image: SvgPicture.asset(
                    ImageAssets.imgTraineeCard1,
                    height: size.h32,
                  ),
                ),
                rightChild: DashboardCard(
                  title: label(
                      e: en.completedCurriculum, b: bn.completedCurriculum),
                  onPressed: () =>
                      Get.toNamed(AppRoutes.courseList, arguments: "completed"),
                  subTitle: label(
                      e: StringData.dashboardCardValue2,
                      b: StringData.dashboardCardValue2Bn),
                  borderColor: clr.cardStrokeColorGreen,
                  primaryColor: clr.cardFillColorGreen,
                  image: SvgPicture.asset(
                    ImageAssets.imgTraineeCard1,
                    height: size.h32,
                  ),
                )),
            SizedBox(height: size.h12),
            RowItemTemplate(
                leftChild: DashboardCard(
                  title:
                      label(e: en.upcomingCurriculum, b: bn.upcomingCurriculum),
                  onPressed: () =>
                      Get.toNamed(AppRoutes.courseList, arguments: "upcoming"),
                  subTitle: label(
                      e: StringData.dashboardCardValue3,
                      b: StringData.dashboardCardValue3Bn),
                  borderColor: clr.cardStrokeColorPurple,
                  primaryColor: clr.cardFillColorPurple,
                  image: SvgPicture.asset(
                    ImageAssets.imgTraineeCard3,
                    height: size.h32,
                  ),
                ),
                rightChild: DashboardCard(
                  title: label(e: en.discussionArea, b: bn.discussionArea),
                  onPressed: () {},
                  subTitle: label(
                      e: StringData.dashboardCardValue4,
                      b: StringData.dashboardCardValue4Bn),
                  borderColor: clr.cardFillColorBlue,
                  primaryColor: clr.cardStrokeColorBlue,
                  image: SvgPicture.asset(
                    ImageAssets.imgTraineeCard3,
                    height: size.h32,
                  ),
                )),
            SizedBox(height: size.h32),
            CustomTextWidgets(
                text: label(e: en.effectivePeriod, b: bn.effectivePeriod)),
            SizedBox(height: size.h12),
            const GraphChart(),
            SizedBox(height: size.h20),
            CustomTextWidgets(
                text: label(e: en.noticeBoard, b: bn.noticeBoard)),
            SizedBox(height: size.h12),
            CustomNoticeCard(
                leading: Icon(
                  Icons.auto_stories,
                  color: clr.appPrimaryColorGreen,
                  size: size.r20,
                ),
                title: label(e: StringData.notice1, b: StringData.notice1Bn)),
            SizedBox(height: size.h12),
            CustomNoticeCard(
                leading: Icon(
                  Icons.event_available_rounded,
                  color: clr.iconColorRed,
                  size: size.r20,
                ),
                title: label(e: StringData.notice2, b: StringData.notice2Bn)),
            SizedBox(height: size.h32),
          ],
        ),
      ),
    );
    //region old dashboard screen
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: clr.scaffoldBackgroundColor,
        drawer: const DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.h56),
          child: CustomAppBar(
            title: label(e: en.appBarText, b: bn.appBarText),
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
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidgets(
                        text: label(e: en.ongoingModule, b: bn.ongoingModule)),
                    Padding(
                      padding: EdgeInsets.only(right: size.w6),
                      child: SvgPicture.asset(ImageAssets.icLockOpenRight),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                RunningCourseCard(
                  onPressed: () =>
                      Get.toNamed(AppRoutes.courseDetails, arguments: ""),
                  image: Image.asset("assets/images/image.png"),
                  text1:
                      label(e: StringData.cardText1, b: StringData.cardText1Bn),
                  text2:
                      label(e: StringData.cardText2, b: StringData.cardText2Bn),
                  text3:
                      label(e: "10% ${en.completed}", b: "১০% ${bn.completed}"),
                  // primaryColor: Colors.white,
                ),
                SizedBox(height: size.h20),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      title: label(
                          e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
                      // onPressed: () => Get.toNamed(AppRoutes.ongoingCourse,
                      //     arguments: "ongoing"),
                      onPressed: () =>
                          Get.toNamed(AppRoutes.courseDetails, arguments: ""),
                      subTitle: label(
                          e: StringData.dashboardCardValue1,
                          b: StringData.dashboardCardValue1Bn),
                      borderColor: clr.cardStrokeColorOrange,
                      primaryColor: clr.cardFillColorOrange,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard1,
                        height: size.h32,
                      ),
                    ),
                    rightChild: DashboardCard(
                      title: label(
                          e: en.completedCurriculum, b: bn.completedCurriculum),
                      onPressed: () {},
                      // onPressed: () => Get.toNamed(AppRoutes.ongoingCourse,
                      //     arguments: "completed"),
                      subTitle: label(
                          e: StringData.dashboardCardValue2,
                          b: StringData.dashboardCardValue2Bn),
                      borderColor: clr.cardStrokeColorGreen,
                      primaryColor: clr.cardFillColorGreen,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard1,
                        height: size.h32,
                      ),
                    )),
                SizedBox(height: size.h12),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      title: label(
                          e: en.upcomingCurriculum, b: bn.upcomingCurriculum),
                      onPressed: () {},
                      subTitle: label(
                          e: StringData.dashboardCardValue3,
                          b: StringData.dashboardCardValue3Bn),
                      borderColor: clr.cardStrokeColorPurple,
                      primaryColor: clr.cardFillColorPurple,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard3,
                        height: size.h32,
                      ),
                    ),
                    rightChild: DashboardCard(
                      title: label(e: en.discussionArea, b: bn.discussionArea),
                      onPressed: () {},
                      subTitle: label(
                          e: StringData.dashboardCardValue4,
                          b: StringData.dashboardCardValue4Bn),
                      borderColor: clr.cardFillColorBlue,
                      primaryColor: clr.cardStrokeColorBlue,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard3,
                        height: size.h32,
                      ),
                    )),
                SizedBox(height: size.h32),
                CustomTextWidgets(
                    text: label(e: en.effectivePeriod, b: bn.effectivePeriod)),
                SizedBox(height: size.h12),
                const GraphChart(),
                SizedBox(height: size.h20),
                CustomTextWidgets(
                    text: label(e: en.noticeBoard, b: bn.noticeBoard)),
                SizedBox(height: size.h12),
                CustomNoticeCard(
                    leading: Icon(
                      Icons.auto_stories,
                      color: clr.appPrimaryColorGreen,
                      size: size.r20,
                    ),
                    title:
                        label(e: StringData.notice1, b: StringData.notice1Bn)),
                SizedBox(height: size.h12),
                CustomNoticeCard(
                    leading: Icon(
                      Icons.event_available_rounded,
                      color: clr.iconColorRed,
                      size: size.r20,
                    ),
                    title:
                        label(e: StringData.notice2, b: StringData.notice2Bn)),
                SizedBox(height: size.h32),
              ],
            ),
          ),
        ));
    //endregion
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.dashBoardScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
