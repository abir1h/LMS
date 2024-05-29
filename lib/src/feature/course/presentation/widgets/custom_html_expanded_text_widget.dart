import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lms/src/core/constants/app_theme.dart';
import 'package:lms/src/core/constants/common_imports.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/utility/color_tools.dart';

class HtmlExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int minimumTextLengthToFold;

  const HtmlExpandableText({
    Key? key,
    required this.text,
    required this.style,
    required this.minimumTextLengthToFold,
  }) : super(key: key);

  @override
  State<HtmlExpandableText> createState() => _HtmlExpandableTextState();
}

class _HtmlExpandableTextState extends State<HtmlExpandableText> with AppTheme, Language {
  bool isFoldable = false;
  bool isFolded = true;

  @override
  void initState() {
    isFoldable = widget.text.length > widget.minimumTextLengthToFold;
    super.initState();
  }

  Widget stringToWidget({required String input, TextStyle? textStyle}) {
    // Check if the input string contains HTML tags
    bool containsHtmlTags(String text) {
      final htmlTagsRegExp = RegExp(r'<[^>]*>');
      return htmlTagsRegExp.hasMatch(text);
    }

    String displayedText = input;
    if (isFoldable && isFolded) {
      displayedText = input.substring(0, widget.minimumTextLengthToFold.clamp(0, input.length)) + '...';
    }

    if (containsHtmlTags(displayedText)) {
      // Return HtmlWidget if the string contains HTML tags
      return HtmlWidget(
        displayedText,
        textStyle: textStyle ?? TextStyle(
          color: HexColor("646464"),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      // Return Text widget if the string does not contain HTML tags
      return Text(
        displayedText,
        style: textStyle ?? TextStyle(
          color: HexColor("646464"),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stringToWidget(input: widget.text, textStyle: widget.style),
        if (isFoldable)
          GestureDetector(
            onTap: _toggleFold,
            child: Text(
              isFolded ? label(e: en.seeMore, b: bn.seeMore) : label(e: en.seeLess, b: bn.seeLess),
              style: widget.style.copyWith(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textXSmall,
              ),
            ),
          ),
      ],
    );
  }

  void _toggleFold() {
    setState(() {
      isFolded = !isFolded;
    });
  }
}
