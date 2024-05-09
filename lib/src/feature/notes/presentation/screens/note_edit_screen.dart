import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/note_data_entity.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../service/note_edit_screen_service.dart';

class NoteEditScreen extends StatefulWidget {
  final Object? arguments;
  const NoteEditScreen({super.key, this.arguments});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen>
    with AppTheme, NoteEditScreenService {
  late NoteDetailsScreenArgs _screenArgs;
  final _controller = QuillController.basic();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  final _isReadOnly = false;
  final controller = Get.put(NoteController());
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as NoteDetailsScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setContent();
    });
  }

  setContent() {
    if (_screenArgs.noteDataEntity != null) {
      if (_screenArgs.noteDataEntity!.description.isNotEmpty) {
        final Document doc = Document.fromJson(
            json.decode(_screenArgs.noteDataEntity!.description));
        _controller.document = doc;
      }
      if (_screenArgs.noteDataEntity!.title.isNotEmpty) {
        titleController.text = _screenArgs.noteDataEntity!.title;
      }
    }
  }

  bool isKeyboardOpen = false;

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;

    return CustomScaffold(
      title: "",
      bgColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      leadingBack: () {
        if (titleController.text.isNotEmpty &&
            _controller.document.toPlainText().isNotEmpty) {
          _screenArgs.noteType == NoteType.create
              ? onCreateNotes(NoteDataEntity(
                  title: titleController.text,
                  description:
                      jsonEncode(_controller.document.toDelta().toJson()),
                  status: 1))
              : onUpdateNotes(NoteDataEntity(
                  id: _screenArgs.noteDataEntity!.id,
                  title: titleController.text,
                  description:
                      jsonEncode(_controller.document.toDelta().toJson()),
                  status: 1));
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.rootScreen,
              arguments: RootScreenArgs(index: 2),
              (route) => false);
        }
      },
      actionChild: Row(
        children: [
          IconButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    _controller.document.toPlainText().isNotEmpty) {
                  _screenArgs.noteType == NoteType.create
                      ? onCreateNotes(NoteDataEntity(
                          title: titleController.text,
                          description: jsonEncode(
                              _controller.document.toDelta().toJson()),
                          status: 1))
                      : onUpdateNotes(NoteDataEntity(
                          id: _screenArgs.noteDataEntity!.id,
                          title: titleController.text,
                          description: jsonEncode(
                              _controller.document.toDelta().toJson()),
                          status: 1));
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoute.rootScreen,
                      arguments: RootScreenArgs(index: 2),
                      (route) => false);
                }
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () {
                if (_screenArgs.noteType == NoteType.edit) {
                  if (titleController.text.isNotEmpty &&
                      _controller.document.toPlainText().isNotEmpty) {
                    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreen,
                        arguments: NoteDetailsScreenArgs(
                            noteDataEntity: NoteDataEntity(
                                id: _screenArgs.noteDataEntity!.id,
                                title: titleController.text,
                                description: jsonEncode(
                                    _controller.document.toDelta().toJson()),
                                status: 1),
                            noteType: NoteType.edit));
                  }
                } else {
                  if (titleController.text.isNotEmpty &&
                      _controller.document.toPlainText().isNotEmpty) {
                    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreen,
                        arguments: NoteDetailsScreenArgs(
                            noteDataEntity: NoteDataEntity(
                                title: titleController.text,
                                description: jsonEncode(
                                    _controller.document.toDelta().toJson()),
                                status: 1),
                            noteType: NoteType.create));
                  }
                }
              },
              icon: Icon(Icons.visibility,
                  size: size.r24, color: clr.iconColorDimGrey)),
        ],
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: QuillSharedConfigurations(
            animationConfigurations: QuillAnimationConfigurations.disableAll(),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.w16, right: size.w16),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    style: TextStyle(
                        fontSize: size.textXMedium,
                        color: clr.blackColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: StringData.fontFamilyPoppins),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: clr.boxStrokeColor,
                            width: 1.w), // Customize border color
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: clr.boxStrokeColor,
                            width: 1.w), // Customize border color
                      ),
                      hintText: "Title",
                      hintStyle: TextStyle(
                          fontSize: size.textXMedium,
                          color: clr.placeHolderTextColorGray,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                return Expanded(
                  child: InkWell(
                    onDoubleTap: () {},
                    child: QuillEditor(
                      scrollController: _editorScrollController,
                      focusNode: _editorFocusNode,
                      configurations: QuillEditorConfigurations(
                        readOnly: _isReadOnly,
                        customStyles: DefaultStyles(
                          code: DefaultTextBlockStyle(
                            TextStyle(
                                fontSize: size.textSmall,
                                color: clr.textColorAppleBlack,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            const VerticalSpacing(16, 0),
                            const VerticalSpacing(0, 0),
                            null,
                          ),
                          placeHolder: DefaultTextBlockStyle(
                            TextStyle(
                                fontSize: size.textXXSmall,
                                color: clr.placeHolderTextColorGray,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            const VerticalSpacing(16, 0),
                            const VerticalSpacing(0, 0),
                            null,
                          ),
                        ),
                        scrollable: true,
                        placeholder: 'Note...',
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                );
              },
            ),
            isKeyboardOpen
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillBaseToolbar(
                      configurations: QuillBaseToolbarConfigurations(
                        toolbarSize: 20 * 2,
                        multiRowsDisplay: false,
                        color: Colors.white,
                        buttonOptions: const QuillToolbarButtonOptions(
                          base: QuillToolbarBaseButtonOptions(
                            iconTheme: QuillIconTheme(
                                iconSelectedColor: Colors.white,
                                iconUnselectedFillColor: Colors.transparent),
                            globalIconSize: 30,
                          ),
                        ),
                        childrenBuilder: (context) {
                          final controller = context.requireQuillController;
                          return [
                            QuillToolbarToggleStyleButton(
                              attribute: Attribute.bold,
                              controller: controller,
                              options: QuillToolbarToggleStyleButtonOptions(
                                iconTheme: QuillIconTheme(
                                    iconSelectedColor: clr.appPrimaryColorGreen,
                                    iconUnselectedFillColor:
                                        Colors.transparent),
                                childBuilder: (options, extraOptions) {
                                  final buttonBackgroundColor = extraOptions
                                          .isToggled
                                      ? clr
                                          .placeHolderTextColorGray // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData),
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(options.iconData),
                                  );
                                },
                              ),
                            ),
                            QuillToolbarToggleStyleButton(
                              attribute: Attribute.italic,
                              controller: controller,
                              options: QuillToolbarToggleStyleButtonOptions(
                                childBuilder: (options, extraOptions) {
                                  final buttonBackgroundColor = extraOptions
                                          .isToggled
                                      ? clr
                                          .placeHolderTextColorGray // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData),
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(options.iconData),
                                  );
                                },
                              ),
                            ),
                            QuillToolbarToggleStyleButton(
                              attribute: Attribute.underline,
                              controller: controller,
                              options: QuillToolbarToggleStyleButtonOptions(
                                childBuilder: (options, extraOptions) {
                                  final buttonBackgroundColor = extraOptions
                                          .isToggled
                                      ? clr
                                          .placeHolderTextColorGray // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData),
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(options.iconData),
                                  );
                                },
                              ),
                            ),
                            /* QuillToolbarColorButton(
                              controller: controller,
                              isBackground: true,
                              options: const QuillToolbarColorButtonOptions(
                                iconData: Icons.text_format,
                                dialogBarrierColor: Colors.white,
                              ),
                            ),*/
                            QuillToolbarSelectAlignmentButton(
                              showLeftAlignment: true,
                              showRightAlignment: true,
                              showJustifyAlignment: true,
                              showCenterAlignment: true,
                              controller: controller,
                              options:
                                  const QuillToolbarSelectAlignmentButtonOptions(
                                iconButtonFactor: 2,
                                iconSize: 20,
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
CustomToasty.of(context).showSuccess(message);  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}
