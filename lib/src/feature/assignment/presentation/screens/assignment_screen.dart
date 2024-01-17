import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/routes/app_route.dart';
import '../controllers/assignment_controller.dart';
import '../widgets/assignment_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/custom_file_picker.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with AppTheme, Language, ImagePreviewDialog {
  final controller = Get.put(AssignmentController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "",
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(e: en.assignmentInstruction, b: bn.assignmentInstruction),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h16),
              GestureDetector(
                  onTap: () {
                    ImagePreviewDialog.showImagePreview(
                        context, ImageAssets.imgAssignment);
                  },
                  child: Center(child: Image.asset(ImageAssets.imgAssignment))),
              SizedBox(height: size.h20),
              Text(
                label(
                    e: en.answerTheFollowingQuestions,
                    b: bn.answerTheFollowingQuestions),
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Text(
                label(
                    e: "1. What are the foundations of teaching programs for learning?",
                    b: "১. শেখার জন্য শিক্ষাদান প্রোগ্রামের ফাউন্ডেশনস কি?"),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              GetBuilder<AssignmentController>(builder: (_) {
                return GestureDetector(
                  onTap: () => onTapWriteHere("assignmentScreen"),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: size.w16,
                        right: size.w16,
                        top: size.h12,
                        bottom: size.h44),
                    decoration: BoxDecoration(
                      color: clr.whiteColor,
                      borderRadius: BorderRadius.circular(size.r8),
                      border:
                          Border.all(color: clr.boxStrokeColor, width: size.w1),
                    ),
                    child: Text(
                      controller.data != ''
                          ? controller.data
                          : label(e: en.writeHere, b: bn.writeHere),
                      style: TextStyle(
                          color: controller.data == ''
                              ? clr.placeHolderTextColorGray
                              : clr.textColorAppleBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.h12),
                child: Center(
                  child: Text(
                    label(e: en.or, b: bn.or),
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
              ),
              Text(
                label(e: en.uploadTheFile, b: bn.uploadTheFile),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Obx(
                () => CustomFilePicker(
                  onFilePicked: (filePath) {
                    print('Selected file: $filePath');
                    controller.filename.value = filePath.toString();

                    // Handle the selected file path as needed
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.w16, vertical: size.h12),
                    decoration: BoxDecoration(
                      color: clr.whiteColor,
                      borderRadius: BorderRadius.circular(size.r8),
                      border:
                          Border.all(color: clr.boxStrokeColor, width: size.w1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.getShortenedFileName(
                                controller.filename.value),
                            style: TextStyle(
                                color: clr.appPrimaryColorGreen,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.bold,
                                fontFamily: StringData.fontFamilyPoppins),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (controller.filename.value != '')
                          InkWell(
                              onTap: () {
                                controller.filename.value = '';
                                controller.isUpload.value = false;
                              },
                              child: Icon(
                                Icons.close,
                                color: clr.appPrimaryColorGreen,
                                size: size.r24,
                              )),
                        Icon(
                          Icons.attach_file,
                          color: clr.iconColorHint,
                          size: size.r24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                return controller.isUpload.isFalse
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: size.h20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onTap: () {
                                if (controller.filename.value != '') {
                                  controller.isUpload.value = true;
                                }
                              },
                              title: label(e: en.upload, b: bn.upload),
                              bgColor: controller.filename.value == ''
                                  ? clr.greyColor
                                  : clr.appPrimaryColorGreen,
                              borderColor: Colors.transparent,
                              radius: size.r8,
                              verticalPadding: size.h4,
                            )
                          ],
                        ),
                      )
                    : const Wrap();
              }),
              Obx(() {
                return controller.isUpload.isTrue
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w16, vertical: size.h48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                onTap: () {
                                  CustomToasty.of(context).showSuccess(
                                      "সফলভাবে  জমাদান সম্পন্ন হয়েছে");
                                  Navigator.of(context).pushNamed(
                                      AppRoute.courseAssignmentScreen);
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
                                      "সফলভাবে সংরক্ষণ সম্পন্ন হয়েছে");
                                },
                                title:
                                    label(e: en.saveAsDraft, b: bn.saveAsDraft),
                                radius: size.r4,
                                verticalPadding: size.h4,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Wrap();
              })
            ],
          ),
        ));
  }

  void onTapWriteHere(String screenName) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AssignmentBottomSheet(from: screenName),
    );
  }
}
