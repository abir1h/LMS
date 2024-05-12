import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/course_content_data_entity.dart';

class CourseContentWidget extends StatelessWidget with AppTheme, Language {
  final CourseContentDataEntity data;
  final String? buttonText;
  // final bool status;
  final VoidCallback? onTapVideo,
      onTapAssignment,
      onTapAssessment,
      onTapScript,
      onTapBlendedClass;
  const CourseContentWidget(
      {Key? key,
      required this.data,
      this.buttonText,
      // this.status = false,
      this.onTapVideo,
      this.onTapAssignment,
      this.onTapAssessment,
      this.onTapScript,
      this.onTapBlendedClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size buttonTextSize = (TextPainter(
    //         text: TextSpan(text: buttonText ?? ""),
    //         maxLines: 1,
    //         textScaler: MediaQuery.of(context).textScaler,
    //         // textDirection: TextDirection.LTR
    // )
    //       ..layout())
    //     .size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: size.w12 * 2, top: size.h16, bottom: size.h16, right: size.w16),
      decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          border: Border(bottom: BorderSide(color: clr.boxStrokeColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            data.contentType == ContentType.circular_videos.name
                ? Icons.smart_display
                : data.contentType == ContentType.circular_assignment.name
                    ? Icons.assignment
                    : data.contentType == ContentType.circular_assessment.name
                        ? Icons.help_center
                        : data.contentType == ContentType.course_script.name
                            ? Icons.text_snippet
                            : Icons.cast_connected,
            size: size.r24,
            color: data.contentType == ContentType.circular_videos.name
                ? clr.iconColorSweetRed
                : data.contentType == ContentType.circular_assignment.name
                    ? clr.appPrimaryColorGreen
                    : data.contentType == ContentType.circular_assessment.name
                        ? clr.textColorAppleBlack
                        : data.contentType == ContentType.course_script.name
                            ? clr.iconColorBlue
                            : clr.textColorBlack,
          ),
          SizedBox(width: size.w8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: label(
                    e: data.contentTitleEn,
                    b: data.contentTitleBn,
                  ),
                  textColor: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyPoppins,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (data.schedule.isNotEmpty)
                  CustomTextWidget(
                    text: label(
                        e: DateFormat('dd MMMM h:mm a')
                            .format(DateTime.parse(data.schedule)),
                        b: timeAgoToBengali(DateFormat("dd MMMM  h : mm a")
                            .format(DateTime.parse(data.schedule)))),
                    textColor: clr.gapStrokeGrey,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w400,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          SizedBox(width: size.w8),
          GestureDetector(
            onTap: data.contentType == ContentType.circular_videos.name
                ? onTapVideo
                : data.contentType == ContentType.circular_assignment.name
                    ? onTapAssignment
                    : data.contentType == ContentType.circular_assessment.name
                        ? onTapAssessment
                        : data.contentType == ContentType.course_script.name
                            ? onTapScript
                            : onTapBlendedClass,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: size.w6, vertical: size.h2),
              decoration: BoxDecoration(
                  color:
                      data.contentType == ContentType.course_blended_class.name
                          ? clr.iconColorBlue
                          : clr.cardFillColorCruise,
                  borderRadius: BorderRadius.circular(size.r4)),
              child: Icon(
                data.contentType == ContentType.circular_videos.name
                    ? Icons.play_circle
                    : data.contentType == ContentType.course_blended_class.name
                        ? Icons.video_call
                        : Icons.visibility,
                size: size.r20,
                color: data.contentType == ContentType.course_blended_class.name
                    ? clr.shadeWhiteColor2
                    : clr.textColorAppleBlack,
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Flexible(
              //       child: Text(
              //         data.contentType == ContentType.circular_videos.name
              //             ? label(e: en.see, b: bn.see)
              //             : data.contentType ==
              //                     ContentType.course_blended_class.name
              //                 ? label(e: en.join, b: bn.join)
              //                 : label(e: en.check, b: bn.check),
              //         style: TextStyle(
              //             color: clr.textColorAppleBlack,
              //             fontSize: size.textSmall,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: StringData.fontFamilyPoppins),
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //     SizedBox(width: size.w8),
              //     Icon(
              //       data.contentType == ContentType.circular_videos.name
              //           ? Icons.play_circle
              //           : data.contentType ==
              //                   ContentType.course_blended_class.name
              //               ? Icons.video_call
              //               : Icons.visibility,
              //       size: size.r16,
              //       color: clr.textColorAppleBlack,
              //     )
              //   ],
              // ),
            ),
          )
        ],
      ),
    );
  }
}
