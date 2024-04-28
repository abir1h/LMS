import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../services/course_screen_service.dart';
import '../widgets/course_card.dart';
import '../widgets/course_item_section_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with AppTheme, Language, CourseScreenService, AppEventsNotifier {
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<AllCourseDataEntity>(
      stream: allCourseDataStreamController.stream,
      loadingBuilder: (context) {
        return const Center(child: CircularLoader());
      },
      dataBuilder: (context, data) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Running Course
              CustomTextWidget(
                text: label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
                fontSize: size.textXMedium,
              ),
              SizedBox(height: size.h8),
              data.running.isNotEmpty
                  ? CourseItemSectionWidget(
                      items: data.running,
                      buildItem: (BuildContext context, int index, item) {
                        return CourseCard(
                          data: item,
                          circularStatus: CircularStatus.running.name,
                          onTap: () =>
                              onTapCourse(item.id, CircularStatus.running.name),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        children: [
                          Lottie.asset(ImageAssets.animEmpty,
                              height: size.h56 * 1.2),
                          CustomTextWidget(
                            text: label(
                                e: "No Running Course Found",
                                b: "কোনো চলমান কোর্স পাওয়া যায়নি"),
                            textColor: clr.textColorBlack,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: size.h16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w8),
                child: Divider(
                    height: size.h1, color: clr.placeHolderTextColorGray),
              ),
              SizedBox(height: size.h16),

              ///Upcoming Course
              CustomTextWidget(
                text: label(e: en.upcomingCurriculum, b: bn.upcomingCurriculum),
                fontSize: size.textXMedium,
              ),
              SizedBox(height: size.h12),
              data.upcoming.isNotEmpty
                  ? CourseItemSectionWidget(
                      items: data.upcoming,
                      buildItem: (BuildContext context, int index, item) {
                        return CourseCard(
                          data: item,
                          circularStatus: CircularStatus.upcoming.name,
                          onTap: () => Navigator.of(context).pushNamed(
                              AppRoute.courseDetailsScreen,
                              arguments: CourseDetailsScreenArgs(
                                  courseId: item.id,
                                  curriculumType: CircularStatus.upcoming.name,
                                  status: "lock")),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        children: [
                          Lottie.asset(ImageAssets.animEmpty,
                              height: size.h56 * 1.2),
                          CustomTextWidget(
                            text: label(
                                e: "No Upcoming Course Found",
                                b: "কোনো আসন্ন কোর্স পাওয়া যায়নি"),
                            textColor: clr.textColorBlack,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: size.h16),

              ///Completed Course
              CustomTextWidget(
                text:
                    label(e: en.completedCurriculum, b: bn.completedCurriculum),
                fontSize: size.textXMedium,
              ),
              SizedBox(height: size.h12),
              data.completed.isNotEmpty
                  ? CourseItemSectionWidget(
                      items: data.completed,
                      buildItem: (BuildContext context, int index, item) {
                        return CourseCard(
                          data: item,
                          circularStatus: CircularStatus.upcoming.name,
                          onTap: () => Navigator.of(context).pushNamed(
                              AppRoute.courseDetailsScreen,
                              arguments: CourseDetailsScreenArgs(
                                  courseId: item.id,
                                  curriculumType: CircularStatus.upcoming.name,
                                  status: "lock")),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        children: [
                          Lottie.asset(ImageAssets.animEmpty,
                              height: size.h56 * 1.2),
                          CustomTextWidget(
                            text: label(
                                e: "No Completed Course Found",
                                b: "কোনো সম্পন্ন কোর্স পাওয়া যায়নি"),
                            textColor: clr.textColorBlack,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
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
        action == EventAction.coursesScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToCourseDetailsScreen(int courseId, String circularStatus) {
    Navigator.of(context).pushNamed(AppRoute.courseDetailsScreen,
        arguments: CourseDetailsScreenArgs(
            courseId: courseId,
            curriculumType: circularStatus,
            status: "open"));
  }
}
