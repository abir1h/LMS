import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_edit_screen.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../widgets/note_tile.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with AppTheme {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // status bar color
    ));
    return SafeArea(
        child: Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: "All Notes",
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
        height: 60.h,
        width: 60.w,
        padding: EdgeInsets.all(size.r16),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
            color: clr.whiteColor),
        child: SvgPicture.asset(
          ImageAssets.edit_square,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.filter_list,
                  color: clr.placeHolderTextColorGray,
                  size: size.r12,
                ),
                SizedBox(
                  width: size.w12,
                ),
                Text(
                  "Date modified",
                  style: TextStyle(
                      color: clr.placeHolderTextColorGray,
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
              hasDivider: true,
              onPressed: ()=>Get.to(const NoteEditScreen(content: StringData.noteContent)),
            ),
            NoteTile(
              noteContent: "CLMS LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "Sugg LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "Proje LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
              onPressed: () {},
            ),
            NoteTile(
              noteContent: "HESP LMS",
              title: "Note Title",
              timestamp: 'Today 10:00 am',
              hasDivider: true,
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
    ));
  }
}
