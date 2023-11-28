import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/common_imports.dart';

class RecognitionCard extends StatelessWidget with AppTheme {
  final String title, time, description;
  const RecognitionCard(
      {Key? key,
      required this.title,
      required this.time,
      required this.description})
      : super(key: key);

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
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                      color: clr.appPrimaryColorGreen),
                ),
                SizedBox(height: size.h8),
                Text(
                  time,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textXXSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.textColorBlack),
                ),
                SizedBox(height: size.h8),
                Row(
                  children: [
                    Icon(
                      Icons.picture_as_pdf_outlined,
                      color: clr.appSecondaryColorFlagRed,
                    ),
                    SizedBox(
                      width: size.w8,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.textSmall,
                          fontFamily: StringData.fontFamilyRoboto,
                          color: clr.appPrimaryColorGreen),
                    ),
                  ],
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
