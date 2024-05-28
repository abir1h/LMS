import 'package:flutter/material.dart';

import '../services/assignment_screen_service.dart';
import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AssignmentRequestBottomSheet extends StatefulWidget {
  final int circularId;
  final int courseId;
  final int circularAssignmentId;
  final int courseModuleId;
  final VoidCallback onSuccess;
  const AssignmentRequestBottomSheet({
    super.key,
    required this.circularId,
    required this.courseId,
    required this.circularAssignmentId,
    required this.courseModuleId,
    required this.onSuccess,
  });

  @override
  State<AssignmentRequestBottomSheet> createState() =>
      _AssignmentRequestBottomSheetState();
}

class _AssignmentRequestBottomSheetState
    extends State<AssignmentRequestBottomSheet>
    with AppTheme, Language, AssignmentScreenService {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // titleController.addListener(() {
    //   setState(() {});
    // });
    messageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
                  /*AppTextField(
                      hintText:
                          label(e: en.discussionTitle, b: bn.discussionTitle),
                      controller: titleController,
                    ),
                    SizedBox(height: size.h8),*/
                  TextField(
                    controller: messageController,
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
                  CustomActionButton(
                    title: label(e: "Send Request", b: 'অনুরোধ পাঠান'),
                    textSize: size.textSmall,
                    radius: size.w10,
                    buttonColor: messageController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                    onSuccess: (e) {
                      widget.onSuccess();
                    },
                    onCheck: () => validateFormData(messageController),
                    tapAction: () => requestAssignment(
                        widget.circularId,
                        widget.courseId,
                        widget.circularAssignmentId,
                        widget.courseModuleId,
                        messageController.text.trim()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
