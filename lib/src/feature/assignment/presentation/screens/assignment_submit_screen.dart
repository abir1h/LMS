import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';
import '../models/assignment_model.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../course/presentation/screens/course_assignment_screen.dart';
import '../widgets/assignment_bottom_sheet.dart';

class AssignmentSubmitScreen extends StatefulWidget {
  final AssignmentModel? mainModel;
  const AssignmentSubmitScreen({super.key, this.mainModel});

  @override
  State<AssignmentSubmitScreen> createState() => _AssignmentSubmitScreenState();
}

class _AssignmentSubmitScreenState extends State<AssignmentSubmitScreen>
    with AppTheme, Language {
  final controller = Get.put(AssignmentController());
  final _controller = QuillController.basic();

  String data = '';
  @override
  void initState() {
    setContent();
    super.initState();
  }

  setContent() {
    if (widget.mainModel != null) {
      if (widget.mainModel!.content != null) {
        _controller.document = widget.mainModel!.content!;
        data = widget.mainModel!.content!.toPlainText();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "",
        actionChild: InkWell(
            onTap: () => onTapWriteHere("submit"),
            child: Icon(Icons.edit,
                size: size.r24, color: clr.appPrimaryColorGreen)),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
            child: GetBuilder<AssignmentController>(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuilTextViewer(
                    controller: _controller,
                  ),
                  SizedBox(height: size.h56),
                  Divider(color: clr.boxStrokeColor),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w16, vertical: size.h24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              Get.off(() => const CourseAssignmentScreen());
                            },
                            title: label(e: en.submit, b: bn.submit),
                            radius: size.r4,
                            verticalPadding: size.h4,
                            bgColor: clr.scaffoldBackgroundColor,
                            textColor: clr.appPrimaryColorGreen,
                            borderColor: clr.appPrimaryColorGreen,
                          ),
                        ),
                        SizedBox(width: size.w16),
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              CustomToasty.of(context).showSuccess(
                                  "সফলভাবে সংরক্ষণ সম্পন্ন হয়েছে ");
                            },
                            title: label(e: en.saveAsDraft, b: bn.saveAsDraft),
                            radius: size.r4,
                            verticalPadding: size.h4,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            })));
  }

  void onTapWriteHere(String screenName) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          AssignmentBottomSheet(from: screenName, mainModel: widget.mainModel),
    );
  }
}
