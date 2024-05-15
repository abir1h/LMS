import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/blended_class_data_entity.dart';
import '../services/course_live_class_screen_service.dart';
import '../widgets/sliver_tab_section_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class CourseLiveClassScreen extends StatefulWidget {
  final Object? arguments;
  const CourseLiveClassScreen({super.key, this.arguments});

  @override
  State<CourseLiveClassScreen> createState() => _CourseLiveClassScreenState();
}

class _CourseLiveClassScreenState extends State<CourseLiveClassScreen>
    with AppTheme, Language, CourseLiveClassScreenService {
  late CourseBlendedScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseBlendedScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadDataList(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.blendedClass, b: bn.blendedClass),
      bgColor: clr.whiteColor,
      // actionChild: InkWell(
      //   onTap: () {},
      //   child: Stack(
      //     children: [
      //       Icon(
      //         Icons.notifications,
      //         color: clr.appPrimaryColorGreen,
      //         size: size.r24,
      //       ),
      //       Positioned(
      //         right: -1,
      //         top: 2.w,
      //         child: Container(
      //           width: size.w12,
      //           height: size.h12,
      //           decoration: BoxDecoration(
      //               color: clr.appPrimaryColorGreen,
      //               shape: BoxShape.circle,
      //               border: Border.all(color: clr.whiteColor)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tab Button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              child: Center(
                child: TypeSelectorTab(
                  onSelected: (e) {
                    onTabValueChange(e, _screenArgs.courseContentId);
                  },
                ),
              ),
            ),

            AppStreamBuilder<StateType>(
              stream: stateDataStreamController.stream,
              loadingBuilder: (context) {
                return const Center(child: CircularLoader());
              },
              dataBuilder: (context, data) {
                if (data is InPersonClassDataState) {
                  return InPersonClassWidget(
                    data: data.blendedClassDataEntity,
                    onTapConfirm: () {
                      CustomDialogWidget.show(
                              context: context,
                              icon: Icons.info,
                              title: label(
                                  e: "Do you want to confirm?",
                                  b: "আপনি কি নিশ্চিত করতে চান?"),
                              infoText: "Are you Sure?")
                          .then((x) {
                        if (!x) {
                          contentReadPost(
                              data.blendedClassDataEntity.id,
                              'course_script',
                              data.blendedClassDataEntity.courseId,
                              true,
                              '40',
                              'physical');
                        }
                      });
                    },
                  );
                } else if (data is OnlineClassDataState) {
                  return OnlineClassWidget(
                    data: data.blendedClassDataEntity,
                    onTapConfirm: () {
                      CustomDialogWidget.show(
                              context: context,
                              icon: Icons.info,
                              title: label(
                                  e: "Do you want to confirm?",
                                  b: "আপনি কি নিশ্চিত করতে চান?"),
                              infoText: "Are you Sure?")
                          .then((x) {
                        if (!x) {
                          contentReadPost(
                                  data.blendedClassDataEntity.id,
                                  'course_script',
                                  data.blendedClassDataEntity.courseId,
                                  true,
                                  '40',
                                  'online')
                              .then((value) => launchUrl(
                                  Uri.parse(
                                      data.blendedClassDataEntity.meetingLink),
                                  mode: LaunchMode.externalApplication));
                        }
                      });
                    },
                  );
                } else {
                  return const CustomEmptyWidget(
                    icon: Icons.school_outlined,
                    message: "No matching data found!",
                  );
                }
              },
              emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                message: message,
                // constraints: constraints,
                // offset: 350.w,
              ),
            ),

            ///
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(
            //       horizontal: size.w16, vertical: size.h16),
            //   decoration: BoxDecoration(
            //       border:
            //           Border(bottom: BorderSide(color: clr.boxStrokeColor))),
            //   child: Text(
            //     label(
            //         e: "Concepts of Interconnected Formal Learning",
            //         b: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ধারণা"),
            //     style: TextStyle(
            //         color: clr.appPrimaryColorGreen,
            //         fontSize: size.textSmall,
            //         fontWeight: FontWeight.w600,
            //         fontFamily: StringData.fontFamilyPoppins),
            //   ),
            // ),
            // SizedBox(height: size.h8),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: size.w16),
            //   child: Text(
            //     label(e: "Live Class Description", b: "লাইভ ক্লাসের বর্ণনা"),
            //     style: TextStyle(
            //         color: clr.appPrimaryColorGreen,
            //         fontSize: size.textSmall,
            //         fontWeight: FontWeight.w600,
            //         fontFamily: StringData.fontFamilyPoppins),
            //   ),
            // ),
            // SizedBox(height: size.h12),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: size.w16),
            //   child: Text(
            //     label(
            //         e: "Engage in effective post-secondary education teaching methods in this online short course, inspired by the in-person seminar program currently offered by the ministry's Center for Teaching and Learning.",
            //         b: "এই অনলাইন সংক্ষিপ্ত কোর্সে কার্যকর পোস্ট-সেকেন্ডারি শিক্ষা শিক্ষণ পদ্ধতির সাথে যুক্ত হন, যা বর্তমানে সেন্টার ফর টিচিং অ্যান্ড লার্নিং মন্ত্রকের দ্বারা দেওয়া ব্যক্তিগত সেমিনার প্রোগ্রাম দ্বারা অনুপ্রাণিত।"),
            //     style: TextStyle(
            //         color: clr.blackColor,
            //         fontSize: size.textSmall,
            //         fontWeight: FontWeight.w500,
            //         fontFamily: StringData.fontFamilyPoppins),
            //   ),
            // ),
            // SizedBox(height: size.h12),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: size.w16),
            //   padding: EdgeInsets.symmetric(
            //       horizontal: size.w24, vertical: size.h24),
            //   decoration: BoxDecoration(
            //       color: clr.shadeWhiteColor2,
            //       borderRadius: BorderRadius.circular(size.r8),
            //       border: Border.all(
            //           color: clr.cardFillColorCruise, width: size.w1)),
            //   child: Column(
            //     children: [
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Icon(
            //             Icons.video_call,
            //             color: clr.textColorAppleBlack,
            //             size: size.r20,
            //           ),
            //           SizedBox(width: size.w8),
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   label(
            //                       e: "Live Class Title",
            //                       b: "লাইভ ক্লাসের শিরোনাম"),
            //                   style: TextStyle(
            //                       color: clr.blackColor,
            //                       fontSize: size.textSmall,
            //                       fontWeight: FontWeight.w500,
            //                       fontFamily: StringData.fontFamilyPoppins),
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 SizedBox(height: size.h8),
            //                 Text(
            //                   label(
            //                       e: "First Chapter Title",
            //                       b: "প্রথম অধ্যায়ের শিরোনাম"),
            //                   style: TextStyle(
            //                       color: clr.blackColor,
            //                       fontSize: size.textSmall,
            //                       fontWeight: FontWeight.w500,
            //                       fontFamily: StringData.fontFamilyPoppins),
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 SizedBox(height: size.h4),
            //                 Text(
            //                   label(e: "(chapter code)", b: "(অধ্যায়ের কোড)"),
            //                   style: TextStyle(
            //                       color: clr.iconColorHint,
            //                       fontSize: size.textXXSmall,
            //                       fontWeight: FontWeight.w500,
            //                       fontFamily: StringData.fontFamilyPoppins),
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: size.h8),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Icon(
            //             Icons.calendar_month,
            //             color: clr.textColorAppleBlack,
            //             size: size.r20,
            //           ),
            //           SizedBox(width: size.w8),
            //           Expanded(
            //             child: Text(
            //               label(
            //                   e: "Friday, January 3",
            //                   b: "শুক্রবার, ৩ জানুয়ারি"),
            //               style: TextStyle(
            //                   color: clr.blackColor,
            //                   fontSize: size.textSmall,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: StringData.fontFamilyPoppins),
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ),
            //           SizedBox(width: size.w8),
            //           Icon(
            //             Icons.schedule,
            //             color: clr.textColorAppleBlack,
            //             size: size.r20,
            //           ),
            //           SizedBox(width: size.w8),
            //           Expanded(
            //             child: Text(
            //               label(e: "10.30 am", b: "সকাল ১০.৩০"),
            //               style: TextStyle(
            //                   color: clr.blackColor,
            //                   fontSize: size.textSmall,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: StringData.fontFamilyPoppins),
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: size.h20),
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: size.w44),
            //         child: CustomButton(
            //           onTap: () {},
            //           title: label(e: en.joinClass, b: bn.joinClass),
            //           radius: size.r16,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: size.h16),
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
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}

