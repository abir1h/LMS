import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<AssignmentController>(builder: (_) {
                    return QuilTextViewer(
                      controller: _controller,
                    );
                  }),
                  SizedBox(height: size.h20 * 5),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.w16),
                padding: EdgeInsets.only(
                    left: size.w12,
                    right: size.w12,
                    top: size.h24,
                    bottom: size.h16),
                decoration: BoxDecoration(
                    color: clr.shadeWhiteColor2,
                    border: Border(
                        top: BorderSide(
                            color: clr.boxStrokeColor, width: size.w1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: FilledButton(
                            onPressed: () {
                              CustomToasty.of(context)
                                  .showSuccess("সফলভাবে  জমাদান সম্পন্ন হয়েছে");
                              Get.off(() => const CourseAssignmentScreen());
                            },
                            style: FilledButton.styleFrom(
                              side: BorderSide(
                                  color: clr.appPrimaryColorGreen,
                                  width: size.r1),
                              backgroundColor: clr.scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(size.r4),
                              ),
                            ),
                            child: Text(
                              label(e: en.submit, b: bn.submit),
                              style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textSmall,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: StringData.fontFamilyPoppins),
                              textAlign: TextAlign.center,
                            ))),
                    SizedBox(width: size.w16),
                    Expanded(
                      child: FilledButton(
                          onPressed: () {
                            CustomToasty.of(context)
                                .showSuccess("সফলভাবে সংরক্ষণ সম্পন্ন হয়েছে ");
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(size.r4),
                            ),
                          ),
                          child: Text(
                            label(e: en.saveAsDraft, b: bn.saveAsDraft),
                            style: TextStyle(
                                color: clr.whiteColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w600,
                                fontFamily: StringData.fontFamilyPoppins),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void onTapWriteHere(String screenName) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          AssignmentBottomSheet(from: screenName, mainModel: widget.mainModel),
    );
  }
}
