import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lms/src/core/common_widgets/custom_toasty.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';

class AssignmentBottomSheet extends StatefulWidget {
  final String type;
  final AssignmentDataEntity? assignmentDataEntity;
  final String? answer;
  const AssignmentBottomSheet({
    super.key,
    required this.type,
    this.assignmentDataEntity,
    this.answer,
  });

  @override
  State<AssignmentBottomSheet> createState() => _AssignmentBottomSheetState();
}

class _AssignmentBottomSheetState extends State<AssignmentBottomSheet>
    with AppTheme, Language {
  final _controller = QuillController.basic();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();

  final bool _isReadOnly = false;
  @override
  void initState() {
    super.initState();
    setContent();
  }

  setContent() {
    if (widget.answer != null) {
      final Document doc = Document.fromJson(json.decode(widget.answer!));
      _controller.document = doc;
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: mediaQuery.padding.top * 3),
          padding:
              EdgeInsets.only(top: size.h10, right: size.w16, left: size.w20),
          decoration: BoxDecoration(
            color: clr.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.w12),
              topRight: Radius.circular(size.w12),
            ),
          ),
          child: QuillProvider(
            configurations: QuillConfigurations(
              controller: _controller,
              sharedConfigurations: QuillSharedConfigurations(
                animationConfigurations:
                    QuillAnimationConfigurations.disableAll(),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_controller.document.isEmpty()) {
                          CustomToasty.of(context)
                              .showWarning("Assignment should not be empty");
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                              AppRoute.assignmentSubmitScreen,
                              arguments: AssignmentSubmitScreenArgs(
                                  assignmentDataEntity:
                                      widget.assignmentDataEntity,
                                  answer: jsonEncode(
                                    _controller.document.toDelta().toJson(),
                                  ),
                                  type: widget.type));
                          AppEventsNotifier.notify(
                              EventAction.assignmentSubmitScreen);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.r4),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(size.r8),
                            color: _controller.document.isEmpty()
                                ? clr.placeHolderTextColorGray
                                : clr.appPrimaryColorGreen),
                        child: Icon(
                          Icons.check,
                          color: clr.whiteColor,
                          size: size.r24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.h24),
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
                                    fontSize: size.textSmall,
                                    color: clr.placeHolderTextColorGray,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: StringData.fontFamilyPoppins),
                                const VerticalSpacing(16, 0),
                                const VerticalSpacing(0, 0),
                                null,
                              ),
                            ),
                            scrollable: true,
                            placeholder:
                                label(e: en.writeHere, b: bn.writeHere),
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
                                    iconUnselectedFillColor:
                                        Colors.transparent),
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
                                        iconSelectedColor:
                                            clr.appPrimaryColorGreen,
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
                                            icon: Icon(
                                              options.iconData,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }
                                      return IconButton(
                                        onPressed: extraOptions.onPressed,
                                        icon: Icon(
                                          options.iconData,
                                        ),
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
                                            icon: Icon(
                                              options.iconData,
                                              color: Colors.white,
                                            ),
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
                                            icon: Icon(
                                              options.iconData,
                                              color: Colors.white,
                                            ),
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
                                /*    QuillToolbarColorButton(
                            controller: controller,
                            isBackground: true,
                            options:
                            const QuillToolbarColorButtonOptions(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