class InClassCardWidget extends StatelessWidget with AppTheme, Language {
  final BlendedClassDataEntity data;
  final VoidCallback onTapConfirm;
  const InClassCardWidget(
      {super.key, required this.data, required this.onTapConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      padding: EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h20),
      decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.cardFillColorCruise, width: size.w1)),
      child: Column(
        children: [
          CardRowItemWidget(
            leftText: label(e: en.institutionName, b: bn.institutionName),
            rightText: data.workstations!
                .map((c) => label(e: c.nameEn, b: c.nameBn))
                .toList()
                .join(', '),
          ),
          SizedBox(height: size.h20),
          CardRowItemWidget(
            leftText: label(e: en.classSchedule, b: bn.classSchedule),
            rightText: data.classSchedule.isNotEmpty
                ? label(
                    e: DateFormat('dd MMMM, yyyy')
                        .format(DateTime.parse(data.classSchedule)),
                    b: timeAgoToBengali(DateFormat('dd MMMM, yyyy')
                        .format(DateTime.parse(data.classSchedule))))
                : "",
          ),
          SizedBox(height: size.h20),
          CardRowItemWidget(
            leftText: label(e: en.classTime, b: bn.classTime),
            rightText: label(e: data.time, b: data.time),
          ),
          SizedBox(height: size.h20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.w44),
            child: CustomButton(
              onTap: onTapConfirm,
              title: label(e: en.confirmInPerson, b: bn.confirmInPerson),
              textColor: clr.whiteColor,
              radius: size.r16,
            ),
          )
        ],
      ),
    );
  }
}

