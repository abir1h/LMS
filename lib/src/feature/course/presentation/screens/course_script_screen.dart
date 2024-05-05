import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_expanded_text.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/script_data_entity.dart';
import '../services/course_script_screen_service.dart';
import '../widgets/chapter_details_widget.dart';
import '../widgets/discussion_widget.dart';
import '../widgets/note_widget.dart';
import '../widgets/sliver_tab_section_widget.dart';

class CourseScriptScreen extends StatefulWidget {
  final Object? arguments;
  const CourseScriptScreen({super.key, this.arguments});

  @override
  State<CourseScriptScreen> createState() => _CourseScriptScreenState();
}

class _CourseScriptScreenState extends State<CourseScriptScreen>
    with AppTheme, Language, CourseScriptScreenService {
  late CourseScriptScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseScriptScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadScriptData(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(
            e: "Introduction, Chapter Description",
            b: "ভূমিকা, অধ্যায়ের বিবরণ"),
        bgColor: clr.whiteColor,
        body: AppStreamBuilder<ScriptDataEntity>(
          stream: scriptDetailsDataStreamController.stream,
          loadingBuilder: (context) {
            return const Center(child: CircularLoader());
          },
          dataBuilder: (context, data) {
            return SliverTabSectionWidget(
              tabBarItem1: ChapterDetailsWidget(
                  description: label(
                      e: _screenArgs.courseDescriptionEn,
                      b: _screenArgs.courseDescriptionBn)),
              tabBarItem2:
                  const NoteWidget(physics: NeverScrollableScrollPhysics()),
              tabBarItem3: DiscussionWidget(
                  courseId: data.courseId,
                  courseModuleId: data.courseModuleId,
                  contentId: _screenArgs.courseContentId,
                  contentType: _screenArgs.courseContentType,
                  physics: const NeverScrollableScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.h12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: label(e: data.titleEn, b: data.titleBn),
                            fontSize: size.textXMedium,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: size.w10),
                        Container(
                          padding: EdgeInsets.all(size.r1),
                          decoration: BoxDecoration(
                            color: clr.whiteColor,
                            borderRadius: BorderRadius.circular(size.r4),
                            border: Border.all(
                                color: clr.cardStrokeColor, width: size.r1),
                            boxShadow: [
                              BoxShadow(
                                color: clr.blackColor.withOpacity(.2),
                                blurRadius: size.r4,
                                offset: Offset(0.0, size.h2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.save_alt,
                            color: clr.appPrimaryColorGreen,
                            size: size.r24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.h8),
                  if (_screenArgs.courseCode.isNotEmpty)
                    CustomTextWidget(
                      text: label(
                          e: "${en.courseCode} ${_screenArgs.courseCode}",
                          b: "${bn.courseCode} ${_screenArgs.courseCode}"),
                      textColor: clr.textColorAppleBlack,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w400,
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                    ),
                  SizedBox(height: size.h12),
                  CustomTextWidget(
                    text: label(e: en.aboutCourse, b: bn.aboutCourse),
                    textColor: clr.textColorBlack,
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w500,
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                  ),
                  SizedBox(height: size.h4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.w16),
                    child: ExpandableText(
                      text: label(e: data.descriptionEn, b: data.descriptionBn),
                      style: TextStyle(
                          color: clr.textColorAppleBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                      minimumTextLengthToFold: 130,
                    ),
                  ),

                  ///
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           label(e: data.titleEn, b: data.titleBn),
                  //           style: TextStyle(
                  //               color: clr.appPrimaryColorGreen,
                  //               fontSize: size.textXMedium,
                  //               fontWeight: FontWeight.w600,
                  //               fontFamily: StringData.fontFamilyPoppins),
                  //         ),
                  //       ),
                  //       SizedBox(width: size.w10),
                  //       Container(
                  //         padding: EdgeInsets.all(size.r1),
                  //         decoration: BoxDecoration(
                  //           color: clr.whiteColor,
                  //           borderRadius: BorderRadius.circular(size.r4),
                  //           border: Border.all(
                  //               color: clr.cardStrokeColor, width: size.r1),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: clr.blackColor.withOpacity(.2),
                  //               blurRadius: size.r4,
                  //               offset: Offset(0.0, size.h2),
                  //             ),
                  //           ],
                  //         ),
                  //         child: Icon(
                  //           Icons.save_alt,
                  //           color: clr.appPrimaryColorGreen,
                  //           size: size.r24,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: size.h4),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                  //   child: Text(
                  //     label(e: "Introduction:", b: "ভূমিকা:"),
                  //     style: TextStyle(
                  //         color: clr.textColorBlack,
                  //         fontSize: size.textSmall,
                  //         fontWeight: FontWeight.w600,
                  //         fontFamily: StringData.fontFamilyPoppins),
                  //   ),
                  // ),
                  // SizedBox(height: size.h8),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: size.w16),
                  //   child: Text(
                  //     label(
                  //         e: "Physiology is an integrated science that considers the function of each organ and organ system and their interaction in the maintenance of life. This introductory course is divided into ten modules.",
                  //         b: "ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে। এই পরিচায়ক কোর্সটি দশটি মডিউলে বিভক্ত।"),
                  //     style: TextStyle(
                  //         color: clr.textColorAppleBlack,
                  //         fontSize: size.textSmall,
                  //         fontWeight: FontWeight.w500,
                  //         fontFamily: StringData.fontFamilyPoppins),
                  //   ),
                  // ),
                  SizedBox(height: size.h16),
                ],
              ),
            );
          },
          emptyBuilder: (context, message, icon) => CustomEmptyWidget(
            message: message,
            // constraints: constraints,
            // offset: 350.w,
          ),
        ));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
