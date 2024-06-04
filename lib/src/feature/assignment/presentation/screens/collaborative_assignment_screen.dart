import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/entities/submitted_trainee_list_data_entity.dart';
import '../services/assignment_screen_service.dart';
import '../widgets/assignment_bottom_sheet.dart';
import '../widgets/file_picker_widget.dart';

class CollaborativeAssignmentScreen extends StatefulWidget {
  final Object? arguments;
  const CollaborativeAssignmentScreen({super.key, this.arguments});

  @override
  State<CollaborativeAssignmentScreen> createState() =>
      _CollaborativeAssignmentScreenState();
}

class _CollaborativeAssignmentScreenState
    extends State<CollaborativeAssignmentScreen>
    with AppTheme, Language, ImagePreviewDialog, AssignmentScreenService {
  late AssignmentArgs _screenArgs;
  final _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAssignmentData(_screenArgs.courseContentId);
    });
  }

  setContent() {
    if (quillData != null) {
      if (quillData.contains("{")) {
        final Document doc = Document.fromJson(json.decode(quillData));
        _controller.document = doc;
      }
    }
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
          if (quillData == null) {
            if (data.assignmentSubmissions != null) {
              if (data.assignmentSubmissions!.answer.isNotEmpty) {
                quillData = data.assignmentSubmissions!.answer;
                setContent();
              }
            }
          }
          return (data.type == AssignmentType.group.name)
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///Title
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w16, vertical: size.h16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: clr.boxStrokeColor))),
                        child: CustomTextWidget(
                            text: label(e: data.titleEn, b: data.titleBn),
                            fontFamily: StringData.fontFamilyPoppins),
                      ),

                      ///Assignment Instruction
                      if (data.instructionsEn.isNotEmpty &&
                          data.instructionsBn.isNotEmpty)
                        AssignmentInstructions(
                          text: label(
                              e: data.instructionsEn, b: data.instructionsBn),
                        ),

                      ///Assignment Description
                      CustomTextWidget(
                        text: label(
                            e: "Points Criteria", b: "অ্যাসাইনমেন্টের বিবরণ"),
                        textColor: clr.blackText,
                        padding: EdgeInsets.only(
                            left: size.w16, right: size.w16, top: size.h16),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.w16, right: size.w16, top: size.h8),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w12, vertical: size.h12),
                        decoration: BoxDecoration(
                          color: clr.shadeWhiteColor2,
                          borderRadius: BorderRadius.circular(size.r8),
                          border: Border.all(
                              color: clr.cardStrokeColorGrey2, width: size.w1),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: clr.blackColor.withOpacity(.15))
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTextWidget(
                              text: label(
                                  e: data.descriptionEn, b: data.descriptionBn),
                              textColor: clr.gapStrokeGrey,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),

                      ///Submission
                      CustomTextWidget(
                        text: label(
                            e: "Assignment Submission",
                            b: "এসাইনমেন্ট সাবমিশন"),
                        textColor: clr.blackText,
                        padding: EdgeInsets.only(
                            left: size.w16, right: size.w16, top: size.h16),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: size.w16, right: size.w16, top: size.h8),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w12, vertical: size.h16),
                        decoration: BoxDecoration(
                          color: clr.cardFillColorMintCream,
                          borderRadius: BorderRadius.circular(size.r8),
                          border: Border.all(
                              color: clr.cardStrokeColor, width: size.w1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.assignmentSubmissions != null)
                              Padding(
                                padding: EdgeInsets.only(bottom: size.h8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextWidget(
                                        text: label(
                                            e: "Your Submission",
                                            b: "আপনার সাবমিশন"),
                                        textColor: clr.textColorAppleBlack,
                                        fontSize: size.textXSmall,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if ((quillData != null ||
                                            data.assignmentSubmissions !=
                                                null) &&
                                        data.submissionType ==
                                            AssignmentSubType.written.name)
                                      EditButtonWidget(
                                        onTap: () => onTapWriteHere(
                                            "store", data, quillData),
                                      ),
                                  ],
                                ),
                              ),

                            ///Written
                            if ((data.submissionType ==
                                        AssignmentSubType.written.name ||
                                    data.submissionType ==
                                        AssignmentSubType.both.name) &&
                                data.assignmentSubmissions == null)
                              Padding(
                                padding: EdgeInsets.only(bottom: size.h8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextWidget(
                                        text: label(
                                            e: "Write The Assignment",
                                            b: "এসাইনমেন্ট লিখুন"),
                                        textColor: clr.textColorAppleBlack,
                                        fontSize: size.textXSmall,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (quillData != null ||
                                        data.assignmentSubmissions != null)
                                      EditButtonWidget(
                                        onTap: () => onTapWriteHere(
                                            "store", data, quillData),
                                      ),
                                  ],
                                ),
                              ),
                            if (data.submissionType ==
                                    AssignmentSubType.written.name ||
                                data.submissionType ==
                                    AssignmentSubType.both.name)
                              GestureDetector(
                                onTap: () {
                                  if (data.assignmentSubmissions == null) {
                                    onTapWriteHere("store", data, quillData);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.w16, vertical: size.h12),
                                  decoration: BoxDecoration(
                                    color: clr.whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(size.r8),
                                    border: Border.all(
                                        color: clr.boxStrokeColor,
                                        width: size.w1),
                                  ),
                                  child: quillData == null
                                      ? Text(
                                          label(
                                              e: en.writeHere, b: bn.writeHere),
                                          style: TextStyle(
                                              color:
                                                  clr.placeHolderTextColorGray,
                                              // : clr.textColorAppleBlack,
                                              fontSize: size.textSmall,
                                              fontWeight: FontWeight.w500,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                        )
                                      : QuilTextViewer(
                                          controller: _controller,
                                          hintText: label(
                                              e: en.writeHere, b: bn.writeHere),
                                        ),
                                ),
                              ),

                            ///Or
                            if (data.submissionType ==
                                AssignmentSubType.both.name)
                              Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: size.h16),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.w16, vertical: size.h8),
                                  decoration: BoxDecoration(
                                    color: clr.shadeWhiteColor,
                                    borderRadius:
                                        BorderRadius.circular(size.r4),
                                    border: Border.all(
                                        color: clr.placeHolderTextColorGray,
                                        width: size.w1),
                                  ),
                                  child: CustomTextWidget(
                                    text: label(e: "Or", b: "অথবা"),
                                    textColor: clr.textColorAppleBlack,
                                  ),
                                ),
                              ),

                            ///Upload
                            if ((data.submissionType ==
                                        AssignmentSubType.upload.name ||
                                    data.submissionType ==
                                        AssignmentSubType.both.name) &&
                                data.assignmentSubmissions == null)
                              CustomTextWidget(
                                text: label(
                                    e: en.uploadTheFile, b: bn.uploadTheFile),
                                textColor: clr.textColorAppleBlack,
                                fontSize: size.textXSmall,
                                fontWeight: FontWeight.w500,
                                padding: EdgeInsets.only(bottom: size.h8),
                              ),

                            ///Submitted File
                            if (data.assignmentSubmissions != null &&
                                data.assignmentSubmissions!.attachments
                                    .isNotEmpty)
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: clr.shadeWhiteColor2,
                                  borderRadius: BorderRadius.circular(size.r8),
                                  border: Border.all(
                                      color: clr.boxStrokeColor,
                                      width: size.w1),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: clr.blackColor.withOpacity(.15))
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.w16, vertical: size.h12),
                                margin: EdgeInsets.only(bottom: size.h12),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: data.assignmentSubmissions!
                                      .attachments.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextWidget(
                                          text: data.assignmentSubmissions!
                                              .attachments[index].file
                                              .split("/")
                                              .last,
                                          fontSize: size.textXSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      DownloadButtonWidget(
                                          onTap: () => downloadFiles(
                                              fileUrl: data
                                                  .assignmentSubmissions!
                                                  .attachments
                                                  .first
                                                  .file,
                                              filename: data
                                                  .assignmentSubmissions!
                                                  .attachments
                                                  .first
                                                  .file
                                                  .split("/")
                                                  .last,
                                              context: context)),
                                    ],
                                  ),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: size.h12);
                                  },
                                ),
                              ),

                            ///Attach File
                            if (data.submissionType ==
                                    AssignmentSubType.upload.name ||
                                data.submissionType ==
                                    AssignmentSubType.both.name)
                              FilePickerWidget(
                                  items: files!,
                                  builder:
                                      (BuildContext context, int index, item) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.path.split('/').last,
                                            style: TextStyle(
                                                color: clr.appPrimaryColorGreen,
                                                fontSize: size.textSmall,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: StringData
                                                    .fontFamilyPoppins),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (files!.isNotEmpty)
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  files!.removeWhere(
                                                      (element) =>
                                                          element ==
                                                          files![index]);
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
                                  onPickFile: pickFiles),

                            /*if (files!.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: files!.length,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(size.r4),
                                  child: Image.file(
                                    files![index],
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      files!.removeWhere((element) =>
                                          element == files![index]);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(size.r4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: clr.whiteColor,
                                      size: size.r10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )*/
                          ],
                        ),
                      ),

                      ///Submit Button
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.w16, right: size.w16, top: size.h16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (data.assignmentSubmissions == null)
                              CustomButton(
                                onTap: () => onStoreAssignment(
                                    assignmentId: data.id,
                                    subAssignmentId:
                                        data.circularSubAssignments != null
                                            ? data.circularSubAssignments!.id
                                            : -1,
                                    courseId: data.courseId,
                                    circularId: data.circularId,
                                    answer: quillData ?? "",
                                    files: files!),
                                title: label(e: "Submit", b: "জমা দিন"),
                                bgColor: (files!.isEmpty && !isWrite)
                                    ? clr.iconColorHint
                                    : clr.appPrimaryColorGreen,
                                borderColor: Colors.transparent,
                                radius: size.r4,
                                horizontalPadding: size.w20,
                                verticalPadding: size.h4,
                              ),
                            if (data.assignmentSubmissions != null)
                              CustomButton(
                                onTap: () => onUpdateAssignment(
                                    submissionId:
                                        data.assignmentSubmissions!.id,
                                    assignmentId: data.id,
                                    subAssignmentId:
                                        data.circularSubAssignments != null
                                            ? data.circularSubAssignments!.id
                                            : -1,
                                    courseId: data.courseId,
                                    circularId: data.circularId,
                                    answer: '',
                                    files: files!),
                                title:
                                    label(e: "Re-Submit", b: "পুনরায় জমা দিন"),
                                bgColor: (files!.isEmpty && !isWrite)
                                    ? clr.iconColorHint
                                    : clr.appPrimaryColorGreen,
                                borderColor: Colors.transparent,
                                radius: size.r4,
                                horizontalPadding: size.w20,
                                verticalPadding: size.h4,
                              ),
                          ],
                        ),
                      ),

                      ///Submit Status
                      if (data.assignmentSubmissions != null)
                        CustomTextWidget(
                          text: label(
                              e: "Submission Status", b: "সাবমিশন স্ট্যাটাস"),
                          textColor: clr.textColorAppleBlack,
                          fontWeight: FontWeight.w500,
                          padding: EdgeInsets.only(
                              left: size.w16, right: size.w16, top: size.h16),
                        ),
                      if (data.assignmentSubmissions != null)
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: size.w16, right: size.w16, top: size.h12),
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

                      ///Submitted Trainee List
                      if (data.submittedTraineeList.isNotEmpty)
                        SubmittedTraineeSectionWidget(
                          items: data.submittedTraineeList,
                          builder: (BuildContext context, int index, item) =>
                              SubmittedTraineeItemWidget(
                            data: item,
                            onTap: () => onTapAccept(item.id, data),
                          ),
                        ),
                      SizedBox(height: size.h56),
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

  void onTapWriteHere(
      String type, AssignmentDataEntity assignmentDataEntity, String? answer) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AssignmentBottomSheet(
        type: type,
        assignmentDataEntity: assignmentDataEntity,
        answer: answer,
      ),
    ).then((value) {
      quillData = value;
      setState(() {
        setContent();
        isWrite = true;
      });
    });
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToCollaborativeInstructionScreen(
      int traineeId, AssignmentDataEntity assignmentDataEntity) {
    Navigator.of(context).pushNamed(
        AppRoute.collaborativeAssignmentInstructionScreen,
        arguments: AssignmentReviewArgs(
            traineeId: traineeId, assignmentDataEntity: assignmentDataEntity));
  }
}

