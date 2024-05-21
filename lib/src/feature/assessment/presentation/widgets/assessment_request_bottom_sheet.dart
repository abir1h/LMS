import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../services/assessment_request_bottomsheet_screen_service.dart';

class AssessmentRequestBottomSheet extends StatefulWidget {
  final int circularAssessmentId;
  final VoidCallback onSuccess;
  const AssessmentRequestBottomSheet(
      {super.key, required this.circularAssessmentId, required this.onSuccess});

  @override
  State<AssessmentRequestBottomSheet> createState() =>
      _AssessmentRequestBottomSheetState();
}

class _AssessmentRequestBottomSheetState
    extends State<AssessmentRequestBottomSheet>
    with AppTheme, Language, AssessmentRequestBottomSheetScreenService {
  TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    remarksController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    remarksController.dispose();
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
                  TextField(
                    controller: remarksController,
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
                    title: label(
                        e: en.publishTheDiscussion, b: bn.publishTheDiscussion),
                    textSize: size.textSmall,
                    radius: size.w10,
                    buttonColor: remarksController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                    onSuccess: (e) {
                      widget.onSuccess();
                    },
                    onCheck: () => validateFormData(remarksController),
                    tapAction: () => onRequestExam(
                        circularAssessmentId: widget.circularAssessmentId,
                        remarks: remarksController.text.trim()),
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
