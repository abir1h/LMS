import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../controllers/assignment_controller.dart';
import '../widgets/assignment_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/custom_file_picker.dart';

class AssignmentScreen extends StatefulWidget {
  final Object? arguments;
  const AssignmentScreen({super.key, this.arguments});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with AppTheme, Language, ImagePreviewDialog {
  final controller = Get.put(AssignmentController());

  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentArgs;
  }

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
              if (_screenArgs.assignmentDataEntity.supportingDoc.isNotEmpty)
                CustomTextWidget(
                  text: label(
                      e: en.assignmentInstruction, b: bn.assignmentInstruction),
                  textColor: clr.blackColor,
                  fontFamily: StringData.fontFamilyPoppins,
                  padding: EdgeInsets.only(bottom: size.h16),
                ),
              if (_screenArgs.assignmentDataEntity.supportingDoc.isNotEmpty)
                _screenArgs.assignmentDataEntity.supportingDoc
                            .split(".")
                            .last ==
                        ".pdf"
                    ? Padding(
                        padding: EdgeInsets.only(bottom: size.h20),
                        child: SupportingDocWidget(
                          docTitle: _screenArgs
                              .assignmentDataEntity.supportingDoc
                              .split("/")[1],
                          onTap: () {},
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: size.h20),
                        child: GestureDetector(
                            onTap: () {
                              ImagePreviewDialog.showImagePreview(
                                  context,
                                  _screenArgs
                                      .assignmentDataEntity.supportingDoc);
                            },
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: _screenArgs
                                    .assignmentDataEntity.supportingDoc,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )),
                      ),
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
                    e: _screenArgs.assignmentDataEntity.descriptionEn,
                    b: _screenArgs.assignmentDataEntity.descriptionBn),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              if (_screenArgs.assignmentDataEntity.submissionType ==
                      "written" ||
                  _screenArgs.assignmentDataEntity.submissionType == "both")
                GetBuilder<AssignmentController>(builder: (_) {
                  return GestureDetector(
                    onTap: () => onTapWriteHere(
                        "assignmentScreen", _screenArgs.assignmentDataEntity),
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
                        border: Border.all(
                            color: clr.boxStrokeColor, width: size.w1),
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
              if (_screenArgs.assignmentDataEntity.submissionType == "both")
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
              if (_screenArgs.assignmentDataEntity.submissionType == "upload" ||
                  _screenArgs.assignmentDataEntity.submissionType == "both")
                Text(
                  label(e: en.uploadTheFile, b: bn.uploadTheFile),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              if (_screenArgs.assignmentDataEntity.submissionType == "upload" ||
                  _screenArgs.assignmentDataEntity.submissionType == "both")
                Padding(
                  padding: EdgeInsets.only(top: size.h12),
                  child: Obx(
                    () => CustomFilePicker(
                      onFilePicked: (filePath) {
                        print('Selected file: $filePath');
                        // controller.filename.value = filePath.toString();

                        // Handle the selected file path as needed
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w16, vertical: size.h12),
                        decoration: BoxDecoration(
                          color: clr.whiteColor,
                          borderRadius: BorderRadius.circular(size.r8),
                          border: Border.all(
                              color: clr.boxStrokeColor, width: size.w1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                getShortenedFileName(controller.filename.value),
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
                ),

              ///Upload
              if (_screenArgs.assignmentDataEntity.submissionType == "upload" ||
                  _screenArgs.assignmentDataEntity.submissionType == "both")
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

              ///Upload
              // Obx(() {
              //   return controller.isUpload.isTrue
              //       ? Padding(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: size.w16, vertical: size.h48),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Expanded(
              //                 child: CustomButton(
              //                   onTap: () {
              //                     CustomToasty.of(context).showSuccess(
              //                         "সফলভাবে  জমাদান সম্পন্ন হয়েছে");
              //                     Navigator.of(context).pushNamed(
              //                         AppRoute.courseAssignmentScreen);
              //                   },
              //                   title: label(e: en.submit, b: bn.submit),
              //                   radius: size.r4,
              //                   verticalPadding: size.h4,
              //                   bgColor: clr.scaffoldBackgroundColor,
              //                   textColor: clr.appPrimaryColorGreen,
              //                   borderColor: clr.appPrimaryColorGreen,
              //                 ),
              //               ),
              //               SizedBox(width: size.w16),
              //               Expanded(
              //                 child: CustomButton(
              //                   onTap: () {
              //                     CustomToasty.of(context).showSuccess(
              //                         "সফলভাবে সংরক্ষণ সম্পন্ন হয়েছে");
              //                   },
              //                   title:
              //                       label(e: en.saveAsDraft, b: bn.saveAsDraft),
              //                   radius: size.r4,
              //                   verticalPadding: size.h4,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       : const Wrap();
              // })
            ],
          ),
        ));
  }

  void onTapWriteHere(
      String screenName, AssignmentDataEntity assignmentDataEntity) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AssignmentBottomSheet(
        from: screenName,
        assignmentDataEntity: assignmentDataEntity,
      ),
    );
  }

  getShortenedFileName(String filePath) {
    // Set the maximum length for the displayed file name
    const int maxFileNameLength = 20;

    String fileName = filePath.split('/').last; // Extract the file name
    return fileName.length > maxFileNameLength
        ? '${fileName.substring(0, maxFileNameLength)}...'
        : fileName;
  }
}

class SupportingDocWidget<T> extends StatelessWidget with AppTheme, Language {
  final String docTitle;
  final VoidCallback onTap;
  const SupportingDocWidget(
      {Key? key, required this.docTitle, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          borderRadius: BorderRadius.circular(size.r4),
          border: Border.all(color: clr.cardStrokeColorGrey2)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h4),
      child: Row(
        children: [
          Image.asset(ImageAssets.imgPdf),
          SizedBox(width: size.w8),
          Expanded(
            child: CustomTextWidget(
              text: docTitle,
              textColor: clr.textColorBlack,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(width: size.w4),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.file_download_outlined,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
          )
        ],
      ),
    );
  }
}