///Assignment Instruction
class AssignmentInstructions<T> extends StatefulWidget {
  final String text;
  const AssignmentInstructions({super.key, required this.text});

  @override
  State<AssignmentInstructions<T>> createState() =>
      _AssignmentInstructionsState<T>();
}

class _AssignmentInstructionsState<T> extends State<AssignmentInstructions<T>>
    with AppTheme, Language {
  bool _isExpanded = false;

  _toggle() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: size.w24, right: size.w24, top: size.h10),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h8),
      decoration: BoxDecoration(
        color: clr.cardFillColorMintCream,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.gapStrokeGrey.withOpacity(.15))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _toggle(),
            child: Center(
              child: Container(
                color: clr.cardFillColorMintCream,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextWidget(
                      text:
                          label(e: "Assignment Guide", b: "এসাইনমেন্ট সহায়িকা"),
                      textColor: clr.blackText,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: size.w8),
                    Icon(
                      _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: clr.iconColorBlack,
                      size: size.r20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isExpanded)
            CustomTextWidget(
              text: widget.text,
              textColor: clr.blackText,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
              padding: EdgeInsets.only(top: size.h12),
            ),
        ],
      ),
    );
  }
}

///Submitted Trainee List
class SubmittedTraineeSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  const SubmittedTraineeSectionWidget(
      {super.key, required this.items, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label(
              e: "List of trainees who have submitted assignments",
              b: "এসাইনমেন্ট জমাদানকৃত প্রশিক্ষণার্থীদের তালিকা"),
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
          padding:
              EdgeInsets.only(left: size.w16, right: size.w16, top: size.h16),
        ),
        Container(
          width: double.infinity,
          margin:
              EdgeInsets.only(left: size.w16, right: size.w16, top: size.h8),
          decoration: BoxDecoration(
            color: clr.cardFillColorMintCream,
            borderRadius: BorderRadius.circular(size.r4),
            border: Border.all(color: clr.cardStrokeColor, width: size.w1),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: items.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                builder(context, index, items[index]),
            separatorBuilder: (context, index) {
              return Divider(
                  color: clr.dividerStrokeColorGrey, height: size.h1);
            },
          ),
        ),
      ],
    );
  }
}

