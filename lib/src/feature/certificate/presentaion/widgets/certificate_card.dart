import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/common_imports.dart';

class CertificateCard extends StatelessWidget with AppTheme {
  const CertificateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size.h16, horizontal: size.w16),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: size.w1, color: clr.cardStrokeColor),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "পাঠ্যক্রম",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyInter,
                      color: clr.appPrimaryColorGreen),
                ),
                SizedBox(height: size.h8),
                Text(
                  "শিখন ক্ষেত্র ১ :  শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                      color: clr.textColorBlack),
                ),
                SizedBox(height: size.h8),
                Text(
                  "সময়কাল  ১৫/১১/২৩ - ৩০/১১/২৩",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textXXSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.textColorBlack),
                ),
                SizedBox(height: size.h8),
                Text(
                  "স্বীকৃতিপত্র .pdf",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.appPrimaryColorGreen),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            ImageAssets.downloadIcon,
            height: size.h24,
            width: size.w24,
          )
        ],
      ),
    );
  }
}
