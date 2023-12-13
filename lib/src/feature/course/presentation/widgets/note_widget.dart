import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/course/presentation/widgets/note_bottom_sheet.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../notes/presentation/controllers/note_controller.dart';
import '../../../notes/presentation/screens/note_details.dart';
import '../../../notes/presentation/screens/note_edit_screen.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget>  with AppTheme{
  final controller = Get.put(NoteController());
  void onTapCreateDiscussion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const NoteBottomSheet(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                    () => ListView.builder(
                    itemCount: controller.noteList.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return NoteWidgetTile(
                        noteContent:
                        controller.noteList[index].title.toString().isNotEmpty
                            ? controller.noteList[index].title.toString()
                            : controller.noteList[index].description!=null?Document.fromJson(controller.noteList[index].description as List).toPlainText():"New Note",
                        title:     controller.noteList[index].title.toString().isNotEmpty
                            ? controller.noteList[index].title.toString()
                            : controller.noteList[index].description!=null?Document.fromJson(controller.noteList[index].description as List).toPlainText():"New Note",
                        timestamp: controller.noteList[index].time!,
                        onPressed: () => showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>  NoteBottomSheet(mainModel: controller.noteList[index]),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 100.h)
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () =>  showCupertinoModalPopup(
              context: context,
              builder: (context) => const NoteBottomSheet(),
            ),
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  color: clr.whiteColor,
                  border: Border(
                      top: BorderSide(
                          color: clr.boxStrokeColor,
                          width: 1.w
                      )
                  )
              ),

              padding: EdgeInsets.all(size.r16),
              child: Row(
                children: [
                  Container(
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
                  SizedBox(width: size.w8,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:14.w,top: 10,bottom: 10 ,),
                      decoration: BoxDecoration(
                          color: clr.shadeWhiteColor2,
                          borderRadius: BorderRadius.circular(size.r8),
                          border: Border.all(color: clr.boxStrokeColor)

                      ),child: Text("নোটস নিন",style: TextStyle(
                        fontWeight: FontWeight.w400,color: clr.placeHolderTextColorGray,
                        fontSize: size.textSmall
                    ),),
                    ),
                  )
                ],
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
