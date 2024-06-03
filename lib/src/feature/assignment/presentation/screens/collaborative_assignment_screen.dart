import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/assignment_data_entity.dart';
import '../../domain/entities/submitted_trainee_list_data_entity.dart';
import '../services/assignment_screen_service.dart';
import '../widgets/file_picker_widget.dart';
import 'assignment_screen.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                if (data.instructionsEn.isNotEmpty &&
                    data.instructionsBn.isNotEmpty)
                  AssignmentInstructions(
                    text: label(e: data.instructionsEn, b: data.instructionsBn),
                  ),
                CustomTextWidget(
                  text: label(e: "Points Criteria", b: "অ্যাসাইনমেন্টের বিবরণ"),
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
                        text:
                            label(e: data.descriptionEn, b: data.descriptionBn),
                        textColor: clr.gapStrokeGrey,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                CustomTextWidget(
                  text: label(
                      e: "Assignment Submission", b: "এসাইনমেন্ট সাবমিশন"),
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
                    border:
                        Border.all(color: clr.cardStrokeColor, width: size.w1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: label(
                            e: "Write The Assignment", b: "এসাইনমেন্ট লিখুন"),
                        textColor: clr.textColorAppleBlack,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: size.h8),
                      WrittenAnswerWidget(
                        answer: "",
                        onTap: () {},
                      ),
                      SizedBox(height: size.h16),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.w16, vertical: size.h8),
                          decoration: BoxDecoration(
                            color: clr.shadeWhiteColor,
                            borderRadius: BorderRadius.circular(size.r4),
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
                      SizedBox(height: size.h16),
                      FilePickerWidget(
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
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
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
                Padding(
                  padding: EdgeInsets.only(
                      left: size.w16, right: size.w16, top: size.h16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: () {
                          /*onStoreAssignment(
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
                      });*/
                        },
                        title: label(e: "Submit", b: "জমা দিন"),
                        bgColor: files!.isEmpty
                            ? clr.iconColorHint
                            : clr.appPrimaryColorGreen,
                        borderColor: Colors.transparent,
                        radius: size.r4,
                        horizontalPadding: size.w20,
                        verticalPadding: size.h4,
                      )
                    ],
                  ),
                ),
                CustomTextWidget(
                  text: label(e: "Submission Status", b: "সাবমিশন স্ট্যাটাস"),
                  textColor: clr.textColorAppleBlack,
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsets.only(
                      left: size.w16, right: size.w16, top: size.h16),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: size.w16, right: size.w16, top: size.h12),
                  decoration: BoxDecoration(
                    color: clr.cardFillColorMintCream,
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
                      horizontal: size.w12, vertical: size.h8),
                  child: CustomTextWidget(
                    text: label(
                        e: "Your assignment has been submitted, please wait for review Review You can edit it before the review",
                        b: "আপনার এসাইনমেন্ট সাবমিট করা হয়েছে, দয়া করে রিভিউ এর জন্য অপেক্ষা করুন| রিভিউ এর পূর্ব  পর্যন্ত আপনি এটি এডিট করতে পারবেন"),
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (data.submittedTraineeList.isNotEmpty)
                  SubmittedTraineeSectionWidget(
                    items: data.submittedTraineeList,
                    builder: (BuildContext context, int index, item) =>
                        SubmittedTraineeItemWidget(
                      submittedTraineeListDataEntity: item,
                      onTap: () {},
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

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

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
  final SubmittedTraineeListDataEntity submittedTraineeListDataEntity;
  final VoidCallback onTap;
  const SubmittedTraineeItemWidget(
      {super.key,
      required this.submittedTraineeListDataEntity,
      required this.onTap});

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
          CustomButton(
            onTap: onTap,
            title: label(e: "Accept", b: "গ্রহণ করুন"),
            textColor: clr.appPrimaryColorGreen,
            bgColor: clr.scaffoldBackgroundColor,
            borderColor: clr.appPrimaryColorGreen,
            radius: size.r4,
            horizontalPadding: size.w12,
            verticalPadding: size.h4,
          ),
        ],
      ),
    );
  }
}
