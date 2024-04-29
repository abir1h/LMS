import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../services/circular_screen_service.dart';

class CircularScreen extends StatefulWidget {
  const CircularScreen({super.key});

  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen>
    with AppTheme, Language, CircularScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.circularDetails, b: bn.circularDetails),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: clr.scaffoldBackgroundColor,
                border: Border.all(color: clr.boxStrokeColor, width: size.w1),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: clr.blackColor.withOpacity(.2))
                ],
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h12),
              child: CircularItemWidget(
                onTap: onTapCircular,
              ),
            ),
            SizedBox(height: size.h16),
            CustomTextWidget(
              text: label(
                  e: "আসন্ন বিজ্ঞপ্তির তালিকা", b: "আসন্ন বিজ্ঞপ্তির তালিকা"),
              fontSize: size.textXMedium,
              fontWeight: FontWeight.w500,
              padding: EdgeInsets.symmetric(horizontal: size.w16),
            ),
            SizedBox(height: size.h12),
            CircularItemSectionWidget(
                items: const ["", "", ""],
                buildItem: (BuildContext context, int index, item) {
                  return CircularItemWidget(
                    onTap: onTapCircular,
                  );
                }),
            SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }

  @override
  void navigateToCircularDetailsScreen() {
    Navigator.of(context).pushNamed(AppRoute.circularDetailsScreen);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class CircularItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CircularItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h16);
      },
    );
  }
}

class CircularItemWidget extends StatelessWidget with AppTheme, Language {
  final VoidCallback onTap;
  const CircularItemWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  left: size.w8,
                  right: size.w8,
                  top: size.h12,
                  bottom: size.h40),
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
                    text: label(e: "0128060457", b: "0128060457"),
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
            )
          ],
        ),
      ),
    );
  }
}