class InPersonClassWidget extends StatelessWidget with AppTheme, Language {
  final BlendedClassDataEntity data;
  final VoidCallback onTapConfirm;
  const InPersonClassWidget(
      {super.key, required this.data, required this.onTapConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label(e: en.classInstructions, b: bn.classInstructions),
          fontFamily: StringData.fontFamilyPoppins,
          padding: EdgeInsets.symmetric(horizontal: size.w16),
        ),
        SizedBox(height: size.h12),
        CustomTextWidget(
          text: label(e: data.transcript, b: data.transcript),
          textColor: clr.blackColor,
          fontWeight: FontWeight.w500,
          fontFamily: StringData.fontFamilyPoppins,
          padding: EdgeInsets.symmetric(horizontal: size.w16),
        ),
        SizedBox(height: size.h12),
        InClassCardWidget(data: data, onTapConfirm: onTapConfirm),
      ],
    );
  }
}

class OnlineClassCardWidget extends StatelessWidget with AppTheme, Language {
  final BlendedClassDataEntity data;
  final VoidCallback onTapConfirm;
  const OnlineClassCardWidget(
      {super.key, required this.data, required this.onTapConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      padding: EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h20),
      decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.cardFillColorCruise, width: size.w1)),
      child: Column(
        children: [
          CardRowItemWidget(
            leftText: label(e: en.classLink, b: bn.classLink),
            widget: Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: data.meetingLink,
                    textColor: clr.gapStrokeGrey,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: size.w4),
                InkWell(
                  onTap: () =>
                      Clipboard.setData(ClipboardData(text: data.meetingLink)),
                  child: Icon(
                    Icons.copy_rounded,
                    size: size.r16,
                    color: clr.appPrimaryColorGreen,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size.h20),
          CardRowItemWidget(
            leftText: label(e: en.classSchedule, b: bn.classSchedule),
            rightText: data.classSchedule.isNotEmpty
                ? label(
                    e: DateFormat('dd MMMM, yyyy')
                        .format(DateTime.parse(data.classSchedule)),
                    b: DateFormat('dd MMMM, yyyy')
                        .format(DateTime.parse(data.classSchedule)))
                : "",
          ),
          SizedBox(height: size.h20),
          CardRowItemWidget(
            leftText: label(e: en.classTime, b: bn.classTime),
            rightText: label(e: data.time, b: data.time),
          ),
          SizedBox(height: size.h20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.w44),
            child: CustomButton(
              onTap: onTapConfirm,
              title: label(e: en.joinClass, b: bn.joinClass),
              textColor: clr.whiteColor,
              radius: size.r16,
            ),
          )
        ],
      ),
    );
  }
}

