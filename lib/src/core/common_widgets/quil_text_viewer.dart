import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../constants/common_imports.dart';

class QuilTextViewer extends StatefulWidget {
  final QuillController controller;
  const QuilTextViewer({super.key, required this.controller});

  @override
  State<QuilTextViewer> createState() => _QuilTextViewerState();
}

class _QuilTextViewerState extends State<QuilTextViewer> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: widget.controller,
        sharedConfigurations: QuillSharedConfigurations(
          animationConfigurations: QuillAnimationConfigurations.disableAll(),
        ),
      ),
      child: Builder(
        builder: (context) {
          return QuillEditor(
            scrollController: ScrollController(),
            configurations: QuillEditorConfigurations(
              readOnly: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
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
            ),
            focusNode: FocusNode(),
          );
        },
      ),
    );
  }
}
