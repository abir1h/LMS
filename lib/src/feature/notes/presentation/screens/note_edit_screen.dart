import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/feature/notes/presentation/controllers/note_controller.dart';
import 'package:lms/src/feature/notes/presentation/models/note_model.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_details.dart';
import 'package:lms/src/feature/notes/presentation/screens/note_screen.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/app_theme.dart';

class NoteEditScreen extends StatefulWidget {
  final List<dynamic>? content;
  final String? title;
  const NoteEditScreen({super.key, this.content, this.title});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> with AppTheme {
  final _controller = QuillController.basic();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  var _isReadOnly = false;
  final controller = Get.put(NoteController());
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setContent();
  }

  setContent() {
    if (widget.content != null) {
      final Document doc = Document.fromJson(widget.content as List);
      _controller.document = doc;
      titleController.text = widget.title!;
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

  void toggleEditor() {
    setState(() {
      _isReadOnly = !_isReadOnly;
    });
  }

  NoteModel noteModel = NoteModel();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;

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
                    title: titleController.text,
                    description: _controller.document.toDelta().toJson()));
                Get.toNamed(AppRoutes.bottomNav, arguments: 2);
              },
              icon: Icon(Icons.check,
                  size: size.r24, color: clr.appPrimaryColorGreen)),
          IconButton(
              onPressed: () => Get.to(NoteDetailsScreen(
                    content: _controller.document.toDelta().toJson(),
                    Title: titleController.text,
                  )),
              icon: Icon(Icons.import_contacts,
                  size: size.r24, color: clr.iconColorBlack)),
        ],
      ),
      child: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: QuillSharedConfigurations(
            animationConfigurations: QuillAnimationConfigurations.disableAll(),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.w16, right: size.w16),
              child: TextField(
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
                                childBuilder: (options, extraOptions) {
                                  if (extraOptions.isToggled) {
                                    return IconButton(
                                      onPressed: extraOptions.onPressed,
                                      icon: Icon(options.iconData),
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
                                  if (extraOptions.isToggled) {
                                    return IconButton(
                                      onPressed: extraOptions.onPressed,
                                      icon: Icon(options.iconData),
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
                                  if (extraOptions.isToggled) {
                                    return IconButton(
                                      onPressed: extraOptions.onPressed,
                                      icon: Icon(options.iconData),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(options.iconData),
                                  );
                                },
                              ),
                            ),
                            QuillToolbarColorButton(
                              controller: controller,
                              isBackground: true,
                              options: const QuillToolbarColorButtonOptions(
                                iconData: Icons.text_format,
                                dialogBarrierColor: Colors.white,
                              ),
                            ),
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
}
