import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                text: _screenArgs.circularStatus == CircularStatus.running.name
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CourseItemSectionWidget(
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
                          onTap: () =>
                              onTapCourse(item.id, _screenArgs.circularStatus),
                        );
                      },
                    ),
                    // SizedBox(height: size.h16),
                    // if (_screenArgs.circularStatus ==
                    //     CircularStatus.running.name)
                    //   Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: size.w8),
                    //     child: Divider(
                    //         height: size.h1,
                    //         color: clr.placeHolderTextColorGray),
                    //   ),
                    // SizedBox(height: size.h16),
                    // if (_screenArgs.circularStatus ==
                    //     CircularStatus.running.name)
                    //   Text(
                    //     label(
                    //         e: "Other Ongoing Courses",
                    //         b: "অন্যান্য চলমান অধিবেশনসমূহ"),
                    //     style: TextStyle(
                    //         color: clr.appPrimaryColorGreen,
                    //         fontSize: size.textXMedium,
                    //         fontWeight: FontWeight.w600,
                    //         fontFamily: StringData.fontFamilyPoppins),
                    //   ),
                    // SizedBox(height: size.h8),
                    /*if (_screenArgs.circularStatus ==
                        CircularStatus.running.name)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 3,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return CourseCard(
                            onTap: () => Navigator.of(context).pushNamed(
                                AppRoute.courseDetailsScreen,
                                arguments: CourseDetailsScreenArgs(
                                    curriculumType: _screenArgs.circularStatus,
                                    status: "open")),
                            title: label(
                                e: "Right to Information", b: "তথ্য অধিকার"),
                            code: label(
                                e: "Course Code : 1568",
                                b: "অধিবেশনের কোড : ১৫৬৮"),
                            time: label(
                                e: "Duration : 12/01/2023 - 17/03/2023",
                                b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
                            statusValue: .8,
                            status: label(e: "80% complete", b: " ৮০% সম্পন্ন"),
                            bgColor: clr.cardFillColorOrange,
                            borderColor: clr.cardStrokeColorOrange,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: size.h16);
                        },
                      ),*/
                  ],
                );
              },
              emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                message: message,
                // constraints: constraints,
                // offset: 350.w,
              ),
            ),
          ],
        ),
      ),
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
            status: "open"));
  }
}
