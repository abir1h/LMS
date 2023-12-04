import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
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
          trailing: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
          ),
          leading: Icon(
            Icons.menu,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
        ),
      ),
      floatingActionButton: Container(
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
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () => Get.to(NoteEditScreen(
                  content: label(e: en.noteContent, b: bn.noteContent))),
            ),
            NoteTile(
              noteContent: "CLMS LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "Sugg LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "Proje LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
