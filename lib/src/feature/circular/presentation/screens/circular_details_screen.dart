import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CircularDetailsScreen extends StatefulWidget {
  const CircularDetailsScreen({super.key});

  @override
  State<CircularDetailsScreen> createState() => _CircularDetailsScreenState();
}

class _CircularDetailsScreenState extends State<CircularDetailsScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.circularDetails, b: bn.circularDetails),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Circular Name
            CircularNameWidget(
              onTap: () {},
            ),
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
            const CircularDetailsInfoWidget(),
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
            const CircularTrainerWidget(),
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
            const CircularDescriptionWidget(),
            SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }
}

class CircularNameWidget extends StatelessWidget with AppTheme, Language {
  final VoidCallback onTap;
  const CircularNameWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              text: label(
                  e: "data.titleEn",
                  b: "বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম বিজ্ঞপ্তির নাম"),
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
              text: label(e: "0128060457", b: "০১২৮০৬০৪৫৭"),
              fontSize: size.textXXSmall,
              textColor: clr.textColorAppleBlack,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
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
  const CircularDetailsInfoWidget({super.key});

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
            rightText: label(e: "১ ডিসেম্বর", b: "১ ডিসেম্বর"),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(
                e: "বিজ্ঞপ্তির নির্ধারিত HSTTI",
                b: "বিজ্ঞপ্তির নির্ধারিত HSTTI"),
            rightText: label(e: "১ ডিসেম্বর", b: "বিজ্ঞপ্তির নির্ধারিত HSTTI"),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "সময়কাল: (শুরু)", b: "সময়কাল: (শুরু)"),
            rightText: label(e: "১ ডিসেম্বর", b: "১ ডিসেম্বর"),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "সময়কাল: (শুরু)", b: "সময়কাল: (শুরু)"),
            rightText: label(e: "১ ডিসেম্বর", b: "১ ডিসেম্বর"),
          ),
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "বিজ্ঞপ্তির ডকুমেন্ট", b: "বিজ্ঞপ্তির ডকুমেন্ট"),
            widget: Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: "Document.PDF",
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
          SizedBox(height: size.h16),
          RowItemWidget(
            leftText: label(e: "বিজ্ঞপ্তির ডকুমেন্ট", b: "বিজ্ঞপ্তির ডকুমেন্ট"),
            widget: Container(
              decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  borderRadius: BorderRadius.circular(size.r4)),
              padding:
                  EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h2),
              alignment: Alignment.center,
              child: CustomTextWidget(
                text: label(e: "Published", b: "Published"),
                textColor: clr.shadeWhiteColor2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularTrainerWidget extends StatelessWidget with AppTheme, Language {
  const CircularTrainerWidget({super.key});

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
        text:
            "মাজহার রহমান, ফারদিন নূর পরশ, হাবিবুল্লাহ বাহার, মুহাইমিনুল ইসলাম|",
        textColor: clr.textColorBlack,
        fontSize: size.textXSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CircularDescriptionWidget extends StatelessWidget
    with AppTheme, Language {
  const CircularDescriptionWidget({super.key});

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
        text:
            "লার্নিং ম্যানেজমেন্ট সিস্টেম (LMS) আধুনিক শিক্ষা ও প্রশিক্ষণে একটি গুরুত্বপূর্ণ ভূমিকা পালন করে। আসুন তাদের গুরুত্ব অন্বেষণ করা যাক:",
        textColor: clr.gapStrokeGrey,
        fontSize: size.textXSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
