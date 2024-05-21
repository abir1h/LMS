import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/presentation/screens/overall_progress_screen.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/circular_details_data_entity.dart';
import '../services/circular_details_screen_service.dart';

class CircularDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const CircularDetailsScreen({super.key, this.arguments});

  @override
  State<CircularDetailsScreen> createState() => _CircularDetailsScreenState();
}

class _CircularDetailsScreenState extends State<CircularDetailsScreen>
    with AppTheme, Language, CircularDetailsScreenService {
  late CircularDetailsScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CircularDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAllCircularsData(_screenArgs.circularId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.circularDetails, b: bn.circularDetails),
      body: AppStreamBuilder<CircularDetailsDataEntity>(
        stream: circularDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Circular Name
                CircularNameWidget(data: data),
                SizedBox(height: size.h16),

                ///Circular Info
                CustomTextWidget(
                  text: label(
                      e: "Circular Details Info",
                      b: "বিজ্ঞপ্তির বিস্তারিত তথ্য"),
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                CircularDetailsInfoWidget(
                  data: data,
                  onTap: () => onTap(data.courseId, ""),
                ),
                SizedBox(height: size.h16),

                ///Batch Coordinator
                BatchCoordinatorWidget(data: data),
                SizedBox(height: size.h16),

                ///Circular Trainer
                CircularTrainerWidget(data: data),
                SizedBox(height: size.h16),

                ///Circular Description
                CustomTextWidget(
                  text: label(
                      e: "Circular Description",
                      b: "বিজ্ঞপ্তির সংক্ষিপ্ত বিবরণ"),
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                CircularDescriptionWidget(
                  shortDescription:
                      label(e: data.shortDescEn, b: data.shortDescBn),
                ),
                SizedBox(height: size.h64),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title: label(e: 'No Circular Found', b: 'কোন বিজ্ঞপ্তির পাওয়া যায়নি'),
          // constraints: constraints,
          // offset: 350.w,
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
        ));
  }
}

