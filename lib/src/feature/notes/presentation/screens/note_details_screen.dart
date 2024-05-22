import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/note_data_entity.dart';
import '../service/note_edit_screen_service.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/note_controller.dart';
import '../service/note_details_screen_service.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const NoteDetailsScreen({super.key, this.arguments});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
    with AppTheme, NoteDetailsScreenService, NoteEditScreenService {
  late NoteDetailsScreenArgs _screenArgs;

  String contentText = '';
  final controller = Get.put(NoteController());
  final _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setData();
    });
  }

  setData() {
    if (_screenArgs.noteDataEntity != null) {
      if (_screenArgs.noteDataEntity!.description.isNotEmpty) {
        log(_screenArgs.noteDataEntity!.description);
        try{
          final Document doc = Document.fromJson(
              json.decode(_screenArgs.noteDataEntity!.description));
          _controller.document = doc;
          contentText = doc.toPlainText();
        } on FormatException catch (_) {
          Delta deltaText = convertStringToDelta(_screenArgs.noteDataEntity!.description);
          _controller.document = Document.fromDelta(deltaText);
        }
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
                if (_screenArgs.noteType == NoteType.edit) {
                  onUpdateNotes(NoteDataEntity(
                      id: _screenArgs.noteDataEntity!.id,
                      title: _screenArgs.noteDataEntity!.title,
                      description:
                          jsonEncode(_controller.document.toDelta().toJson()),
                      status: 1));
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.rootScreen, arguments: RootScreenArgs(index: 2),(route) => false);

                }else{
                  onCreateNotes(NoteDataEntity(
                      title: _screenArgs.noteDataEntity!.title,
                      description:
                      jsonEncode(_controller.document.toDelta().toJson()),
                      status: 1));
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.rootScreen, arguments: RootScreenArgs(index: 2),(route) => false);

                }
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                if(_screenArgs.noteType == NoteType.edit){
                  Navigator.of(context).pushNamed(AppRoute.noteEditScreen,
                      arguments: NoteDetailsScreenArgs(
                          noteDataEntity: _screenArgs.noteDataEntity,
                          noteType: NoteType.edit));
                }else{
                  Navigator.of(context).pushNamed(AppRoute.noteEditScreen,
                      arguments: NoteDetailsScreenArgs(
                          noteDataEntity: _screenArgs.noteDataEntity,
                          noteType: NoteType.create));
                }

              },
              icon: Icon(Icons.edit, size: size.r24, color: clr.iconColorBlack))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* _screenArgs.noteModel!.reference != "টপিক সিলেক্ট করুন"
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
                : const SizedBox(),*/
            SizedBox(
              height: size.h10,
            ),
            Text(
              _screenArgs.noteDataEntity!.title,
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

  @override
  void onNavigateToNoteEditScreen(NoteDataEntity noteDataEntity) {
    // TODO: implement onNavigateToNoteEditScreen
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }

  @override
  void showSuccess(String message) {
    // TODO: implement showSuccess
  }

}
