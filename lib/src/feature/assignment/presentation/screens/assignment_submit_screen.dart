import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class AssignmentSubmitScreen extends StatefulWidget {
  const AssignmentSubmitScreen({super.key});

  @override
  State<AssignmentSubmitScreen> createState() => _AssignmentSubmitScreenState();
}

class _AssignmentSubmitScreenState extends State<AssignmentSubmitScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "",
        actionChild: InkWell(
            onTap: () {
              // Get.to(() => NoteEditScreen(
              //   mainModel: widget.mainModel,
              //   ref: widget.mainModel!.reference,
              // ));
            },
            child: Icon(Icons.edit,
                size: size.r24, color: clr.appPrimaryColorGreen)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(
                    e: "1. What are the foundations of teaching programs for learning?",
                    b: "জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে    মানুষ আসবার পূর্বেই জীবসৃষ্টিযজ্ঞে প্রকৃতির ভূরিব্যয়ের পালা শেষ হয়ে এসেছে। বিপুল মাংস, কঠিন বর্ম, প্রকাণ্ড লেজ নিয়ে জলে স্থলে পৃথুল দেহের যে অমিতাচার প্রবল হয়ে উঠেছিল তাতে ধরিত্রীকে দিলে ক্লান্ত করে। প্রমাণ হল আতিশয্যের পরাভব অনিবার্য। পরীক্ষায় এটাও স্থির হয়ে গেল যে, প্রশ্রয়ের পরিমাণ যত বেশি হয় দুর্বলতার বোঝাও তত দুর্বহ হয়ে ওঠে। নূতন পর্বে প্রকৃতি যথাসম্ভব মানুষের বরাদ্দ কম করে দিয়ে নিজে রইল নেপথ্যে।   মানুষকে দেখতে হল খুব ছোটো, কিন্তু সেটা একটা কৌশল মাত্র। এবারকার জীবযাত্রার পালায় বিপুলতাকে করা হল বহুলতায় পরিণত। মহাকায় জন্তু ছিল প্রকাণ্ড একলা, মানুষ হল দূরপ্রসারিত অনেক।"),
                style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: size.h56),
              Divider(color: clr.boxStrokeColor),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {},
                        title: label(e: en.submit, b: bn.submit),
                        radius: size.r4,
                        verticalPadding: size.h4,
                        bgColor: clr.scaffoldBackgroundColor,
                        textColor: clr.appPrimaryColorGreen,
                        borderColor: clr.appPrimaryColorGreen,
                      ),
                    ),
                    SizedBox(width: size.w16),
                    Expanded(
                      child: CustomButton(
                        onTap: () {},
                        title: label(e: en.saveAsDraft, b: bn.saveAsDraft),
                        radius: size.r4,
                        verticalPadding: size.h4,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
