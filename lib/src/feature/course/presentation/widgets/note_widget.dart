import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../notes/presentation/screens/note_edit_screen.dart';

class NoteWidget extends StatelessWidget with AppTheme {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              NoteWidgetTile(
                  noteContent: "শিক্ষার্থীদের যোগ্যতা",
                  title: "শিক্ষার্থীদের যোগ্যতা",
                  timestamp: "তারিখ: ১৬ নভেম্বর ২০২৩",
                  onPressed: () {}),
              SizedBox(height: size.h64)
            ],
          ),
        ),
        Positioned(
          bottom: size.h20,
          right: size.w16,
          child: GestureDetector(
            onTap: () => Get.to(() => const NoteEditScreen()),
            child: Container(
              padding: EdgeInsets.all(size.r16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: clr.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: SvgPicture.asset(
                ImageAssets.icEditSquare,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NoteWidgetTile extends StatelessWidget with AppTheme {
  final String noteContent;
  final String title;
  final String timestamp;
  final VoidCallback onPressed;
  const NoteWidgetTile(
      {super.key,
      required this.noteContent,
      required this.title,
      required this.timestamp,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: size.w1,
          color: clr.boxStrokeColor,
        ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteContent,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.textSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        timestamp,
                        style: TextStyle(
                          color: clr.placeHolderTextColorGray,
                          fontWeight: FontWeight.w400,
                          fontSize: size.textXXSmall,
                          fontFamily: StringData.fontFamilyPoppins,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
