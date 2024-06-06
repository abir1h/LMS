import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/collaborative_accept_review_data_entity.dart';
import '../services/assignment_review_screen_service.dart';
import 'collaborative_assignment_screen.dart';

class AssignmentReviewScreen extends StatefulWidget {
  final Object? arguments;
  const AssignmentReviewScreen({super.key, this.arguments});

  @override
  State<AssignmentReviewScreen> createState() => _AssignmentReviewScreenState();
}

class _AssignmentReviewScreenState extends State<AssignmentReviewScreen>
    with AppTheme, Language, AssignmentReviewScreenService {
  late AssignmentReviewArgs _screenArgs;
  final _controller = QuillController.basic();
  TextEditingController marksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentReviewArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadReviewData(_screenArgs.traineeId);
    });
  }

  // setContent() {
  //   if (widget.answer.isNotEmpty) {
  //     if (widget.answer.contains("{")) {
  //       final Document doc = Document.fromJson(json.decode(widget.answer));
  //       _controller.document = doc;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      title: "",
      body: AppStreamBuilder<CollaborativeAcceptReviewDataEntity>(
        stream: acceptReviewDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          if (data.answer.isNotEmpty) {
            if (data.answer.contains("{")) {
              final Document doc = Document.fromJson(json.decode(data.answer));
              _controller.document = doc;
            }
          }

          return SingleChildScrollView(
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
                      text: label(
                          e: data.assignment!.titleEn,
                          b: data.assignment!.titleBn),
                      fontFamily: StringData.fontFamilyPoppins),
                ),
                SizedBox(height: size.h16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Row(
                    children: [
                      CustomTextWidget(
                        text: label(
                            e: "Review time Remaining",
                            b: "রিভিউইয়ের সময় আছে:"),
                        textColor: clr.blackText,
                        fontFamily: StringData.fontFamilyRoboto,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: size.w16),
                      ReviewTimerWidget(
                          timerStream: timerStreamController.stream),
                      // SizedBox(width: size.w16),
                      // CustomTextWidget(
                      //   text: label(e: "Minutes", b: "মিনিট"),
                      //   textColor: clr.blackText,
                      //   fontWeight: FontWeight.w500,
                      // )
                    ],
                  ),
                ),
                SizedBox(height: size.h16),
                CustomTextWidget(
                  text: label(
                      e: "Assignment Description", b: "অ্যাসাইনমেন্টের বিবরণ"),
                  textColor: clr.blackText,
                  fontWeight: FontWeight.w600,
                  fontSize: size.textSmall,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.w16),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.h10, vertical: size.h12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.r8),
                      boxShadow: [
                        BoxShadow(
                            color: clr.gapStrokeGrey.withOpacity(.15),
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 8)
                      ],
                      color: clr.scaffoldBackgroundColor,
                      border: Border.all(color: clr.cardStrokeColorGrey2)),
                  child: CustomTextWidget(
                    text: label(
                        e: data.assignment!.instructionsEn,
                        b: data.assignment!.instructionsBn),
                    textColor: clr.gapStrokeGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.h16),
                CustomTextWidget(
                  text: label(
                      e: "Trainee Submissions:", b: "প্রশিক্ষণার্থীর সাবমিশন:"),
                  textColor: clr.blackText,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                ),
                SizedBox(height: size.h8),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: size.w16),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.h12, vertical: size.h16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.r8),
                      boxShadow: [
                        BoxShadow(
                            color: clr.gapStrokeGrey.withOpacity(.15),
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 8)
                      ],
                      color: clr.whiteColor,
                      border: Border.all(color: clr.cardStrokeColorGrey2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.answer.isNotEmpty)
                        QuilTextViewer(
                          controller: _controller,
                          hintText: label(e: en.writeHere, b: bn.writeHere),
                        ),
                      if (data.attachments.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: data.attachments.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Row(
                            children: [
                              Expanded(
                                child: CustomTextWidget(
                                  text: data.attachments[index].file
                                      .split("/")
                                      .last,
                                  fontSize: size.textXSmall,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              DownloadButtonWidget(
                                  onTap: () => downloadFiles(
                                      fileUrl: data.attachments.first.file,
                                      filename: data.attachments.first.file
                                          .split("/")
                                          .last,
                                      context: context)),
                            ],
                          ),
                          separatorBuilder: (context, index) {
                            return SizedBox(height: size.h12);
                          },
                        )
                    ],
                  ),
                  // child: CustomTextWidget(
                  //   text: data.answer,
                  //   textColor: clr.gapStrokeGrey,
                  //   fontWeight: FontWeight.w500,
                  // ),
                ),
                SizedBox(height: size.h16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Text.rich(
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: clr.placeHolderTextColorGray,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                      TextSpan(
                          text: label(e: "Enter Number", b: "নম্বর ইনপুট দিন"),
                          style: TextStyle(
                            color: clr.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: size.textSmall,
                          ),
                          children: [
                            TextSpan(
                                text: label(
                                  e: " *",
                                  b: " *",
                                ),
                                style: TextStyle(
                                  color: clr.appSecondaryColorFlagRed,
                                  fontSize: size.textXXSmall,
                                ))
                          ])),
                ),
                SizedBox(height: size.h10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: AppTextField(
                    hintText: '',
                    controller: marksController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: size.h16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: () => onReviewResultSubmit(
                            assignmentSubId: data.id,
                            resultId: data.collaborativeAssignmentResult!.id,
                            markObtained: marksController.text.trim()),
                        title: label(e: "Submit", b: "জমা দিন"),
                        bgColor: marksController.text.isEmpty
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
                SizedBox(height: size.h56 + size.h56),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title: label(e: 'No Review Found', b: 'পাওয়া যায়নি'),
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

class ReviewTimerWidget extends StatelessWidget with AppTheme {
  final Stream<Duration> timerStream;
  const ReviewTimerWidget({super.key, required this.timerStream});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.w8,
        vertical: size.h6,
      ),
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.h4),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      child: StreamBuilder<Duration>(
          initialData: const Duration(),
          stream: timerStream,
          builder: (context, snapshot) {
            int min = snapshot.data!.inMinutes;
            int sec = snapshot.data!.inSeconds % 60;

            var minMsbRaw = min ~/ 10;
            var minMMsb = minMsbRaw ~/ 10;
            var minMsb = minMsbRaw % 10;
            var minLsb = min % 10;

            var secMsb = sec ~/ 10;
            var secLsb = sec % 10;
            return Row(
              children: [
                if (minMMsb > 0) _buildDigitBox(minMMsb),
                if (minMMsb > 0) SizedBox(width: size.w2),
                _buildDigitBox(minMsb),
                SizedBox(width: size.w2),
                _buildDigitBox(minLsb),
                SizedBox(width: size.w2),
                _buildDigitSeparatorBox(":"),
                SizedBox(width: size.w2),
                _buildDigitBox(secMsb),
                SizedBox(width: size.w2),
                _buildDigitBox(secLsb),
              ],
            );
          }),
    );
  }

  Widget _buildDigitBox(int value) {
    return Container(
      height: size.h24,
      width: size.w20,
      decoration: BoxDecoration(
        color: clr.iconColorSweetRed,
        borderRadius: BorderRadius.circular(size.w2),
      ),
      child: FittedBox(
        child: Text(
          value.toString(),
          style: TextStyle(
            fontSize: size.textXXXLarge,
            color: clr.whiteColor,
            height: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildDigitSeparatorBox(String value) {
    return Container(
      height: size.h24,
      width: size.w12,
      decoration: BoxDecoration(
        color: clr.iconColorSweetRed,
        borderRadius: BorderRadius.circular(size.w2),
      ),
      child: FittedBox(
        child: Text(
          value,
          style: TextStyle(
            fontSize: size.textXXXLarge,
            color: clr.whiteColor,
            height: 1,
          ),
        ),
      ),
    );
  }
}
