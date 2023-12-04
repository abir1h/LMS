import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/app_theme.dart';

class NoteEditScreen extends StatefulWidget {
  final String content;
  const NoteEditScreen({super.key, required this.content});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> with AppTheme {
  final _controller = QuillController.basic();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  final _isReadOnly = false;
  @override
  void initState() {
    super.initState();
/*
    _controller.document = widget.content;
*/
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      bgColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      actionChild: Row(
        children: [
          GestureDetector(
            onTap: () {
              final json = jsonEncode(_controller.document.toDelta().toJson());

              print(_controller.document.toDelta());
              print(json + '/////');
              final json2 = jsonDecode(json);

              _controller.document = Document.fromJson(json2);
              print(_controller.document.toPlainText() + '>>>>>>>>>>>>>>>');
            },
            child: Icon(
              Icons.edit,
              size: size.r24,
              color: clr.appPrimaryColorGreen,
            ),
          ),
          SizedBox(width: size.w12),
          Icon(
            Icons.import_contacts,
            size: size.r24,
            color: clr.appPrimaryColorGreen,
          ),
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
            Builder(
              builder: (context) {
                return Expanded(
                  child: Editor(
                    configurations: QuillEditorConfigurations(
                      readOnly: _isReadOnly,
                    ),
                    scrollController: _editorScrollController,
                    focusNode: _editorFocusNode,
                  ),
                );
              },
            ),
            Padding(
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
                        options: const QuillToolbarSelectAlignmentButtonOptions(
                          iconButtonFactor: 2,
                          iconSize: 20,
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}

class Editor extends StatefulWidget {
  const Editor(
      {super.key,
      required this.configurations,
      required this.scrollController,
      required this.focusNode});
  final QuillEditorConfigurations configurations;
  final ScrollController scrollController;
  final FocusNode focusNode;
  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      scrollController: widget.scrollController,
      focusNode: widget.focusNode,
      configurations: widget.configurations.copyWith(
        customStyles: const DefaultStyles(
          h1: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 32,
              height: 1.15,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
            VerticalSpacing(16, 0),
            VerticalSpacing(0, 0),
            null,
          ),
          sizeSmall: TextStyle(fontSize: 9),
        ),
        scrollable: true,
        placeholder: 'Start writting your notes...',
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({super.key});

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  bool isHighlighted = false;
  TextAlign alignment = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isBold = !isBold;
                  });
                },
                icon: const Icon(Icons.format_bold),
                color: isBold ? Colors.blue : null,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isItalic = !isItalic;
                  });
                },
                icon: const Icon(Icons.format_italic),
                color: isItalic ? Colors.blue : null,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isUnderline = !isUnderline;
                  });
                },
                icon: const Icon(Icons.format_underline),
                color: isUnderline ? Colors.blue : null,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isHighlighted = !isHighlighted;
                  });
                },
                icon: const Icon(Icons.highlight),
                color: isHighlighted ? Colors.yellow : null,
              ),
              DropdownButton<TextAlign>(
                value: alignment,
                onChanged: (TextAlign? value) {
                  setState(() {
                    alignment = value!;
                  });
                },
                items: const [
                  DropdownMenuItem<TextAlign>(
                    value: TextAlign.left,
                    child: Text('Left'),
                  ),
                  DropdownMenuItem<TextAlign>(
                    value: TextAlign.center,
                    child: Text('Center'),
                  ),
                  DropdownMenuItem<TextAlign>(
                    value: TextAlign.right,
                    child: Text('Right'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          SelectableText.rich(
            TextSpan(
              text: _textEditingController.text,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                decoration: isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                backgroundColor: isHighlighted ? Colors.yellow : null,
              ),
            ),
            textAlign: alignment,
            onTap: () {
              // Handle text selection or tapping
            },
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _textEditingController,
            maxLines: null,
            onChanged: (text) {
              // Handle text changes
            },
            decoration: const InputDecoration(
              labelText: 'Enter your text',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
