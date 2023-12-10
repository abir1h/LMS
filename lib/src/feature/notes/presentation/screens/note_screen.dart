import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import 'note_details.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/note_controller.dart';
import 'note_edit_screen.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../widgets/note_tile.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AppTheme, Language, AppEventsNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: label(e: en.allNotes, b: bn.allNotes),
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          trailingOnPressed: () {},
          trailing: Icon(
            Icons.search,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
          leading: Icon(
            Icons.menu,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => const NoteEditScreen());
        },
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        child: Column(
          children: [
            // Variable to store the selected value

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
                    // Set the selected value when a menu item is selected
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
                              "Title ",
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
                            SizedBox(
                              width: size.w8,
                            ),
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
                            "Date Created ",
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
                          SizedBox(
                            width: size.w8,
                          ),
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
                          SizedBox(
                            width: size.w8,
                          ),
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
                        "Date modified",
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
              ],
            ),

            Obx(
              () => ListView.builder(
                  itemCount: controller.noteList.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return NoteTile(
                      noteContent:
                          controller.noteList[index].title.toString().isNotEmpty
                              ? controller.noteList[index].title.toString()[0]
                              : 'N',
                      title: controller.noteList[index].title!.toString().isNotEmpty?controller.noteList[index].title!:"New Note",
                      timestamp: controller.noteList[index].time!,
                      onPressed: () => Get.to(() => NoteDetailsScreen(
                            mainModel: controller.noteList[index],
                          )),
                    );
                  }),
            ),
          ],
        ),
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
