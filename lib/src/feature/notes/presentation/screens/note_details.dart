import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/common_widgets/custom_button.dart';
import 'package:lms/src/core/constants/app_theme.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_edit_screen.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class NoteDetailsScreen extends StatefulWidget {
  final List<dynamic>? content;
  final String? Title;
  const NoteDetailsScreen({super.key, this.content, this.Title});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> with AppTheme {
  String ContentText = '';
  final controller = Get.put(NoteController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Document doc = Document.fromJson(widget.content as List);
    ContentText = doc.toPlainText();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      bgColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      actionChild: Row(
        children: [
          IconButton(
              onPressed: () {
                DateTime now = DateTime.now();
                var currentTime = DateTime(
                    now.year, now.month, now.day, now.hour, now.minute);

                controller.noteList.add(NoteModel(
                    time: currentTime.toString(),
                    title: widget.Title,
                    description: widget.content));
                Get.toNamed(AppRoutes.bottomNav, arguments: 2);
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                Get.to(() => NoteEditScreen(
                      content: widget.content,
                      title: widget.Title,
                    ));
              },
              icon:
                  Icon(Icons.edit, size: size.r24, color: clr.iconColorBlack)),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.Title!,
              style: TextStyle(
                  fontSize: size.textXMedium,
                  color: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            Divider(
              color: clr.cardStrokeColor,
            ),
            Text(
              ContentText,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: size.textSmall,
                  color: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w500,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
          ],
        ),
      ),
    );
  }
}
