import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/src/feature/discussion/models/discusion_model.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controller/discussion_controller.dart';

class DiscussionBottomSheet extends StatefulWidget {
  const DiscussionBottomSheet({super.key});

  @override
  State<DiscussionBottomSheet> createState() => _DiscussionBottomSheetState();
}

class _DiscussionBottomSheetState extends State<DiscussionBottomSheet>
    with AppTheme, Language {
  TextEditingController titleController = TextEditingController();
  TextEditingController discussionController = TextEditingController();
  final controller = Get.put(DiscussionController());

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {});
    });
    discussionController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<DiscussionController>(builder: (_) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
              decoration: BoxDecoration(
                color: clr.shadeWhiteColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.r12),
                  topRight: Radius.circular(size.w12),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      hintText:
                      label(e: en.discussionTitle, b: bn.discussionTitle),
                      controller: titleController,
                    ),
                    SizedBox(height: size.h8),
                    TextField(
                      controller: discussionController,
                      minLines: 10,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          color: clr.textColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w400,
                          fontFamily: StringData.fontFamilyPoppins),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: label(e: en.writeHere, b: bn.writeHere),
                        hintStyle: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: clr.appPrimaryColorGreen, width: size.w1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(size.w8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: clr.boxStrokeColor, width: size.w1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(size.w8))),
                      ),
                    ),
                    SizedBox(height: size.h16),
                    CustomButton(
                      onTap: () {
                        if (titleController.text.isNotEmpty &&
                            discussionController.text.isNotEmpty) {
                          DateTime now = DateTime.now();
                          var currentTime = DateTime(
                              now.year, now.month, now.day, now.hour, now.minute);

                          DiscussionModel saveDiscussion = DiscussionModel(
                            discussionId: 1,
                            title: titleController.text,
                            description: discussionController.text,
                            avatar: ImageAssets.imgEmptyProfile,
                            comments: [],
                            createdAt: "২০ নভেম্বর ২০২৩",
                          );
                          controller.addDiscussion(saveDiscussion);
                        }
                      },
                      title: label(
                          e: en.publishTheDiscussion, b: bn.publishTheDiscussion),
                      bgColor: (titleController.text.isNotEmpty &&
                          discussionController.text.isNotEmpty)
                          ? clr.appPrimaryColorGreen
                          : clr.placeHolderDeselectGray,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
