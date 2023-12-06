import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/notes/presentation/models/note_model.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_details.dart';

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

class _NoteScreenState extends State<NoteScreen> with AppTheme, Language {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.scaffoldBackgroundColor,
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
          Get.to(const NoteEditScreen());
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
            Row(
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
                      fontFamily: StringData.fontFamilyPoppins),
                )
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
                              : '',
                      title: controller.noteList[index].title! ?? '',
                      timestamp: controller.noteList[index].time! ?? "",
                      onPressed: () => Get.to(NoteDetailsScreen(
                        content: controller.noteList[index].description!,
                        Title: controller.noteList[index].title!,
                      )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
