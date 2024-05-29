import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/enums/enums.dart';
import 'assignement_request_bottomsheet.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/entities/assignment_submission_data_entity.dart';
import '../controllers/assignment_controller.dart';
import '../services/assignment_screen_service.dart';
import '../widgets/assignment_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AssignmentScreen extends StatefulWidget {
  final Object? arguments;
  const AssignmentScreen({super.key, this.arguments});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with AppTheme, Language, ImagePreviewDialog, AssignmentScreenService {
  final controller = Get.put(AssignmentController());

  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAssignmentData(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: AppStreamBuilder<AssignmentDataEntity>(
        stream: assignmentDetailsDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.supportingDoc.isNotEmpty)
                  CustomTextWidget(
                    text: label(
                        e: en.assignmentInstruction,
                        b: bn.assignmentInstruction),
                    textColor: clr.blackColor,
                    fontFamily: StringData.fontFamilyPoppins,
                    padding: EdgeInsets.only(bottom: size.h16),
                  ),
                if (data.supportingDoc.isNotEmpty)
                  data.supportingDoc.split(".").last == "pdf"
                      ? Padding(
                          padding: EdgeInsets.only(bottom: size.h20),
                          child: SupportingDocWidget(
                            docTitle: data.supportingDoc.split("/").last,
                            onTap: () {
                              downloadFiles(
                                  fileUrl: data.supportingDoc,
                                  filename: data.supportingDoc.split("/").last,
                                  context: context);
                            },
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: size.h20),
                          child: GestureDetector(
                              onTap: () {
                                ImagePreviewDialog.showImagePreview(
                                    context,
                                    ApiCredential.mediaBaseUrl +
                                        data.supportingDoc);
                              },
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: ApiCredential.mediaBaseUrl +
                                      data.supportingDoc,
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
                  label(e: data.descriptionEn, b: data.descriptionBn),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),

                SizedBox(height: size.h12),

                if (data.type == AssignmentType.individual.name)
                  if (data.assignmentSubmissions != null &&
                      data.submissionType == AssignmentSubType.written.name)
                    Padding(
                      padding: EdgeInsets.only(bottom: size.h12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextWidget(
                              text: label(
                                  e: "Assignment submission completed",
                                  b: "অ্যাসাইনমেন্ট জমাদান সম্পন্ন হয়েছে"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: size.w8),
                          if (data.submissionType ==
                                  AssignmentSubType.written.name &&
                              data.assignmentSubmissions!
                                      .assignmentResultDataEntity ==
                                  null)
                            GestureDetector(
                              onTap: () => onTapWriteHere("update", data),
                              child: Container(
                                padding: EdgeInsets.all(size.w2),
                                decoration: BoxDecoration(
                                  color: clr.whiteColor,
                                  borderRadius: BorderRadius.circular(size.r4),
                                  border: Border.all(
                                      color: clr.cardStrokeColor,
                                      width: size.r1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: clr.blackColor.withOpacity(.2),
                                      blurRadius: size.r4,
                                      offset: Offset(0.0, size.h2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.border_color_outlined,
                                  color: clr.appPrimaryColorGreen,
                                  size: size.r20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                if (data.type == AssignmentType.group.name)
                  if (data.circularSubAssignments?.assignmentSubmissions !=
                          null &&
                      data.submissionType == AssignmentSubType.written.name)
                    Padding(
                      padding: EdgeInsets.only(bottom: size.h12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextWidget(
                              text: label(
                                  e: "Assignment submission completed",
                                  b: "অ্যাসাইনমেন্ট জমাদান সম্পন্ন হয়েছে"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: size.w8),
                          if (data.submissionType ==
                                  AssignmentSubType.written.name &&
                              data
                                      .circularSubAssignments!
                                      .assignmentSubmissions!
                                      .assignmentResultDataEntity ==
                                  null &&
                              data.allowed)
                            GestureDetector(
                              onTap: () => onTapWriteHere("update", data),
                              child: Container(
                                padding: EdgeInsets.all(size.w2),
                                decoration: BoxDecoration(
                                  color: clr.whiteColor,
                                  borderRadius: BorderRadius.circular(size.r4),
                                  border: Border.all(
                                      color: clr.cardStrokeColor,
                                      width: size.r1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: clr.blackColor.withOpacity(.2),
                                      blurRadius: size.r4,
                                      offset: Offset(0.0, size.h2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.border_color_outlined,
                                  color: clr.appPrimaryColorGreen,
                                  size: size.r20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                ///Written
                if (data.submissionType == AssignmentSubType.written.name ||
                    data.submissionType == AssignmentSubType.both.name)
                  WrittenAnswerWidget(
                    answer: data.type == AssignmentType.individual.name
                        ? (data.assignmentSubmissions != null
                            ? data.assignmentSubmissions!.answer
                            : "")
                        : data.type == AssignmentType.group.name
                            ? (data.circularSubAssignments!
                                        .assignmentSubmissions !=
                                    null
                                ? data.circularSubAssignments!
                                    .assignmentSubmissions!.answer
                                : "")
                            : "",

                    ///Need to work after Complete collaborative Api
                    onTap: () {
                      if (data.assignmentSubmissions == null ||
                          data.circularSubAssignments?.assignmentSubmissions ==
                              null) {
                        onTapWriteHere("store", data);
                      }
                    },
                  ),
                if (data.type == AssignmentType.individual.name)
                  if (data.assignmentSubmissions != null &&
                      data.submissionType == AssignmentSubType.written.name &&
                      data.assignmentSubmissions?.assignmentResultDataEntity ==
                          null)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: size.h12),
                      decoration: BoxDecoration(
                        color: clr.cardFillColorMintCream,
                        borderRadius: BorderRadius.circular(size.r8),
                        border: Border.all(
                            color: clr.cardStrokeColor, width: size.w1),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: clr.blackColor.withOpacity(.2))
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w12, vertical: size.h8),
                      child: CustomTextWidget(
                        text:
                            // data.assignmentSubmissions!
                            //             .assignmentResultDataEntity ==
                            //         null
                            //     ?
                            label(
                                e: "Your assignment has been submitted, please wait for review Review You can edit it before the review",
                                b: "আপনার এসাইনমেন্ট সাবমিট করা হয়েছে, দয়া করে রিভিউ এর জন্য অপেক্ষা করুন| রিভিউ এর পূর্ব  পর্যন্ত আপনি এটি এডিট করতে পারবেন"),
                        // : label(
                        //     e: "Your assignment is in review",
                        //     b: "আপনার এসাইনমেন্ট রিভিউতে রয়েছে"),
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                if (data.type == AssignmentType.group.name)
                  if (data.circularSubAssignments?.assignmentSubmissions !=
                          null &&
                      data.submissionType == AssignmentSubType.written.name &&
                      data.circularSubAssignments!.assignmentSubmissions
                              ?.assignmentResultDataEntity ==
                          null)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: size.h12),
                      decoration: BoxDecoration(
                        color: clr.cardFillColorMintCream,
                        borderRadius: BorderRadius.circular(size.r8),
                        border: Border.all(
                            color: clr.cardStrokeColor, width: size.w1),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: clr.blackColor.withOpacity(.2))
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.w12, vertical: size.h8),
                      child: CustomTextWidget(
                        text: label(
                            e: "Your assignment has been submitted, please wait for review Review You can edit it before the review",
                            b: "আপনার এসাইনমেন্ট সাবমিট করা হয়েছে, দয়া করে রিভিউ এর জন্য অপেক্ষা করুন| রিভিউ এর পূর্ব  পর্যন্ত আপনি এটি এডিট করতে পারবেন"),
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                if (data.submissionType == AssignmentSubType.both.name)
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

                ///File Upload
                if ((data.submissionType == AssignmentSubType.upload.name ||
                        data.submissionType == AssignmentSubType.both.name) &&
                    data.allowed)
                  Text(
                    label(e: en.uploadTheFile, b: bn.uploadTheFile),
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                if ((data.submissionType == AssignmentSubType.upload.name ||
                        data.submissionType == AssignmentSubType.both.name) &&
                    data.allowed)
                  Padding(
                    padding: EdgeInsets.only(top: size.h12),
                    child: FilePickerWidget(
                        items: files!,
                        builder: (BuildContext context, int index, item) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  files![index].path.split('/').last,
                                  style: TextStyle(
                                      color: clr.appPrimaryColorGreen,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: StringData.fontFamilyPoppins),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (files!.isNotEmpty)
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        files!.removeWhere((element) =>
                                            element == files![index]);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: clr.appPrimaryColorGreen,
                                      size: size.r24,
                                    )),
                            ],
                          );
                        },
                        onPick: pickFiles),
                  ),

                ///Submit
                if ((data.submissionType == AssignmentSubType.upload.name ||
                        data.submissionType == AssignmentSubType.both.name) &&
                    (data.assignmentSubmissions == null &&
                        data.circularSubAssignments?.assignmentSubmissions ==
                            null))
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.h20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onTap: () {
                            onStoreAssignment(
                                    assignmentId: data.id,
                                    subAssignmentId:
                                        data.circularSubAssignments != null
                                            ? data.circularSubAssignments!.id
                                            : -1,
                                    courseId: data.courseId,
                                    circularId: data.circularId,
                                    answer: '',
                                    files: files!)
                                .then((value) {
                              contentReadPost(data.id, data.courseId, true);
                              loadAssignmentData(_screenArgs.courseContentId);
                            });
                          },
                          title: label(e: en.upload, b: bn.upload),
                          bgColor: files!.isEmpty
                              ? clr.greyColor
                              : clr.appPrimaryColorGreen,
                          borderColor: Colors.transparent,
                          radius: size.r8,
                          verticalPadding: size.h4,
                        )
                      ],
                    ),
                  ),

                ///Re-Submit
                if ((data.submissionType == AssignmentSubType.upload.name ||
                        data.submissionType == AssignmentSubType.both.name) &&
                    (data.assignmentSubmissions != null ||
                        data.circularSubAssignments?.assignmentSubmissions !=
                            null) &&
                    (data.assignmentSubmissions?.assignmentResultDataEntity ==
                        null) &&
                    data.allowed)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.h20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onTap: () {
                            onUpdateAssignment(
                                    submissionId: data.type ==
                                            AssignmentType.individual.name
                                        ? data.assignmentSubmissions!.id
                                        : data.circularSubAssignments!
                                            .assignmentSubmissions!.id,
                                    assignmentId: data.id,
                                    subAssignmentId:
                                        data.circularSubAssignments != null
                                            ? data.circularSubAssignments!.id
                                            : -1,
                                    courseId: data.courseId,
                                    circularId: data.circularId,
                                    answer: '',
                                    files: files!)
                                .then((value) => loadAssignmentData(
                                    _screenArgs.courseContentId));
                          },
                          title: label(e: "Re-Submit", b: "Re-Submit"),
                          bgColor: files!.isEmpty
                              ? clr.greyColor
                              : clr.appPrimaryColorGreen,
                          borderColor: Colors.transparent,
                          radius: size.r8,
                          verticalPadding: size.h4,
                        ),
                      ],
                    ),
                  ),

                ///Submission Complete Message for upload
                if ((data.assignmentSubmissions != null ||
                        data.circularSubAssignments?.assignmentSubmissions !=
                            null) &&
                    data.submissionType == AssignmentSubType.upload.name)
                  SubmissionCompletedWidget(
                      data: data.type == AssignmentType.individual.name
                          ? data.assignmentSubmissions!
                          : data
                              .circularSubAssignments!.assignmentSubmissions!),

                ///Assignment Result for Individual
                if (data.type == AssignmentType.individual.name)
                  if (data.assignmentSubmissions != null &&
                      data.assignmentSubmissions!.assignmentResultDataEntity !=
                          null)
                    AssignmentReviewWidget(
                      data: data,
                      onTapRequest: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => AssignmentRequestBottomSheet(
                            circularAssignmentId: data.id,
                            circularId: data.circularId,
                            courseId: data.courseId,
                            courseModuleId: data.courseModuleId,
                            onSuccess: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),

                ///Assignment Result for Group
                if (data.type == AssignmentType.group.name)
                  if (data.circularSubAssignments?.assignmentSubmissions !=
                          null &&
                      data.circularSubAssignments!.assignmentSubmissions!
                              .assignmentResultDataEntity !=
                          null)
                    AssignmentReviewWidget(
                      data: data,
                      onTapRequest: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => AssignmentRequestBottomSheet(
                            circularAssignmentId: data.id,
                            circularId: data.circularId,
                            courseId: data.courseId,
                            courseModuleId: data.courseModuleId,
                            onSuccess: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),

                ///Instructor Comment for Individual
                if (data.assignmentSubmissions != null &&
                    data.assignmentSubmissions!.assignmentResultDataEntity !=
                        null)
                  InstructorCommentWidget(
                      remarks: data.assignmentSubmissions!.remarks),

                ///Instructor Comment for Group
                if (data.circularSubAssignments?.assignmentSubmissions !=
                        null &&
                    data.circularSubAssignments!.assignmentSubmissions!
                            .assignmentResultDataEntity !=
                        null)
                  InstructorCommentWidget(
                      remarks: data.circularSubAssignments!
                          .assignmentSubmissions!.remarks),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title: label(
              e: 'No Assignment Found', b: 'কোন অ্যাসাইনমেন্ট পাওয়া যায়নি'),
          // constraints: constraints,
          // offset: 350.w,
        ),
      ),
    );
  }

  void onTapWriteHere(String type, AssignmentDataEntity assignmentDataEntity) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AssignmentBottomSheet(
        type: type,
        assignmentDataEntity: assignmentDataEntity,
        answer: assignmentDataEntity.type == AssignmentType.individual.name
            ? assignmentDataEntity.assignmentSubmissions?.answer
            : assignmentDataEntity
                .circularSubAssignments!.assignmentSubmissions?.answer,
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

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Icon(
              Icons.file_download_outlined,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            )
          ],
        ),
      ),
    );
  }
}

