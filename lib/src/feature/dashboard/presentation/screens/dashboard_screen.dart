import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../landing/presentation/widgets/row_item_template.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../widgets/custom_notice_card.dart';
import '../controller/dashboard_controller.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../widgets/course_card.dart';
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
    with AppTheme, Language {
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                        text: label(e: en.runningModule, b: bn.runningModule)),
                    Padding(
                      padding: EdgeInsets.only(right: size.w6),
                      child: SvgPicture.asset(ImageAssets.icLockOpenRight),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                CourseCard(
                  onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                  image: Image.asset("assets/images/image.png"),
                  text1: StringData.cardText1,
                  text2: StringData.cardText2,
                  text3:
                      label(e: "30% ${en.completed}", b: "৩০% ${bn.completed}"),
                  primaryColor: Colors.white,
                ),
                SizedBox(height: size.h20),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      title:
                          label(e: en.ongoingCurriculum, b: bn.runningModule),
                      onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                      subTitle: StringData.dashboardCardValue1,
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
                      onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                      subTitle: StringData.dashboardCardValue2,
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
                      title: label(e: en.discussionArea, b: bn.discussionArea),
                      onPressed: () {},
                      subTitle: StringData.dashboardCardValue3,
                      borderColor: clr.cardStrokeColorPurple,
                      primaryColor: clr.cardFillColorPurple,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard3,
                        height: size.h32,
                      ),
                    ),
                    rightChild: DashboardCard(
                      title: label(e: en.notifications, b: bn.notifications),
                      onPressed: () {},
                      subTitle: StringData.dashboardCardValue4,
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
                    title: StringData.notice1),
                SizedBox(height: size.h32),
              ],
            ),
          ),
        ));
  }
}