class SubmittedTraineeItemWidget extends StatelessWidget with AppTheme {
  final SubmittedTraineeListDataEntity data;
  final VoidCallback onTap;
  const SubmittedTraineeItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h24),
      decoration: BoxDecoration(color: clr.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            color: clr.iconColorBlack,
            size: size.r24,
          ),
          SizedBox(width: size.w16),
          Expanded(
            child: CustomTextWidget(
              text:
                  label(e: "Submission Status", b: "প্রশিক্ষণার্থীর সাবমিশন ১"),
              textColor: clr.blackText,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: size.w8),
          data.isReviewed == 0
              ? CustomButton(
                  onTap: onTap,
                  title: data.isAccepted == 0
                      ? label(e: "Accept", b: "গ্রহণ করুন")
                      : label(e: "Accepted", b: "গৃহীত"),
                  textColor: data.isAccepted == 0
                      ? clr.appPrimaryColorGreen
                      : clr.shadeWhiteColor2,
                  bgColor: data.isAccepted == 0
                      ? clr.scaffoldBackgroundColor
                      : clr.iconColorHint,
                  borderColor: data.isAccepted == 0
                      ? clr.appPrimaryColorGreen
                      : Colors.transparent,
                  radius: size.r4,
                  horizontalPadding: size.w12,
                  verticalPadding: size.h4,
                )
              : CustomButton(
                  onTap: onTap,
                  title: label(e: "Reviewed", b: "পর্যালোচনা করা হয়েছে"),
                  textColor: clr.appPrimaryColorGreen,
                  bgColor: clr.cardFillColorOlive,
                  borderColor: clr.cardStrokeColorGreen,
                  radius: size.r4,
                  horizontalPadding: size.w12,
                  verticalPadding: size.h4,
                ),
        ],
      ),
    );
  }
}

///Download Button
class DownloadButtonWidget extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  const DownloadButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.r1),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r4),
          border: Border.all(color: clr.cardStrokeColor, width: size.r1),
          boxShadow: [
            BoxShadow(
              color: clr.blackColor.withOpacity(.2),
              blurRadius: size.r4,
              offset: Offset(0.0, size.h2),
            ),
          ],
        ),
        child: Icon(
          Icons.save_alt,
          color: clr.appPrimaryColorGreen,
          size: size.r20,
        ),
      ),
    );
  }
}

///Edit Button
class EditButtonWidget extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  const EditButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.w2),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r4),
          border: Border.all(color: clr.cardStrokeColor, width: size.r1),
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
    );
  }
}
