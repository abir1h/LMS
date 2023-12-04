import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/common_imports.dart';

class NoteTile extends StatefulWidget {
  final String noteContent;
  final String title;
  final String timestamp;
  final bool? hasDivider;
  final VoidCallback onPressed;

  const NoteTile(
      {Key? key,
        required this.noteContent,
        required this.title,
        required this.timestamp,
        this.hasDivider = false, required this.onPressed})
      : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: SizedBox(width: 1.sw,
        child: Column(
          children: [
            SizedBox(
              height: size.h12,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(size.r8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: SizedBox(
                    width: 35.w,
                    child: Text(
                      widget.noteContent,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: StringData.fontFamilyPoppins,
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXXSmall,
                        color: clr.blackColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: clr.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.textSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.timestamp,
                      style: TextStyle(
                        color: clr.placeHolderTextColorGray,
                        fontWeight: FontWeight.w400,
                        fontSize: size.textXXSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.h12,
            ),
            widget.hasDivider == true
                ? Divider(
              color: clr.boxStrokeColor,
            )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}