import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/empty_widget.dart';

import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/all_course_data_entity.dart';
import '../services/course_list_screen_service.dart';
import '../widgets/course_card.dart';
import '../widgets/course_item_section_widget.dart';

class CourseListScreen extends StatefulWidget {
  final Object? arguments;
  const CourseListScreen({super.key, this.arguments});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with AppTheme, Language, CourseListScreenService {
  late CourseListScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseListScreenArgs;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAllCourseData(_screenArgs.circularStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _screenArgs.circularStatus == CircularStatus.running.name
          ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
          : _screenArgs.circularStatus == CircularStatus.completed.name
              ? label(e: en.completedCurriculum, b: bn.completedCurriculum)
              : _screenArgs.circularStatus == CircularStatus.upcoming.name
                  ? label(e: en.upcomingCurriculum, b: bn.upcomingCurriculum)
                  : _screenArgs.circularStatus == CircularStatus.courses.name
                      ? label(e: en.allCourse, b: bn.allCourse)
                      : "",
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                  text: _screenArgs.circularStatus ==
                          CircularStatus.running.name
                      ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
                      : _screenArgs.circularStatus ==
                              CircularStatus.completed.name
                          ? label(
                              e: en.completedCurriculum,
                              b: bn.completedCurriculum)
                          : _screenArgs.circularStatus ==
                                  CircularStatus.upcoming.name
                              ? label(
                                  e: en.upcomingCurriculum,
                                  b: bn.upcomingCurriculum)
                              : _screenArgs.circularStatus ==
                                      CircularStatus.courses.name
                                  ? label(e: en.allCourse, b: bn.allCourse)
                                  : ""),
              SizedBox(height: size.h16),
              AppStreamBuilder<AllCourseDataEntity>(
                stream: allCourseDataStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(child: CircularLoader());
                },
                dataBuilder: (context, data) {
                  return (data.courses.isEmpty &&
                          data.running.isEmpty &&
                          data.upcoming.isEmpty &&
                          data.completed.isEmpty)
                      ? EmptyWidget(
                          message: label(
                              e: 'No Course Found',
                              b: 'কোন কোর্স পাওয়া যায়নি'),
                          constraints: constraints,
                        )
                      : CourseItemSectionWidget(
                          items: _screenArgs.circularStatus ==
                                  CircularStatus.courses.name
                              ? data.courses
                              : _screenArgs.circularStatus ==
                                      CircularStatus.running.name
                                  ? data.running
                                  : _screenArgs.circularStatus ==
                                          CircularStatus.upcoming.name
                                      ? data.upcoming
                                      : data.completed,
                          buildItem: (BuildContext context, int index, item) {
                            return CourseCard(
                              data: item,
                              circularStatus: _screenArgs.circularStatus,
                              onTap: () => onTapCourse(
                                  item.id, _screenArgs.circularStatus),
                            );
                          },
                        );
                },
                emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                  message: message,
                  title:
                      label(e: 'No Course Found', b: 'কোন কোর্স পাওয়া যায়নি'),
                  // constraints: constraints,
                  // offset: 350.w,
                ),
              ),
            ],
          ),
        );
      }),
    );
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
        ));
  }
}