class OnlineClassWidget extends StatelessWidget with AppTheme, Language {
  final BlendedClassDataEntity data;
  final VoidCallback onTapConfirm;
  const OnlineClassWidget(
      {super.key, required this.data, required this.onTapConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label(e: en.classInstructions, b: bn.classInstructions),
          fontFamily: StringData.fontFamilyPoppins,
          padding: EdgeInsets.symmetric(horizontal: size.w16),
        ),
        SizedBox(height: size.h12),
        CustomTextWidget(
          text: label(
              e: "Engage in effective postsecondary education teaching methods in this online short course, inspired by the in-person seminar program currently offered by the Ministry's Center for Teaching and Learning.",
              b: "এই অনলাইন সংক্ষিপ্ত কোর্সে কার্যকর পোস্ট-সেকেন্ডারি শিক্ষা শিক্ষণ পদ্ধতির সাথে যুক্ত হন, যা বর্তমানে সেন্টার ফর টিচিং অ্যান্ড লার্নিং মন্ত্রকের দ্বারা দেওয়া ব্যক্তিগত সেমিনার প্রোগ্রাম দ্বারা অনুপ্রাণিত।"),
          textColor: clr.blackColor,
          fontWeight: FontWeight.w500,
          fontFamily: StringData.fontFamilyPoppins,
          padding: EdgeInsets.symmetric(horizontal: size.w16),
        ),
        SizedBox(height: size.h12),
        OnlineClassCardWidget(
          data: data,
          onTapConfirm: onTapConfirm,
        ),
      ],
    );
  }
}

class CardRowItemWidget extends StatelessWidget with AppTheme, Language {
  final String leftText;
  final String? rightText;
  final Widget? widget;
  const CardRowItemWidget(
      {super.key, required this.leftText, this.rightText, this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextWidget(
            text: leftText,
            textColor: clr.gapStrokeGrey,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomTextWidget(
          text: label(e: ":", b: ":"),
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.only(left: size.w8, right: size.w24),
        ),
        if (rightText != null)
          Expanded(
            child: CustomTextWidget(
              text: rightText.toString(),
              textColor: clr.gapStrokeGrey,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        if (widget != null) Expanded(child: widget!)
      ],
    );
  }
}

class TypeSelectorTab extends StatefulWidget {
  final void Function(int type) onSelected;
  final int type;
  const TypeSelectorTab({Key? key, required this.onSelected, this.type = 0})
      : super(key: key);
  @override
  State<TypeSelectorTab> createState() => _TypeSelectorTabState();
}

class _TypeSelectorTabState extends State<TypeSelectorTab>
    with AppTheme, Language {
  int _selectedType = 0;

  @override
  void initState() {
    _selectedType = widget.type;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypeSelectorTab oldWidget) {
    setState(() {
      _selectedType = widget.type;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizeConstraints) {
      return Container(
        height: size.h42,
        decoration: BoxDecoration(
          color: clr.whiteColor,
          border: Border.all(color: clr.cardStrokeColor, width: size.r1),
          borderRadius: BorderRadius.circular(size.r12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _onChanged(0),
              child: Container(
                height: double.maxFinite,
                width: sizeConstraints.maxWidth / 2.05,
                decoration: BoxDecoration(
                  color: _selectedType == 0 ? null : Colors.transparent,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.83),
                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.r12),
                      bottomLeft: Radius.circular(size.r12)),
                ),
                child: Center(
                    child: Text(
                  label(e: en.inPersonClass, b: bn.inPersonClass),
                  style: TextStyle(
                    color: _selectedType == 0
                        ? clr.shadeWhiteColor2
                        : clr.textColorAppleBlack,
                    fontWeight:
                        _selectedType == 0 ? FontWeight.w500 : FontWeight.w400,
                    fontSize: size.textSmall,
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () => _onChanged(1),
              child: Container(
                height: double.maxFinite,
                width: sizeConstraints.maxWidth / 2.05,
                decoration: BoxDecoration(
                  color: _selectedType == 1 ? null : Colors.transparent,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.83),
                  ]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.r12),
                      bottomRight: Radius.circular(size.r12)),
                ),
                child: Center(
                    child: Text(
                  label(e: en.onlineClass, b: bn.onlineClass),
                  style: TextStyle(
                    color: _selectedType == 1
                        ? clr.shadeWhiteColor2
                        : clr.textColorAppleBlack,
                    fontWeight:
                        _selectedType == 1 ? FontWeight.w500 : FontWeight.w400,
                    fontSize: size.textSmall,
                  ),
                )),
              ),
            ),
          ],
        ),
      );
    });
  }

  _onChanged(int type) {
    if (mounted && _selectedType != type) {
      setState(() {
        _selectedType = type;
      });
      widget.onSelected.call(_selectedType);
    }
  }
}
