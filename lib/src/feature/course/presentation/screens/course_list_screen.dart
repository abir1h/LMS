import 'package:flutter/material.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatefulWidget {
  final Object? arguments;
  const CourseListScreen({super.key, this.arguments});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with AppTheme, Language {
  late CourseListScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseListScreenArgs;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _screenArgs.curriculumType == "running"
          ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
          : _screenArgs.curriculumType == "completed"
              ? label(e: en.completedCurriculum, b: bn.completedCurriculum)
              : _screenArgs.curriculumType == "upcoming"
                  ? label(e: en.upcomingCurriculum, b: bn.upcomingCurriculum)
                  : "",
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidgets(
                text: _screenArgs.curriculumType == "running"
                    ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
                    : _screenArgs.curriculumType == "completed"
                        ? label(
                            e: en.completedCurriculum,
                            b: bn.completedCurriculum)
                        : _screenArgs.curriculumType == "upcoming"
                            ? label(
                                e: en.upcomingCurriculum,
                                b: bn.upcomingCurriculum)
                            : ""),
            SizedBox(height: size.h16),
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _screenArgs.curriculumType == "running" ? 1 : 5,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _screenArgs.curriculumType == "running"
                    ? CourseCard(
                        onTap: () => Navigator.of(context).pushNamed(
                            AppRoute.courseDetailsScreen,
                            arguments: CourseDetailsScreenArgs(
                                curriculumType: _screenArgs.curriculumType,
                                status: "open")),
                        title:
                            label(e: "Right to Information", b: "তথ্য অধিকার"),
                        code: label(
                            e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
                        time: label(
                            e: "Duration : 12/01/2023 - 17/03/2023",
                            b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
                        statusValue: .8,
                        status: label(e: "80% complete", b: " ৮০% সম্পন্ন"),
                        bgColor: clr.cardFillColorOrange,
                        borderColor: clr.cardStrokeColorOrange,
                      )
                    : _screenArgs.curriculumType == "completed"
                        ? CourseCard(
                            onTap: () => Navigator.of(context).pushNamed(
                                AppRoute.courseDetailsScreen,
                                arguments: CourseDetailsScreenArgs(
                                    curriculumType: _screenArgs.curriculumType,
                                    status: "done")),
                            title: label(
                                e: "Right to Information", b: "তথ্য অধিকার"),
                            iconData: Icons.check_circle,
                            code: label(
                                e: "Course Code : 1568",
                                b: "অধিবেশনের কোড : ১৫৬৮"),
                            time: label(
                                e: "Duration : 12/01/2023 - 17/03/2023",
                                b: "সময়কাল : ১২/০১/২০২৩ - ১৭/০৩/২০২৩ "),
                            statusValue: 1,
                            status: label(e: "Completed", b: "সম্পন্ন হয়েছে"),
                          )
                        : CourseCard(
                            onTap: () => Navigator.of(context).pushNamed(
                                AppRoute.courseDetailsScreen,
                                arguments: CourseDetailsScreenArgs(
                                    curriculumType: _screenArgs.curriculumType,
                                    status: "")),
                            title: label(
                                e: "Development of Bengali language",
                                b: "বাংলা ভাষার বিকাশ"),
                            iconData: Icons.lock,
                            iconColor: clr.iconColorDimGrey,
                            code: label(
                                e: "Course Code : 1568",
                                b: "অধিবেশনের কোড : ১৫৬৮"),
                            time: label(
                                e: "Duration : 01/01/2024 - 06/04/2024",
                                b: "সময়কাল : ০১/০১/২০২৪ - ০৬/০৪/২০২৪"),
                            statusValue: 0.0,
                            status: label(e: "Will Begin", b: "শুরু হবে"),
                            bgColor: clr.cardFillColorBlue,
                            borderColor: clr.cardStrokeColorBlue,
                          );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: size.h16);
              },
            ),
            SizedBox(height: size.h16),
            if (_screenArgs.curriculumType == "running")
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w8),
                child: Divider(
                    height: size.h1, color: clr.placeHolderTextColorGray),
              ),
            SizedBox(height: size.h16),
            if (_screenArgs.curriculumType == "running")
              Text(
                label(
                    e: "Other Ongoing Courses",
                    b: "অন্যান্য চলমান অধিবেশনসমূহ"),
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            SizedBox(height: size.h8),
            if (_screenArgs.curriculumType == "running")
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
                            curriculumType: _screenArgs.curriculumType,
                            status: "open")),
                    title: label(e: "Right to Information", b: "তথ্য অধিকার"),
                    code: label(
                        e: "Course Code : 1568", b: "অধিবেশনের কোড : ১৫৬৮"),
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
              ),
          ],
        ),
      ),
      // body: ListView.separated(
      //   shrinkWrap: true,
      //   physics: const BouncingScrollPhysics(),
      //   itemCount: 3,
      //   padding: EdgeInsets.symmetric(vertical: size.h12),
      //   itemBuilder: (context, index) {
      //     return const CourseWidget();
      //   },
      //   separatorBuilder: (context, index) {
      //     return SizedBox(height: size.h32);
      //   },
      // ),
    );
  }
}
