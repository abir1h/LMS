import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import 'report_bottom_sheet.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../services/detailed_discussion_service.dart';
import 'discussion_bottom_sheet.dart';
import 'opinion_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class DetailedDiscussion extends StatefulWidget {
  final Object? arguments;
  const DetailedDiscussion({super.key, this.arguments});

  @override
  State<DetailedDiscussion> createState() => _DetailedDiscussionState();
}

class _DetailedDiscussionState extends State<DetailedDiscussion>
    with AppTheme, Language, DetailedDiscussionService {
  late DetailedDiscussionArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as DetailedDiscussionArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadDiscussionData(_screenArgs.discussionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.detailedDiscussion, b: bn.detailedDiscussion),
        bgColor: clr.whiteColor,
        body: AppStreamBuilder<DiscussionDataEntity>(
          stream: discussionDataStreamController.stream,
          loadingBuilder: (context) {
            return const Center(child: CircularLoader());
          },
          dataBuilder: (context, data) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Title
                      Container(
                        padding: EdgeInsets.only(
                            left: size.w16,
                            top: size.h16,
                            right: size.w16,
                            bottom: size.h10),
                        decoration: BoxDecoration(
                            color: clr.scaffoldBackgroundColor,
                            border: Border(
                                bottom: BorderSide(
                                    color: clr.placeHolderTextColorGray))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ImageAssets.imgEmptyProfile,
                              height: size.r24,
                            ),
                            SizedBox(width: size.w8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    label(
                                        e: data.description,
                                        b: data.description),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins,
                                        fontSize: size.textSmall,
                                        color: clr.textColorAppleBlack),
                                  ),
                                  SizedBox(height: size.h12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            onTapVoteDiscussion(data.id),

                                        ///Todo
                                        child: Icon(
                                          Icons.thumb_up,
                                          color: !data.isVote
                                              ? clr.placeHolderTextColorGray
                                              : clr.appPrimaryColorGreen,
                                          size: size.r20,
                                        ),
                                      ),
                                      SizedBox(width: size.w8),
                                      if (!data.isSelf)
                                        GestureDetector(
                                          onTap: () =>
                                              onTapReportDiscussion(data.id),
                                          child: Icon(
                                            Icons.flag,
                                            color: !data.isReport
                                                ? clr.placeHolderTextColorGray
                                                : clr.appPrimaryColorGreen,
                                            size: size.r20,
                                          ),
                                        ),
                                      Expanded(
                                        child: Text.rich(
                                            textAlign: TextAlign.end,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: clr
                                                    .placeHolderTextColorGray,
                                                fontSize: size.textXXSmall,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: StringData
                                                    .fontFamilyPoppins),
                                            TextSpan(
                                                // text: label(
                                                //     e: "মোট ${_screenArgs.discussionModel!.comments != null ? _screenArgs.discussionModel!.comments!.length.toString() : "0"} টি",
                                                //     b: "মোট ${_screenArgs.discussionModel!.comments != null ? _screenArgs.discussionModel!.comments!.length.toString() : "0"} টি"),

                                                text: label(
                                                    e: "Total ${data.vote.toString()}",
                                                    b: "মোট ${replaceEnglishNumberWithBengali(data.vote.toString())} টি"),
                                                children: [
                                                  const TextSpan(
                                                    text: " | ",
                                                  ),
                                                  TextSpan(
                                                    text: label(
                                                      e: "Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
                                                      b: "তারিখ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
                                                    ),
                                                  )
                                                ])),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (data.isSelf)
                              PopupMenuButton(
                                surfaceTintColor: clr.shadeWhiteColor2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.r4),
                                  ),
                                ),
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    onTap: () =>
                                        onTapUpdateDiscussion(data.description),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.border_color_outlined,
                                          size: size.r16,
                                          color: clr.appPrimaryColorGreen,
                                        ),
                                        SizedBox(width: size.w8),
                                        CustomTextWidget(
                                          text:
                                              label(e: "Edit", b: "এডিট করুন"),
                                          fontSize: size.textXSmall,
                                          textColor: clr.gapStrokeGrey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () =>
                                        onTapRemoveDiscussions(data.id),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.delete_outline_outlined,
                                          size: size.r16,
                                          color: clr.appPrimaryColorGreen,
                                        ),
                                        SizedBox(width: size.w8),
                                        CustomTextWidget(
                                          text: label(
                                              e: "Remove", b: "মুছে ফেলুন"),
                                          fontSize: size.textXSmall,
                                          textColor: clr.gapStrokeGrey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                child: Icon(
                                  Icons.more_vert_outlined,
                                  size: size.r16,
                                  color: clr.iconColorBlack,
                                ),
                              ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: data.comments.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CommentTile(
                            data: data.comments[index],
                            onTapVote: () =>
                                onTapVoteComment(data.comments[index].id),
                            onTapReport: () =>
                                onTapReport(data.comments[index].id),
                            onTapEdit: () => onTapOpinion(
                                edit: true,
                                commentId: data.comments[index].id,
                                description: data.comments[index].description),
                            onTapRemove: () =>
                                onTapRemoveComment(data.comments[index].id),
                          );
                        },
                      ),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: size.h20,
                  right: size.w16,
                  child: CustomButton(
                    onTap: () => onTapOpinion(
                        edit: false, commentId: -1, description: ""),
                    icon: Icons.add_comment,
                    title: label(e: en.yourOpinion, b: bn.yourOpinion),
                    radius: size.r4,
                  ),
                )
              ],
            );
          },
          emptyBuilder: (context, message, icon) => CustomEmptyWidget(
            message: message,
            // constraints: constraints,
            // offset: 350.w,
          ),
        ));
  }

  void onTapUpdateDiscussion(String description) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => DiscussionBottomSheet(
        edit: true,
        discussionId: _screenArgs.discussionId,
        description: description,
        onSuccess: () {
          Navigator.of(context).pop();
          loadDiscussionData(_screenArgs.discussionId);
          AppEventsNotifier.notify(EventAction.discussion);
        },
      ),
    );
  }

  void onTapReportDiscussion(int discussionId) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => ReportBottomSheet(
        from: "discussion",
        id: discussionId,
        onSuccess: () {
          Navigator.of(context).pop();
          // loadDiscussionData(_screenArgs.discussionId);
        },
      ),
    );
  }

  void onTapOpinion(
      {required bool edit,
      required int commentId,
      required String description}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => OpinionBottomSheet(
        edit: edit,
        discussionId: _screenArgs.discussionId,
        commentId: commentId,
        description: description,
        onSuccess: () {
          Navigator.of(context).pop();
          loadDiscussionData(_screenArgs.discussionId);
        },
      ),
    );
  }

  void onTapReport(int commentId) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => ReportBottomSheet(
        from: "comment",
        id: commentId,
        onSuccess: () {
          Navigator.of(context).pop();
          // loadDiscussionData(_screenArgs.discussionId);
        },
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
}

