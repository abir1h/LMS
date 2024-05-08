import 'package:flutter/material.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
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
    final Size buttonTextSize = (TextPainter(
            text: TextSpan(text: buttonText ?? ""),
            maxLines: 1,
            textScaler: MediaQuery.of(context).textScaler,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
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
          Expanded(
            flex: 1,
            child: Icon(
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
          ),
          Expanded(
            flex: buttonTextSize.width < 80.0 ? 3 : 2,
            child: Text(
              label(e: data.contentTitleEn, b: data.contentTitleBn),
              style: TextStyle(
                  color: clr.textColorAppleBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyPoppins),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: buttonTextSize.width < 80.0 ? 3 : 4,
            child: GestureDetector(
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
                padding: EdgeInsets.symmetric(
                    horizontal: size.w8, vertical: size.h8),
                decoration: BoxDecoration(
                    color:
                        // status
                        //     ?
                        clr.cardFillColorCruise,
                    // : clr.greyColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(size.r4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        data.contentType == ContentType.circular_videos.name
                            ? label(e: en.see, b: bn.see)
                            : data.contentType ==
                                    ContentType.course_blended_class.name
                                ? label(e: en.join, b: bn.join)
                                : label(e: en.check, b: bn.check),
                        style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: size.w8),
                    Icon(
                      data.contentType == ContentType.circular_videos.name
                          ? Icons.play_circle
                          : data.contentType ==
                                  ContentType.course_blended_class.name
                              ? Icons.video_call
                              : Icons.visibility,
                      size: size.r16,
                      color: clr.textColorAppleBlack,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
