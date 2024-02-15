import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/note_controller.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const NoteDetailsScreen({super.key, this.arguments});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> with AppTheme {
  late NoteDetailsScreenArgs _screenArgs;

  String contentText = '';
  final controller = Get.put(NoteController());
  final _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    setData();
  }

  setData() {
    if (_screenArgs.noteModel != null) {
      if (_screenArgs.noteModel!.description != null) {
        final Document doc =
            Document.fromJson(_screenArgs.noteModel!.description as List);
        _controller.document = doc;
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
                  (note) => note.id == _screenArgs.noteModel?.id!,
                );

                if (existingIndex != -1) {
                  // Replace the existing note with the updated one
                  controller.noteList[existingIndex] = _screenArgs.noteModel!;
                  Navigator.of(context).pushNamed(AppRoute.rootScreen,
                      arguments: RootScreenArgs(index: 2));
                  // Get.toNamed(AppRoutes.bottomNav, arguments: 2);
                } else {
                  // If the note with the ID doesn't exist, add it to the list
                  controller.noteList.add(_screenArgs.noteModel!);
                  Navigator.of(context).pushNamed(AppRoute.rootScreen,
                      arguments: RootScreenArgs(index: 2));
                }
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoute.noteEditScreen,
                    arguments: NoteDetailsScreenArgs(
                        noteModel: _screenArgs.noteModel));
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
            _screenArgs.noteModel!.reference != "টপিক সিলেক্ট করুন"
                ? InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoute.transcriptVideoScreen),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          _screenArgs.noteModel!.reference.toString(),
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
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: size.h10,
            ),
            Text(
              _screenArgs.noteModel!.title!,
              style: TextStyle(
                  fontSize: size.textXMedium,
                  color: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            Divider(
              color: clr.cardStrokeColor,
            ),
            QuilTextViewer(
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }
}