class CommentTile extends StatelessWidget with AppTheme, Language {
  final CommentDataEntity data;
  final VoidCallback onTapVote;
  final VoidCallback onTapReport;
  final VoidCallback onTapEdit;
  final VoidCallback onTapRemove;
  const CommentTile(
      {super.key,
      required this.data,
      required this.onTapVote,
      required this.onTapReport,
      required this.onTapEdit,
      required this.onTapRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: size.w48, top: size.h8, right: size.w16, bottom: size.h16),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: clr.cardStrokeColor))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImageAssets.imgEmptyProfile,
                height: size.h24,
              ),
              SizedBox(width: size.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: label(e: "ব্যবহারকারীর নাম", b: "ব্যবহারকারীর নাম"),
                      textColor: clr.blackColor,
                      fontFamily: StringData.fontFamilyPoppins,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: size.h4),
                    CustomTextWidget(
                      text: label(
                          e: timeago.format(DateTime.parse(data.createdAt)),
                          b: timeAgoToBengali(timeago
                              .format(DateTime.parse(data.createdAt.trim())))),
                      textColor: clr.placeHolderTextColorGray,
                      fontSize: size.textXXSmall,
                      fontFamily: StringData.fontFamilyPoppins,
                    ),
                  ],
                ),
              ),

              ///
              // Text(
              //   label(
              //     e: "Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
              //     b: "তারিখ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
              //   ),
              //   style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontFamily: StringData.fontFamilyPoppins,
              //       fontSize: size.textXXSmall,
              //       color: clr.iconColorHint),
              // ),
              // Icon(
              //   Icons.more_vert_outlined,
              //   size: size.r16,
              //   color: clr.iconColorBlack,
              // ),
              if (data.isSelf)
                PopupMenuButton(
                  surfaceTintColor: clr.shadeWhiteColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.r4),
                    ),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: onTapEdit,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.border_color_outlined,
                            size: size.r16,
                            color: clr.appPrimaryColorGreen,
                          ),
                          SizedBox(width: size.w8),
                          CustomTextWidget(
                            text: label(e: "Edit", b: "এডিট করুন"),
                            fontSize: size.textXSmall,
                            textColor: clr.gapStrokeGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onTapRemove,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline_outlined,
                            size: size.r16,
                            color: clr.appPrimaryColorGreen,
                          ),
                          SizedBox(width: size.w8),
                          CustomTextWidget(
                            text: label(e: "Remove", b: "মুছে ফেলুন"),
                            fontSize: size.textXSmall,
                            textColor: clr.gapStrokeGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: Icon(
                    Icons.more_vert_outlined,
                    size: size.r16,
                    color: clr.iconColorBlack,
                  ),
                ),
            ],
          ),
          SizedBox(height: size.h16),
          Text(
            label(e: data.description, b: data.description),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyPoppins,
                fontSize: size.textSmall,
                color: clr.blackColor),
          ),
          SizedBox(height: size.h16),
          Divider(color: clr.placeHolderDeselectGray),
          SizedBox(height: size.h8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapVote,
                child: Icon(
                  Icons.thumb_up,
                  color: !data.isVote
                      ? clr.placeHolderTextColorGray
                      : clr.appPrimaryColorGreen,
                  size: size.r20,
                ),
              ),
              SizedBox(width: size.w4),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      label(
                          e: "${data.vote.toString()}  Like",
                          b: "${replaceEnglishNumberWithBengali(data.vote.toString())}  লাইক"),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins,
                          fontSize: size.textXSmall,
                          color: clr.placeHolderTextColorGray),
                    ),
                  ],
                ),
              ),
              if (!data.isSelf)
                Icon(
                  Icons.flag,
                  color: clr.placeHolderTextColorGray,
                  size: size.r20,
                ),
              SizedBox(width: size.w4),
              if (!data.isSelf)
                GestureDetector(
                  onTap: onTapReport,
                  child: Text(
                    "রিপোর্ট",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontSize: size.textXSmall,
                        color: clr.placeHolderTextColorGray),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
