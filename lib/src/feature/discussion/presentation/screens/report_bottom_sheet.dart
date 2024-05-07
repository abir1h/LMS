import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../services/report_bottomsheet_screen_service.dart';

class ReportBottomSheet extends StatefulWidget {
  final int commentId;
  final VoidCallback onSuccess;
  const ReportBottomSheet({
    super.key,
    required this.commentId,
    required this.onSuccess,
  });

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet>
    with AppTheme, Language, ReportBottomSheetScreenService {
  TextEditingController titleController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: label(e: en.writeYourReport, b: bn.writeYourReport),
                    textColor: clr.blackColor,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: size.h8),
                  TextField(
                    controller: titleController,
                    minLines: 5,
                    maxLines: 5,
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
                            BorderRadius.all(Radius.circular(size.r4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: clr.boxStrokeColor, width: size.w1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.r4))),
                    ),
                  ),
                  SizedBox(height: size.h16),
                  CustomActionButton(
                    title: label(e: en.report, b: bn.report),
                    textSize: size.textSmall,
                    radius: size.r4,
                    buttonColor: titleController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                    onSuccess: (e) {
                      widget.onSuccess();
                    },
                    onCheck: () => validateFormData(titleController),
                    tapAction: () => onReportComment(
                        commentId: widget.commentId,
                        remarks: titleController.text.trim()),
                  ),
                ],
              ),
            ),
            /*child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(size.r10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: clr.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    ImageAssets.icEditSquare,
                  ),
                ),
                SizedBox(width: size.w8),
                Expanded(
                  child: AppTextField(
                      hintText:
                          label(e: en.writeYourReport, b: bn.writeYourReport),
                      controller: titleController,
                      onTaped: () {}),
                ),
                SizedBox(width: size.w4),
                InkWell(
                  onTap: () => onReportComment(
                      commentId: widget.commentId,
                      remarks: titleController.text.trim()),
                  child: Icon(
                    Icons.send,
                    size: size.r28,
                    color: titleController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                  ),
                ),
              ],
            ),*/
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

  @override
  void onSuccessRequest() {
    widget.onSuccess();
  }
}
