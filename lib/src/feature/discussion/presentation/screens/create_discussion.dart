import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class CreateDiscussion extends StatefulWidget {
  const CreateDiscussion({super.key});

  @override
  State<CreateDiscussion> createState() => _CreateDiscussionState();
}

class _CreateDiscussionState extends State<CreateDiscussion>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: EdgeInsets.only(
                left: size.w24, right: size.w24, bottom: size.h24),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.w32),
                topRight: Radius.circular(size.w32),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Title
                  Container(
                    margin: EdgeInsets.only(bottom: size.h8, top: size.h8),
                    padding: EdgeInsets.symmetric(
                        vertical: size.h8, horizontal: size.w24),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            // color: clr.textBlackDisable.withOpacity(.4),
                            ),
                      ),
                    ),
                    child: Text(
                      label(e: en.newDiscussion, b: bn.newDiscussion),
                      style: TextStyle(
                        color: clr.appPrimaryColorGreen,
                        fontSize: size.textXLarge,
                      ),
                    ),
                  ),

                  ///Description text
                  Text(
                    'Write your opinion/comment on this course or any course contents.',
                    style: TextStyle(
                      color: clr.textColorAppleBlack,
                      fontSize: size.textSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.h24),

                  ///Content section
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: size.h8),
                          child: Text(
                            'Comment on',
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // SelectorDropDownList<MapEntry<String, int>>(
                        //   onLoadData: () async => _discussionType,
                        //   onGenerateTitle: (x) => x.key,
                        //   onSelected: _onDiscussionTypeSelected,
                        // ),

                        ///Discussion content
                        // if (_selectedDiscussionType.value != -1 &&
                        //     _selectedDiscussionType.value != 4)
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: size.h8, top: size.h24),
                          child: Text(
                            // _selectedDiscussionType.key,
                            "key",
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // if (_selectedDiscussionType.value != -1 &&
                        //     _selectedDiscussionType.value != 4)
                        //   SelectorDropDownList<MapEntry<String, String>>(
                        //     key: ObjectKey(_selectedDiscussionType.value),
                        //     onLoadData: () async => _generateContentList(),
                        //     onGenerateTitle: (x) => x.key,
                        //     onSelected: _onContentSelected,
                        //   ),

                        Padding(
                          padding:
                              EdgeInsets.only(bottom: size.h8, top: size.h24),
                          child: Text(
                            'Comment',
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // TextFieldWidget(
                        //   controller: _commentController,
                        //   multiline: true,
                        //   hintText: "Write here..",
                        // ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.h24),

                  ///Post button
                  // ActionButton<String>(
                  //   title: "Post",
                  //   // controller: _buttonController,
                  //   onCheck: _onValidate,
                  //   tapAction: () => widget.doPostComment(
                  //       _selectedDiscussionType.value,
                  //       _selectedContent.id,
                  //       _commentController.text.trim()),
                  //   onSuccess: (String courseId) {
                  //     Navigator.of(context).pop();
                  //     widget.onPostSuccess(courseId);
                  //   },
                  // ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
