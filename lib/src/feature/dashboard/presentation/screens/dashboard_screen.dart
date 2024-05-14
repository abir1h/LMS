import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../landing/presentation/widgets/row_item_template.dart';
import '../../../leaderboard/widgets/leaderboard_item_widget.dart';
import '../../domain/entities/dashboard_data_entity.dart';
import '../services/dashboard_screen_service.dart';
import '../widgets/custom_notice_card.dart';
import '../widgets/leaderboard_section_widget.dart';
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
    with AppTheme, Language, AppEventsNotifier, DashboardScreenService {
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<DashboardDataEntity>(
      stream: dashboardDataStreamController.stream,
      loadingBuilder: (context) {
        return const Center(child: CircularLoader());
      },
      dataBuilder: (context, data) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.h16),
              if (data.courses.isNotEmpty)
                RunningCourseCard(
                  onPressed: () => onTapRunningModule(),
                  image: Image.asset("assets/images/image.png"),
                  text1: label(
                      e: data.courses.first.batchNameEn,
                      b: data.courses.first.batchNameBn),
                  text2: label(
                      e: data.courses.first.nameEn,
                      b: data.courses.first.nameBn),
                  text3: label(
                      e: "${data.courses.first.courseProgress}% ${en.completed}",
                      b: "${replaceEnglishNumberWithBengali(data.courses.first.courseProgress.toString())}% ${bn.completed}"),
                ),
              // SizedBox(height: size.h20),
              RowItemTemplate(
                  leftChild: DashboardCard(
                    title:
                        label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
                    onPressed: () => onTapCard(CircularStatus.running.name),
                    subTitle: label(
                        e: data.courseSummery.runningCourses.toString(),
                        b: replaceEnglishNumberWithBengali(
                            data.courseSummery.runningCourses.toString())),
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
                    onPressed: () => onTapCard(CircularStatus.completed.name),
                    subTitle: label(
                        e: data.courseSummery.completedCourses.toString(),
                        b: replaceEnglishNumberWithBengali(
                            data.courseSummery.completedCourses.toString())),
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
                    onPressed: () => onTapCard(CircularStatus.upcoming.name),
                    subTitle: label(
                        e: data.courseSummery.upcomingCourses.toString(),
                        b: replaceEnglishNumberWithBengali(
                            data.courseSummery.upcomingCourses.toString())),
                    borderColor: clr.cardStrokeColorBlue,
                    primaryColor: clr.cardFillColorBlue,
                    image: SvgPicture.asset(
                      ImageAssets.imgTraineeCard3,
                      height: size.h32,
                    ),
                  ),
                  rightChild: DashboardCard(
                    title: label(e: en.allCourse, b: bn.allCourse),
                    onPressed: () => onTapCard(CircularStatus.courses.name),
                    subTitle: label(
                        e: data.courses.length.toString(),
                        b: replaceEnglishNumberWithBengali(
                            data.courses.length.toString())),
                    borderColor: clr.cardStrokeColorPurple,
                    primaryColor: clr.cardFillColorPurple,
                    image: SvgPicture.asset(
                      ImageAssets.imgTraineeCard3,
                      height: size.h32,
                    ),
                  )),
              SizedBox(height: size.h20),
              EffectivePeriodSection(),
              SizedBox(height: size.h20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: CustomTextWidget(
                    text: label(e: en.noticeBoard, b: bn.noticeBoard)),
              ),
              SizedBox(height: size.h12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: CustomNoticeCard(
                    leading: Icon(
                      Icons.auto_stories,
                      color: clr.appPrimaryColorGreen,
                      size: size.r20,
                    ),
                    title:
                        label(e: StringData.notice1, b: StringData.notice1Bn)),
              ),
              SizedBox(height: size.h12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w16),
                child: CustomNoticeCard(
                    leading: Icon(
                      Icons.event_available_rounded,
                      color: clr.iconColorRed,
                      size: size.r20,
                    ),
                    title:
                        label(e: StringData.notice2, b: StringData.notice2Bn)),
              ),
              SizedBox(height: size.h32),
              LeaderboardSectionWidget(
                onTapSeeAll: onTapSeeAll,
                items: const ["", "", ""],
                buildItem: (BuildContext context, int index, item) {
                  return LeaderboardItemWidget();
                },
              ),
              SizedBox(height: size.h32),
            ],
          ),
        );
      },
      emptyBuilder: (context, message, icon) => CustomEmptyWidget(
        message: message,
        // constraints: constraints,
        // offset: 350.w,
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

  @override
  void navigateToLeaderBoardScreen() {
    Navigator.of(context).pushNamed(AppRoute.leaderboardScreen);
  }

  @override
  void navigateToCourseListScreen(String circularStatus) {
    Navigator.of(context).pushNamed(AppRoute.courseListScreen,
        arguments: CourseListScreenArgs(circularStatus: circularStatus));
  }

  @override
  void navigateToTranscriptVideoScreen() {
    // Navigator.of(context).pushNamed(AppRoute.transcriptVideoScreen,
    //     arguments: CourseVideoScreenArgs(
    //         contentId: contentId,
    //         contentType: contentType,
    //         contentTitleEn: contentTitleEn,
    //         contentTitleBn: contentTitleBn));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class EffectivePeriodSection extends StatelessWidget with AppTheme, Language {
  const EffectivePeriodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.15))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: label(e: en.effectivePeriod, b: bn.effectivePeriod),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: size.h12),
          const GraphChart(),
        ],
      ),
    );
  }
}