class WrittenAnswerWidget extends StatefulWidget {
  final String answer;
  final VoidCallback onTap;
  const WrittenAnswerWidget(
      {super.key, required this.answer, required this.onTap});

  @override
  State<WrittenAnswerWidget> createState() => _WrittenAnswerWidgetState();
}

class _WrittenAnswerWidgetState extends State<WrittenAnswerWidget>
    with AppTheme, Language {
  final _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    setContent();
  }

  setContent() {
    if (widget.answer.isNotEmpty) {
      if (widget.answer.contains("{")) {
        final Document doc = Document.fromJson(json.decode(widget.answer));
        _controller.document = doc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        ),
        child: widget.answer.isEmpty
            ? Text(
                label(e: en.writeHere, b: bn.writeHere),
                style: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    // : clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              )
            : QuilTextViewer(
                controller: _controller,
                hintText: label(e: en.writeHere, b: bn.writeHere),
              ),
      ),
    );
  }
}

class FilePickerWidget<T> extends StatelessWidget with AppTheme, Language {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  final VoidCallback onPick;
  const FilePickerWidget(
      {super.key,
      required this.items,
      required this.builder,
      required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items.isEmpty
              ? Expanded(
                  child: CustomTextWidget(
                    text: label(
                        e: "Upload Your File Here",
                        b: "আপনার ফাইলটি এখানে আপলোড করুন"),
                    textColor: clr.textColorGray,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        builder(context, index, items[index]),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.h4);
                    },
                  ),
                ),
          GestureDetector(
            onTap: onPick,
            child: Icon(
              Icons.attach_file,
              color: clr.iconColorHint,
              size: size.r24,
            ),
          ),
        ],
      ),
    );
  }
}