class CircularNameWidget extends StatelessWidget with AppTheme, Language {
  final CircularDetailsDataEntity data;
  const CircularNameWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.scaffoldBackgroundColor,
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(ImageAssets.icCircular),
              SizedBox(width: size.w4),
              CustomTextWidget(
                text: label(e: "Circular Title", b: "বিজ্ঞপ্তির শিরোনাম"),
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins,
              ),
            ],
          ),
          SizedBox(height: size.h8),
          CustomTextWidget(
            text: label(e: data.nameEn, b: data.nameBn),
            fontSize: size.textXXSmall,
            textColor: clr.textColorAppleBlack,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: size.h8),
          Row(
            children: [
              Icon(
                Icons.tag_outlined,
                size: size.r16,
                color: clr.appPrimaryColorGreen,
              ),
              SizedBox(width: size.w4),
              CustomTextWidget(
                text: label(e: "Reference Number", b: "রেফারেন্স নম্বর"),
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins,
              ),
            ],
          ),
          SizedBox(height: size.h8),
          CustomTextWidget(
            text: label(e: data.referenceNumber, b: data.referenceNumber),
            fontSize: size.textXXSmall,
            textColor: clr.textColorAppleBlack,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class RowItemWidgetText extends StatelessWidget with AppTheme, Language {
  final String leftText;
  final Color? leftTextColor;
  final Color? rightTextColor;
  final String? rightText;
  final Widget? widget;
  const RowItemWidgetText(
      {super.key,
      required this.leftText,
      this.leftTextColor,
      this.rightTextColor,
      this.rightText,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon(Icons.circle, size: size.r8, color: clr.appPrimaryColorGreen),
        // SizedBox(width: size.w8),
        Expanded(
          child: CustomTextWidget(
            text: leftText,
            textColor: leftTextColor ?? clr.gapStrokeGrey,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomTextWidget(
          text: label(e: ":", b: ":"),
          textColor: leftTextColor ?? clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.only(left: size.w8, right: size.w24),
        ),
        if (rightText != null)
          Expanded(
            child: CustomTextWidget(
              text: rightText.toString(),
              textColor: rightTextColor ?? clr.textColorAppleBlack,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (widget != null) Expanded(child: widget!)
      ],
    );
  }
}

class CircularDetailsInfoWidget extends StatelessWidget
    with AppTheme, Language {
  final CircularDetailsDataEntity data;
  final VoidCallback onTap;
  const CircularDetailsInfoWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.startDate.isNotEmpty)
            RowItemWidgetText(
              leftText: label(e: "Duration: (Start)", b: "সময়কাল: (শুরু)"),
              rightText: label(
                e: DateFormat('dd MMMM').format(DateTime.parse(data.startDate)),
                b: timeAgoToBengali(DateFormat('dd MMMM')
                    .format(DateTime.parse(data.startDate))),
              ),
            ),
          SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText: label(e: "Duration: (End)", b: "সময়কাল: (শেষ)"),
            rightText: label(
                e: DateFormat('dd MMMM').format(DateTime.parse(data.endDate)),
                b: timeAgoToBengali(DateFormat('dd MMMM')
                    .format(DateTime.parse(data.endDate)))),
          ),
          SizedBox(height: size.h16),
          if (data.publishDate.isNotEmpty)
            RowItemWidgetText(
              leftText: label(
                  e: "Circular Publication Time",
                  b: "বিজ্ঞপ্তির প্রকাশের সময়"),
              rightText: label(
                  e: DateFormat('dd MMMM')
                      .add_jm()
                      .format(DateTime.parse(data.publishDate)),
                  b: timeAgoToBengali(DateFormat('dd MMMM h : mm a')
                      .format(DateTime.parse(data.publishDate)))),
            ),
          SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText: label(
                e: "Scheduled Batch of Circular",
                b: "বিজ্ঞপ্তির নির্ধারিত ব্যাচ"),
            rightText: label(e: data.batch.nameEn, b: data.batch.nameBn),
          ),
          SizedBox(height: size.h16),
          if (data.venueName.isNotEmpty)
            RowItemWidgetText(
              leftText: label(e: "Training Venue", b: "ট্রেনিং ভেন্যুু"),
              rightText: data.venueName,
            ),
          SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText: label(
                e: "Scheduled Session of Circular",
                b: "বিজ্ঞপ্তির নির্ধারিত অধিবেশন"),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: label(e: data.course.nameEn, b: data.course.nameBn),
                  textColor: clr.textColorAppleBlack,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: size.h8),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: clr.appPrimaryColorGreen,
                      borderRadius: BorderRadius.circular(size.r4),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w12, vertical: size.h2),
                    alignment: Alignment.center,
                    child: CustomTextWidget(
                      text: label(e: "Details", b: "বিস্তারিত দেখুন"),
                      textColor: clr.shadeWhiteColor2,
                      fontSize: size.textXSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.h16),
          if (data.url.isNotEmpty)
            RowItemWidgetText(
              leftText: label(e: "Circular Link", b: "বিজ্ঞপ্তির লিংক "),
              widget: GestureDetector(
                onTap: () {
                  if (data.url.isNotEmpty) {
                    launchUrl(Uri.parse(data.url),
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: CustomTextWidget(
                  text: data.url,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          // SizedBox(height: size.h16),
          if (data.supportingDoc.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: size.h16),
              child: RowItemWidgetText(
                leftText:
                    label(e: "Circular Document", b: "বিজ্ঞপ্তির ডকুমেন্ট"),
                widget: Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: data.supportingDoc,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: size.w4),
                    SvgPicture.asset(
                      ImageAssets.icDownload,
                      height: size.r16,
                    )
                  ],
                ),
              ),
            ),
          // SizedBox(height: size.h16),
          if (data.status == 1)
            Padding(
              padding: EdgeInsets.only(top: size.h16),
              child: RowItemWidgetText(
                leftText: label(e: "Circular Status", b: "বিজ্ঞপ্তির স্টেটাস"),
                widget: Container(
                  decoration: BoxDecoration(
                      color: clr.cardFillColorLeafGreen,
                      borderRadius: BorderRadius.circular(size.r4),
                      border: Border.all(
                          color: clr.cardStrokeColorLeafGreen, width: size.r1)),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w12, vertical: size.h2),
                  alignment: Alignment.center,
                  child: CustomTextWidget(
                    text: label(e: "Published", b: "Published"),
                    textColor: clr.appPrimaryColorGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class BatchCoordinatorWidget extends StatelessWidget with AppTheme, Language {
  final CircularDetailsDataEntity data;
  const BatchCoordinatorWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                ImageAssets.imgEmptyProfile,
                height: size.h32,
              ),
              SizedBox(width: size.w12),
              Expanded(
                child: CustomTextWidget(
                  text: label(e: "Batch Coordinator", b: "ব্যাচ সমন্বয়কারী"),
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: size.h16),
          if (data.batchCoordinatorNameEn.isNotEmpty)
            RowItemWidgetText(
              leftText: label(
                  e: "Batch Coordinator Name", b: "ব্যাচ সমন্বয়কারীর নাম"),
              rightText: label(
                  e: data.batchCoordinatorNameEn,
                  b: data.batchCoordinatorNameBn),
            ),
          SizedBox(height: size.h16),
          if (data.batchCoordinatorId != -1)
            RowItemWidgetText(
              leftText: label(e: "Code", b: "কোড"),
              rightText: label(
                  e: data.batchCoordinatorId.toString(),
                  b: replaceEnglishNumberWithBengali(
                      data.batchCoordinatorId.toString())),
            ),
         /* SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText: label(e: "Email", b: "ইমেইল"),
            rightText: label(e: "", b: ""),
          ),
          SizedBox(height: size.h16),
          RowItemWidgetText(
            leftText: label(e: "Phone", b: "ফোন নাম্বার"),
            rightText: label(e: "", b: ""),
          ),*/
        ],
      ),
    );
  }
}

class CircularTrainerWidget extends StatelessWidget with AppTheme, Language {
  final CircularDetailsDataEntity data;
  const CircularTrainerWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: label(
                e: "Circular Scheduled Instructors",
                b: "বিজ্ঞপ্তির নির্ধারিত প্রশিক্ষক"),
            fontWeight: FontWeight.w500,
          ),
          ListView.separated(
            itemCount: data.trainers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.h16),
                  RowItemWidgetText(
                      leftText:
                          label(e: "Instructor Name", b: "প্রশিক্ষকের নাম"),
                      leftTextColor: clr.appPrimaryColorGreen,
                      rightText: label(
                          e: data.trainers[index].fullnameEn,
                          b: data.trainers[index].fullnameBn)),
                 /* SizedBox(height: size.h16),
                  RowItemWidgetText(
                    leftText: label(e: "Subject", b: "বিষয়"),
                    rightText: label(e: "", b: ""),
                  ),
                  SizedBox(height: size.h16),
                  RowItemWidgetText(
                    leftText: label(e: "Email", b: "ইমেইল"),
                    rightText: label(e: "", b: ""),
                  ),
                  SizedBox(height: size.h16),
                  RowItemWidgetText(
                    leftText: label(e: "Phone Number", b: "ফোন নাম্বার"),
                    rightText: label(e: "", b: ""),
                  ),*/
                  SizedBox(height: size.h16),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.w64),
                child: DotWidget(
                  dashColor: clr.cardStrokeColorGrey2,
                  dashHeight: size.h1,
                  dashWidth: size.w6,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CircularDescriptionWidget extends StatelessWidget
    with AppTheme, Language {
  final String shortDescription;
  const CircularDescriptionWidget({super.key, required this.shortDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: CustomTextWidget(
        text: shortDescription,
        textColor: clr.gapStrokeGrey,
        fontSize: size.textXSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
