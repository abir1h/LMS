import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';

class DashboardCard extends StatelessWidget with AppTheme {
  final String title, subTitle;
  final Color? titleColor;
  final Color? primaryColor;
  final Color? borderColor;
  final Widget? image;
  final Function() onPressed;
  const DashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleColor,
    this.primaryColor,
    this.borderColor = Colors.white,
    this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.only(
            left: size.w16, top: size.h12, bottom: size.h10, right: size.w16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.w8),
          color: primaryColor,
          border: Border.all(color: borderColor!),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: clr.blackColor.withOpacity(.15))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: titleColor ?? clr.textColorAppleBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subTitle,
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyRoboto),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                image!
              ],
            ),
          ],
        ),
      ),
    );
  }
}
