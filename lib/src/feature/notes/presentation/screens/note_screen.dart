import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/note_controller.dart';
import '../widgets/note_tile.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AppTheme, Language, AppEventsNotifier {
  final List<dynamic> contents = [
    {
      "insert":
          "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া."
    },
    {
      "attributes": {"code-block": true},
      "insert": "\n\n\n"
    },
    {"insert": "\n"}
  ];

  final controller = Get.put(NoteController());
  int selectedValue = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<int>(
                color: clr.whiteColor,
                surfaceTintColor: clr.whiteColor,
                padding: EdgeInsets.only(
                    left: size.h12,
                    right: 40.w,
                    bottom: size.h20,
                    top: size.h12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.r8)),
                position: PopupMenuPosition.under,
                onSelected: (int value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: SizedBox(
                      width: 1.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Title",
                            style: selectedValue == 1
                                ? TextStyle(
                                    color: clr.appPrimaryColorGreen,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyPoppins,
                                    fontSize: size.textSmall)
                                : TextStyle(
                                    color: clr.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyPoppins,
                                    fontSize: size.textSmall),
                          ),
                          SizedBox(width: size.w8),
                          if (selectedValue == 1)
                            Icon(
                              Icons.check,
                              color: clr.appPrimaryColorGreen,
                            ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date Created",
                          style: selectedValue == 2
                              ? TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins,
                                  fontSize: size.textSmall)
                              : TextStyle(
                                  color: clr.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins,
                                  fontSize: size.textSmall),
                        ),
                        SizedBox(width: size.w8),
                        if (selectedValue == 2)
                          Icon(
                            Icons.check,
                            color: clr.appPrimaryColorGreen,
                            size: size.r24,
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date Modified",
                          style: selectedValue == 3
                              ? TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins,
                                  fontSize: size.textSmall)
                              : TextStyle(
                                  color: clr.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins,
                                  fontSize: size.textSmall),
                        ),
                        SizedBox(width: size.w8),
                        if (selectedValue == 3)
                          Icon(
                            Icons.check,
                            color: clr.appPrimaryColorGreen,
                            size: size.r24,
                          ),
                      ],
                    ),
                  ),
                ],
                child: Padding(
                  padding: EdgeInsets.only(right: size.w4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: clr.appPrimaryColorGreen,
                        size: size.r16,
                      ),
                      SizedBox(width: size.w8),
                      Text(
                        selectedValue == 1
                            ? "Title"
                            : selectedValue == 2
                                ? "Date Created"
                                : "Date modified",
                        style: TextStyle(
                          color: clr.textColorBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: size.textXSmall,
                          fontFamily: StringData.fontFamilyPoppins,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.h12),
          Obx(
            () => ListView.builder(
                itemCount: controller.noteList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return NoteTile(
                    noteContent:
                        controller.noteList[index].title.toString().isNotEmpty
                            ? controller.noteList[index].title.toString()
                            : controller.noteList[index].description != null
                                ? Document.fromJson(controller
                                        .noteList[index].description as List)
                                    .toPlainText()
                                : "New Note",
                    title:
                        controller.noteList[index].title.toString().isNotEmpty
                            ? controller.noteList[index].title.toString()
                            : controller.noteList[index].description != null
                                ? Document.fromJson(controller
                                        .noteList[index].description as List)
                                    .toPlainText()
                                : "New Note",
                    timestamp: DateFormat('dd MMMM yyyy').format(
                        DateTime.parse(controller.noteList[index].time!)),
                    reference: controller.noteList[index].reference,
                    onPressed: () => Navigator.of(context).pushNamed(
                        AppRoute.noteDetailsScreen,
                        arguments: NoteDetailsScreenArgs(
                            noteModel: controller.noteList[index])),
                  );
                }),
          ),
          SizedBox(height: size.h64)
        ],
      ),
    );
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.notesScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
