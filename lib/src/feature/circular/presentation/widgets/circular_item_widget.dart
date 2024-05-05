import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/circular_data_entity.dart';

class CircularItemWidget extends StatelessWidget with AppTheme, Language {
  final CircularDataEntity data;
  final VoidCallback onTap;
  const CircularItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(size.w8),
        border: Border.all(color: clr.progressBGColor, width: size.w1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.w8, right: size.w8, top: size.h12, bottom: size.h40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icCircular),
                    SizedBox(width: size.w4),
                    CustomTextWidget(
                      text: label(
                          e: "বিজ্ঞপ্তির শিরোনাম", b: "বিজ্ঞপ্তির শিরোনাম"),
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
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.80),
                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.w8),
                      bottomRight: Radius.circular(size.w8)),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w2 + size.w16, vertical: size.h6),
                child: Row(
                  children: [
                    CustomTextWidget(
                      text: label(e: "বিস্তারিত দেখুন", b: "বিস্তারিত দেখুন"),
                      textColor: clr.shadeWhiteColor2,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: size.r20,
                      color: clr.shadeWhiteColor2,
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
