import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';
import '../../../notes/presentation/controllers/note_controller.dart';
import '../../../notes/presentation/models/note_model.dart';

class NoteBottomSheet extends StatefulWidget {
  final NoteModel? mainModel;

  final String? ref;

  const NoteBottomSheet({
    super.key,
    this.mainModel,
    this.ref,
  });

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet>
    with AppTheme, Language {
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
    if (widget.mainModel != null) {
      if (widget.mainModel!.description != null) {
        final Document doc =
            Document.fromJson(widget.mainModel?.description as List);
        _controller.document = doc;
      }
      if (widget.mainModel!.title != null) {
        titleController.text = widget.mainModel!.title!;
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

  saveData() {
    if (titleController.text.isEmpty && _controller.document.isEmpty()) {
      Get.back();
    } else {
      if (widget.mainModel == null) {
        int id = controller.noteList.length + 1;
        DateTime now = DateTime.now();
        var currentTime =
            DateTime(now.year, now.month, now.day, now.hour, now.minute);
        var newModel = NoteModel(
            id: id,
            time: currentTime.toString(),
            title: titleController.text,
            description: _controller.document.toDelta().toJson(),
            reference: widget.ref);
        controller.noteList.add(newModel);
        Get.back();
        CustomToasty.of(context)
            .showSuccess("তালিকা সফলভাবে সংরক্ষণ করা হয়েছে");
      } else {
        DateTime now = DateTime.now();
        var currentTime = DateTime(
          now.year,
          now.month,
          now.day,
          now.hour,
          now.minute,
        );
        var updatedModel = NoteModel(
            id: widget.mainModel?.id!,
            time: currentTime.toString(),
            title: titleController.text,
            description: _controller.document.toDelta().toJson(),
            reference: widget.ref);

        // Check if the note with the same ID exists in the list
        int existingIndex = controller.noteList.indexWhere(
          (note) => note.id == updatedModel.id,
        );

        if (existingIndex != -1) {
          // Replace the existing note with the updated one
          controller.noteList[existingIndex] = updatedModel;
          Get.back();

          CustomToasty.of(context)
              .showSuccess("তালিকা সফলভাবে আপডেট করা হয়েছে");
        } else {
          // If the note with the ID doesn't exist, add it to the list
          controller.noteList.add(updatedModel);
          Get.back();

          CustomToasty.of(context)
              .showSuccess("তালিকা সফলভাবে আপডেট করা হয়েছে");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) { MediaQueryData mediaQuery = MediaQuery.of(context);
  isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 180.h),
            padding: EdgeInsets.only(
               top:size.h10 ,right:size.w16),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.w12),
                topRight: Radius.circular(size.w12),
              ),
            ),
            child:  QuillProvider(
              configurations: QuillConfigurations(
                controller: _controller,
                sharedConfigurations: QuillSharedConfigurations(
                  animationConfigurations: QuillAnimationConfigurations.disableAll(),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          saveData();
                        },
                        child: Container(
                          padding: EdgeInsets.all(size.r10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,

                            borderRadius: BorderRadius.circular(size.r8),color: clr.appPrimaryColorGreen
                          ), child: Icon(Icons.check,color: clr.whiteColor,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.w16, right: size.w16),
                    child: Column(
                      children: [
                 /*       widget.mainModel != null
                            ? widget.mainModel!.reference != null
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
                          ],
                        )
                            : SizedBox()
                            : SizedBox(),*/
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
                                      .appPrimaryColorGreen // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData,color: Colors.white,),
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: extraOptions.onPressed,
                                    icon: Icon(options.iconData,),
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
                                      .appPrimaryColorGreen // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData,color: Colors.white,),
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
                                      .appPrimaryColorGreen // Background color when toggled
                                      : Colors.transparent;
                                  if (extraOptions.isToggled) {
                                    return Container(
                                      color: buttonBackgroundColor,
                                      child: IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(options.iconData,color: Colors.white,),
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
