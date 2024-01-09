import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/course_list_controller.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with AppTheme, Language {
  final CourseListController controller = Get.find<CourseListController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: controller.screenName.value == "running"
          ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
          : controller.screenName.value == "completed"
              ? label(e: en.completedCurriculum, b: bn.completedCurriculum)
              : controller.screenName.value == "upcoming"
                  ? label(e: en.upcomingCurriculum, b: bn.upcomingCurriculum)
                  : "",
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidgets(
                text: controller.screenName.value == "running"
                    ? label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum)
                    : controller.screenName.value == "completed"
                        ? label(
                            e: en.completedCurriculum,
                            b: bn.completedCurriculum)
                        : controller.screenName.value == "upcoming"
                            ? label(
                                e: en.upcomingCurriculum,
                                b: bn.upcomingCurriculum)
                            : ""),
            SizedBox(height: size.h16),
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.screenName.value == "running" ? 1 : 5,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return controller.screenName.value == "running"
                    ? CourseCard(
                        onTap: () => Get.toNamed(AppRoutes.courseDetails,
                            arguments: {'from': "running", 'status': "open"}),
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
                    : controller.screenName.value == "completed"
                        ? CourseCard(
                            onTap: () => Get.toNamed(AppRoutes.courseDetails,
                                arguments: {
                                  'from': "completed",
                                  'status': "done"
                                }),
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
                            onTap: () => Get.toNamed(AppRoutes.courseDetails,
                                arguments: {'from': "upcoming", 'status': ""}),
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
            if (controller.screenName.value == "running")
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w8),
                child: Divider(
                    height: size.h1, color: clr.placeHolderTextColorGray),
              ),
            SizedBox(height: size.h16),
            if (controller.screenName.value == "running")
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
            if (controller.screenName.value == "running")
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return CourseCard(
                    onTap: () => Get.toNamed(AppRoutes.courseDetails,
                        arguments: {'from': "running", 'status': ""}),
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
