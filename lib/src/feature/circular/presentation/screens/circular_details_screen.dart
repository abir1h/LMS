import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
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
                      e: "বিজ্ঞপ্তির বিস্তারিত তথ্য",
                      b: "বিজ্ঞপ্তির বিস্তারিত তথ্য"),
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                CircularDetailsInfoWidget(data: data),
                SizedBox(height: size.h16),

                ///Circular Trainer
                CustomTextWidget(
                  text: label(
                      e: "বিজ্ঞপ্তির নির্ধারিত প্রশিক্ষক",
                      b: "বিজ্ঞপ্তির নির্ধারিত প্রশিক্ষক"),
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                CircularTrainerWidget(data: data),
                SizedBox(height: size.h16),

                ///Circular Description
                CustomTextWidget(
                  text: label(
                      e: "বিজ্ঞপ্তির সংক্ষিপ্ত বিবরণ",
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
                text: label(e: "বিজ্ঞপ্তির শিরোনাম", b: "বিজ্ঞপ্তির শিরোনাম"),
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
                text: label(e: "রেফারেন্স নম্বর", b: "রেফারেন্স নম্বর"),
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

class RowItemWidget extends StatelessWidget with AppTheme, Language {
  final String leftText;
  final String? rightText;
  final Widget? widget;
  const RowItemWidget(
      {super.key, required this.leftText, this.rightText, this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: size.r8, color: clr.appPrimaryColorGreen),
        SizedBox(width: size.w8),
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
  const CircularDetailsInfoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemWidget(
            leftText: label(e: "সময়কাল: (শুরু)", b: "সময়কাল: (শুরু)"),
            rightText: label(
              e: DateFormat('dd MMMM').format(DateTime.parse(data.startDate)),
              b: DateFormat('dd MMMM').format(DateTime.parse(data.startDate)),
            ),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "সময়কাল: (শেষ)", b: "সময়কাল: (শেষ)"),
            rightText: label(
                e: DateFormat('dd MMMM').format(DateTime.parse(data.endDate)),
                b: DateFormat('dd MMMM').format(DateTime.parse(data.endDate))),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(
                e: "বিজ্ঞপ্তির প্রকাশের সময়", b: "বিজ্ঞপ্তির প্রকাশের সময়"),
            rightText: label(
                e: DateFormat('dd MMMM')
                    .add_jm()
                    .format(DateTime.parse(data.publishDate)),
                b: DateFormat('dd MMMM')
                    .add_jm()
                    .format(DateTime.parse(data.publishDate))),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(
                e: "বিজ্ঞপ্তির নির্ধারিত ব্যাচ",
                b: "বিজ্ঞপ্তির নির্ধারিত ব্যাচ"),
            rightText: label(e: data.batch.nameEn, b: data.batch.nameBn),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(
                e: "বিজ্ঞপ্তির নির্ধারিত HSTTI",
                b: "বিজ্ঞপ্তির নির্ধারিত HSTTI"),
            rightText: data.workstations
                .map((c) => label(e: c.nameEn, b: c.nameBn))
                .toList()
                .join(', '),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(
                e: "বিজ্ঞপ্তির নির্ধারিত অধিবেশন",
                b: "বিজ্ঞপ্তির নির্ধারিত অধিবেশন"),
            rightText: label(e: data.course.nameEn, b: data.course.nameBn),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "বিজ্ঞপ্তির লিংক", b: "বিজ্ঞপ্তির লিংক "),
            widget: CustomTextWidget(
              text: data.url,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          // SizedBox(height: size.h16),
          if (data.supportingDoc.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: size.h16),
              child: RowItemWidget(
                leftText:
                    label(e: "বিজ্ঞপ্তির ডকুমেন্ট", b: "বিজ্ঞপ্তির ডকুমেন্ট"),
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
              child: RowItemWidget(
                leftText:
                    label(e: "বিজ্ঞপ্তির স্টেটাস", b: "বিজ্ঞপ্তির স্টেটাস"),
                widget: Container(
                  decoration: BoxDecoration(
                      color: clr.appPrimaryColorGreen,
                      borderRadius: BorderRadius.circular(size.r4)),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.w12, vertical: size.h2),
                  alignment: Alignment.center,
                  child: CustomTextWidget(
                    text: label(e: "Published", b: "Published"),
                    textColor: clr.shadeWhiteColor2,
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
      padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h12),
      margin: EdgeInsets.symmetric(horizontal: size.w16),
      child: CustomTextWidget(
        text: data.trainers
            .map((c) => label(e: c.fullnameEn, b: c.fullnameBn))
            .toList()
            .join(', '),
        textColor: clr.textColorBlack,
        fontSize: size.textXSmall,
        fontWeight: FontWeight.w500,
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
