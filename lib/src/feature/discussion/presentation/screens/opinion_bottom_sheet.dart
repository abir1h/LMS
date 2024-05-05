import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../controller/discussion_controller.dart';
import '../services/opinion_bottomsheet_screen_service.dart';

class OpinionBottomSheet extends StatefulWidget {
  final int discussionId;
  final VoidCallback onSuccess;
  const OpinionBottomSheet({
    super.key,
    required this.discussionId,
    required this.onSuccess,
  });

  @override
  State<OpinionBottomSheet> createState() => _OpinionBottomSheetState();
}

class _OpinionBottomSheetState extends State<OpinionBottomSheet>
    with AppTheme, Language, OpinionBottomSheetScreenService {
  TextEditingController titleController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final controller = Get.put(DiscussionController());

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
            child: Row(
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
                          label(e: en.writeYourOpinion, b: bn.writeYourOpinion),
                      controller: titleController,
                      onTaped: () {}),
                ),
                SizedBox(width: size.w4),
                InkWell(
                  onTap: () => onCommentCreate(
                      discussionId: widget.discussionId,
                      description: titleController.text.trim()),
                  child: Icon(
                    Icons.send,
                    size: size.r28,
                    color: titleController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                  ),
                ),
              ],
            ),
            /*child: Column(
              children: [
                Row(
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
                            offset: const Offset(
                                0, 5), // changes position of shadow
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
                          hintText: label(
                              e: en.writeYourOpinion, b: bn.writeYourOpinion),
                          controller: titleController,
                          onTaped: () {}),
                    ),
                  ],
                ),
                SizedBox(height: size.h4),
                CustomActionButton(
                  title: label(
                      e: en.publishTheDiscussion, b: bn.publishTheDiscussion),
                  textSize: size.textSmall,
                  radius: size.w10,
                  buttonColor: titleController.text.isNotEmpty
                      ? clr.appPrimaryColorGreen
                      : clr.placeHolderDeselectGray,
                  onSuccess: (e) {
                    widget.onSuccess();
                  },
                  tapAction: () => onCommentCreate(
                      discussionId: widget.discussionId,
                      description: titleController.text.trim()),
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
