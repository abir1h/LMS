import 'package:flutter/material.dart';

import '../widgets/notification_card.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class NotificationScreen extends StatelessWidget with AppTheme {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: StringData.notification,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              NotificationCard(
                leading: Icon(
                  Icons.play_circle_outline,
                  color: clr.appSecondaryColorFlagRed,
                  size: size.r24,
                ),
                title:
                    "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা এর “শিখন ক্ষেত্র ১: শিক্ষা” এর ভিডিও কনটেন্ট  সকাল ৯.৩০ ঘটিকায় শুরু হবে",
                time: "১ ঘণ্টা পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title:
                    "ব্যবহারকারীর নাম আপনার কমেন্টের রিপ্লাই দিয়েছে “ভিডিও ১: কোর্স পরিচিতি” পেজ এ",
                time: "২ ঘণ্টা পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              NotificationCard(
                leading: Icon(
                  Icons.auto_stories,
                  color: clr.appPrimaryColorGreen,
                  size: size.r24,
                ),
                title:
                    "শিখন ক্ষেত্র ১: শিক্ষা এর রিডিং: “পড়ার উপাদানের নাম” আপনার জন্য প্রস্তুত  রয়েছে।",
                time: "১ দিন পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              NotificationCard(
                leading: Icon(
                  Icons.assignment_add,
                  color: clr.appPrimaryColorGreen,
                  size: size.r24,
                ),
                title:
                    "শিখন ক্ষেত্র ১: শিক্ষা এর মূল্যায়ন : “মূল্যায়নের শিরোনাম” আপনার জন্য প্রস্তুত  রয়েছে।",
                time: "১ দিন পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title:
                    "ব্যবহারকারীর নাম আপনার  কমেন্টের রিপ্লাই দিয়েছে ভিডিও ১: কোর্স পরিচিতি পেজ এ",
                time: "২ দিন পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title:
                    "ব্যবহারকারীর নাম আপনার  কমেন্টের রিপ্লাই দিয়েছে ভিডিও ১: কোর্স পরিচিতি পেজ এ",
                time: "২ দিন পূর্বে",
                bgColor: clr.backgroundColorMintCream,
              ),
              Padding(
                padding: EdgeInsets.only(top: size.h20, bottom: size.h20),
                child: Center(
                  child: Text(
                    'আরো দেখুন',
                    style: TextStyle(
                        fontSize: size.textSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontWeight: FontWeight.w600,
                        color: clr.appPrimaryColorGreen),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