class SubmissionCompletedWidget extends StatelessWidget
    with AppTheme, Language {
  final AssignmentSubmissionDataEntity data;
  const SubmissionCompletedWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextWidget(
                  text: label(e: "Submission Completed", b: "জমাদান সম্পন্ন"),
                  textColor: clr.textColorBlack,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: size.w10),
              if (data.attachments.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(size.r1),
                  decoration: BoxDecoration(
                    color: clr.whiteColor,
                    borderRadius: BorderRadius.circular(size.r4),
                    border:
                        Border.all(color: clr.cardStrokeColor, width: size.r1),
                    boxShadow: [
                      BoxShadow(
                        color: clr.blackColor.withOpacity(.2),
                        blurRadius: size.r4,
                        offset: Offset(0.0, size.h2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      downloadFiles(
                          fileUrl: data.attachments.first.file,
                          filename: data.attachments.first.file.split("/").last,
                          context: context);
                    },
                    child: Icon(
                      Icons.save_alt,
                      color: clr.appPrimaryColorGreen,
                      size: size.r20,
                    ),
                  ),
                ),
              // SizedBox(width: size.w8),
              // Container(
              //   padding: EdgeInsets.all(size.r1),
              //   decoration: BoxDecoration(
              //     color: clr.whiteColor,
              //     borderRadius: BorderRadius.circular(size.r4),
              //     border:
              //         Border.all(color: clr.cardStrokeColor, width: size.r1),
              //     boxShadow: [
              //       BoxShadow(
              //         color: clr.blackColor.withOpacity(.2),
              //         blurRadius: size.r4,
              //         offset: Offset(0.0, size.h2),
              //       ),
              //     ],
              //   ),
              //   child: Icon(
              //     Icons.border_color_outlined,
              //     color: clr.appPrimaryColorGreen,
              //     size: size.r20,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: size.h12),
          CustomTextWidget(
            text: data.attachments.map((c) => c.file).toList().join(', '),
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w500,
          ),
          if (data.assignmentResultDataEntity == null)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: clr.cardFillColorMintCream,
                borderRadius: BorderRadius.circular(size.r8),
                border: Border.all(color: clr.cardStrokeColor, width: size.w1),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: clr.blackColor.withOpacity(.2))
                ],
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h8),
              margin: EdgeInsets.only(top: size.h12),
              child: CustomTextWidget(
                text: label(
                    e: "Your assignment has been submitted, please wait for review Review You can edit it before the review",
                    b: "আপনার এসাইনমেন্ট সাবমিট করা হয়েছে, দয়া করে রিভিউ এর জন্য অপেক্ষা করুন| রিভিউ রিভিউ এর পূর্ব  পর্যন্ত আপনি এটি এডিট করতে পারবেন"),
                fontSize: size.textXXSmall,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class AssignmentReviewWidget extends StatelessWidget with AppTheme, Language {
  final AssignmentDataEntity data;
  final VoidCallback onTapRequest;
  const AssignmentReviewWidget(
      {super.key, required this.data, required this.onTapRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      margin: EdgeInsets.only(top: size.h16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.assignment,
              size: size.r16 * 2,
              color: clr.appPrimaryColorGreen,
            ),
          ),
          if (data.type == AssignmentType.individual.name)
            if (data.passMark > data.assignmentSubmissions!.marks)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor2,
                  borderRadius: BorderRadius.circular(size.r8),
                  border:
                      Border.all(color: clr.cardStrokeColor, width: size.w1),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: clr.blackColor.withOpacity(.2))
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h12),
                margin: EdgeInsets.only(top: size.h16),
                child: CustomTextWidget(
                  text: label(
                      e: "Sorry, you failed to complete the assignment, please try again",
                      b: "দুঃখিত, অ্যাসাইনমেন্ট টি সম্পন্ন করতে আপনি ব্যার্থ হয়েছেন, দয়া করে আবার চেষ্টা করুন"),
                  textColor: clr.iconColorSweetRed,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
          if (data.type == AssignmentType.group.name)
            if (data.passMark >
                data.circularSubAssignments!.assignmentSubmissions!.marks)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor2,
                  borderRadius: BorderRadius.circular(size.r8),
                  border:
                      Border.all(color: clr.cardStrokeColor, width: size.w1),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: clr.blackColor.withOpacity(.2))
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h12),
                margin: EdgeInsets.only(top: size.h16),
                child: CustomTextWidget(
                  text: label(
                      e: "Sorry, you failed to complete the assignment, please try again",
                      b: "দুঃখিত, অ্যাসাইনমেন্ট টি সম্পন্ন করতে আপনি ব্যার্থ হয়েছেন, দয়া করে আবার চেষ্টা করুন"),
                  textColor: clr.iconColorSweetRed,
                  fontSize: size.textXSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
          Center(
            child: CustomTextWidget(
              text: label(
                  e: "Assignment Review Completed",
                  b: "অ্যাসাইনমেন্ট রিভিউ সম্পন্ন হয়েছে"),
              fontSize: size.textXMedium,
              fontWeight: FontWeight.w500,
              padding: EdgeInsets.only(top: size.h16),
            ),
          ),
          SizedBox(height: size.h16),
          AssignmentResultRowWidget(
              leftText: label(e: "Total Mark", b: "মোট মার্ক"),
              rightText: label(
                  e: data.mark.toString(),
                  b: replaceEnglishNumberWithBengali(data.mark.toString()))),
          SizedBox(height: size.h16),
          AssignmentResultRowWidget(
              leftText: label(e: "Pass Mark", b: "পাশ মার্ক"),
              rightText: label(
                  e: data.passMark.toString(),
                  b: replaceEnglishNumberWithBengali(
                      data.passMark.toString()))),
          SizedBox(height: size.h16),
          AssignmentResultRowWidget(
              leftText: label(e: "Marks Obtained", b: "প্রাপ্ত মার্ক"),
              rightText: data.type == "individual"
                  ? label(
                      e: data.assignmentSubmissions!.marks.toString(),
                      b: replaceEnglishNumberWithBengali(
                          data.assignmentSubmissions!.marks.toString()))
                  : label(
                      e: data
                          .circularSubAssignments!.assignmentSubmissions!.marks
                          .toString(),
                      b: replaceEnglishNumberWithBengali(data
                          .circularSubAssignments!.assignmentSubmissions!.marks
                          .toString()))),
          if (data.type == AssignmentType.individual.name)
            if (data.passMark > data.assignmentSubmissions!.marks)
              Padding(
                padding: EdgeInsets.only(top: size.h20),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: size.r24,
                      color: clr.appPrimaryColorGreen,
                    ),
                    SizedBox(width: size.w8),
                    Expanded(
                      child: CustomTextWidget(
                        text: label(
                            e: "You have more opportunities. You can try a maximum of 10 times. Request the instructor to participate in the re-evaluation.",
                            b: "আপনার কাছে আরো সুযোগ আছে. আপনি সর্বোচ্চ ১০ বার চেষ্টা করতে পারবেন. পুনরায় মূল্যায়নে অংশগ্রহণ করার জন্য প্রশিক্ষকের কাছে অনুরোধ করুন."),
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
          if (data.type == AssignmentType.group.name)
            if (data.passMark >
                data.circularSubAssignments!.assignmentSubmissions!.marks)
              Padding(
                padding: EdgeInsets.only(top: size.h20),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: size.r24,
                      color: clr.appPrimaryColorGreen,
                    ),
                    SizedBox(width: size.w8),
                    Expanded(
                      child: CustomTextWidget(
                        text: label(
                            e: "You have more opportunities. You can try a maximum of 10 times. Request the instructor to participate in the re-evaluation.",
                            b: "আপনার কাছে আরো সুযোগ আছে. আপনি সর্বোচ্চ ১০ বার চেষ্টা করতে পারবেন. পুনরায় মূল্যায়নে অংশগ্রহণ করার জন্য প্রশিক্ষকের কাছে অনুরোধ করুন."),
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
          if (data.type == AssignmentType.individual.name)
            if (data.passMark > data.assignmentSubmissions!.marks)
              Padding(
                padding: EdgeInsets.only(
                    left: size.w64, right: size.w64, top: size.h24),
                child: CustomButton(
                  onTap: onTapRequest,
                  title: label(e: "Send Request", b: "অনুরোধ পাঠান"),
                  bgColor: clr.appPrimaryColorGreen,
                  borderColor: Colors.transparent,
                  radius: size.r8,
                  verticalPadding: size.h4,
                ),
              ),
          if (data.type == AssignmentType.group.name)
            if (data.passMark >
                data.circularSubAssignments!.assignmentSubmissions!.marks)
              Padding(
                padding: EdgeInsets.only(
                    left: size.w64, right: size.w64, top: size.h24),
                child: CustomButton(
                  onTap: onTapRequest,
                  title: label(e: "Send Request", b: "অনুরোধ পাঠান"),
                  bgColor: clr.appPrimaryColorGreen,
                  borderColor: Colors.transparent,
                  radius: size.r8,
                  verticalPadding: size.h4,
                ),
              )
        ],
      ),
    );
  }
}

class InstructorCommentWidget extends StatelessWidget with AppTheme, Language {
  final String remarks;
  const InstructorCommentWidget({super.key, required this.remarks});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      margin: EdgeInsets.only(top: size.h12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: label(e: "Instructor Comments", b: "প্রশিক্ষকের মন্তব্য"),
            textColor: clr.textColorBlack,
            fontSize: size.textXMedium,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: size.h16),
          CustomTextWidget(
            text: remarks,
            fontSize: size.textXMedium,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class AssignmentResultRowWidget extends StatelessWidget with AppTheme {
  final String leftText;
  final String rightText;
  const AssignmentResultRowWidget(
      {super.key, required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: leftText,
          textColor: clr.textColorBlack,
          fontWeight: FontWeight.w500,
        ),
        CustomTextWidget(
          text: rightText,
          textColor: clr.textColorBlack,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
