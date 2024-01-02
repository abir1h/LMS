import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/quil_text_viewer.dart';
import 'note_edit_screen.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NoteModel? mainModel;
  const NoteDetailsScreen({
    super.key,
    this.mainModel,
  });

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> with AppTheme {
  String contentText = '';
  final controller = Get.put(NoteController());
  final _controller = QuillController.basic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  setData() {
    if (widget.mainModel != null) {
      if (widget.mainModel!.description != null) {
        final Document doc =
            Document.fromJson(widget.mainModel!.description as List);
        _controller.document=doc;
        contentText = doc.toPlainText();
      }
    }
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
                // Check if the note with the same ID exists in the list
                int existingIndex = controller.noteList.indexWhere(
                  (note) => note.id == widget.mainModel?.id!,
                );

                if (existingIndex != -1) {
                  // Replace the existing note with the updated one
                  controller.noteList[existingIndex] = widget.mainModel!;
                  Get.toNamed(AppRoutes.bottomNav, arguments: 2);
                } else {
                  // If the note with the ID doesn't exist, add it to the list
                  controller.noteList.add(widget.mainModel!);
                  Get.toNamed(AppRoutes.bottomNav, arguments: 2);
                }
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                Get.to(() => NoteEditScreen(
                      mainModel: widget.mainModel,

                    ));
              },
              icon:
                  Icon(Icons.edit, size: size.r24, color: clr.iconColorBlack)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.mainModel!.reference != "টপিক সিলেক্ট করুন"
                ? Row(
              children: [
                Expanded(
                    child: Text(
                      widget.mainModel!.reference.toString(),
                      style: TextStyle(
                          color: clr.appPrimaryColorGreen,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringData.fontFamilyPoppins),
                    )),
                Icon(
                  Icons.arrow_forward,
                  color: clr.appPrimaryColorGreen,
                )
              ],
            )
                : const SizedBox(),
            SizedBox(
              height: size.h10,
            ),
            Text(
              widget.mainModel!.title!,
              style: TextStyle(
                  fontSize: size.textXMedium,
                  color: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            Divider(
              color: clr.cardStrokeColor,
            ),
            QuilTextViewer(controller: _controller,)


          ],
        ),
      ),
    );
  }
}
