import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../landing/presentation/widgets/row_item_template.dart';
import '../widgets/custom_notice_card.dart';
import '../controller/dashboard_controller.dart';
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
      Get.put(DashboardController());

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
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoute.transcriptVideoScreen),
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
                  onPressed: () => Navigator.of(context).pushNamed(
                      AppRoute.courseListScreen,
                      arguments:
                          CourseListScreenArgs(curriculumType: "running")),
                  // onPressed: () =>
                  //     Get.toNamed(AppRoutes.courseList, arguments: "running"),
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
                  onPressed: () => Navigator.of(context).pushNamed(
                      AppRoute.courseListScreen,
                      arguments:
                          CourseListScreenArgs(curriculumType: "completed")),
                  // onPressed: () =>
                  //     Get.toNamed(AppRoutes.courseList, arguments: "completed"),
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
                  titleColor: clr.appPrimaryColorGreen,
                  onPressed: () => Navigator.of(context).pushNamed(
                      AppRoute.courseListScreen,
                      arguments:
                          CourseListScreenArgs(curriculumType: "upcoming")),
                  // onPressed: () =>
                  //     Get.toNamed(AppRoutes.courseList, arguments: "upcoming"),
                  subTitle: label(
                      e: StringData.dashboardCardValue3,
                      b: StringData.dashboardCardValue3Bn),
                  borderColor: clr.cardStrokeColorBlue,
                  primaryColor: clr.cardFillColorBlue,
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
                  borderColor: clr.cardStrokeColorPurple,
                  primaryColor: clr.cardFillColorPurple,
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
