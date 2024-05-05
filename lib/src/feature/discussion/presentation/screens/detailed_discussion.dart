import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/comment_data_entity.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../models/comment_model.dart';
import '../services/detailed_discussion_service.dart';
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

                                                text: "মোট 3 টি",
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
                            )
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
                    onTap: onTapOpinion,
                    // onTap: () {
                    //   showCupertinoModalPopup(
                    //     context: context,
                    //     builder: (context) => OpinionBottomSheet(
                    //         masterModel: _screenArgs.discussionModel),
                    //   );
                    // },
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
    // body: GetBuilder<DiscussionController>(builder: (_) {
    //   return Stack(
    //     children: [
    //       SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         child: Column(
    //           children: [
    //             ///Title
    //             Container(
    //               padding: EdgeInsets.only(
    //                   left: size.w16,
    //                   top: size.h16,
    //                   right: size.w16,
    //                   bottom: size.h10),
    //               decoration: BoxDecoration(
    //                   color: clr.scaffoldBackgroundColor,
    //                   border: Border(
    //                       bottom: BorderSide(
    //                           color: clr.placeHolderTextColorGray))),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Image.asset(
    //                     _screenArgs.discussionModel!.avatar!,
    //                     height: size.r24,
    //                   ),
    //                   SizedBox(width: size.w8),
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           _screenArgs.discussionModel!.description!,
    //                           /*    label(
    //                             e: "Student Qualifications Physiology is an integrated science that considers the function of each organ and organ system and their interaction in the maintenance of life.",
    //                             b: "শিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে।")*/
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.w500,
    //                               fontFamily: StringData.fontFamilyPoppins,
    //                               fontSize: size.textSmall,
    //                               color: clr.textColorAppleBlack),
    //                         ),
    //                         SizedBox(height: size.h12),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             Expanded(
    //                               child: Text.rich(
    //                                   textAlign: TextAlign.end,
    //                                   maxLines: 2,
    //                                   overflow: TextOverflow.ellipsis,
    //                                   style: TextStyle(
    //                                       color:
    //                                           clr.placeHolderTextColorGray,
    //                                       fontSize: size.textXXSmall,
    //                                       fontWeight: FontWeight.w500,
    //                                       fontFamily:
    //                                           StringData.fontFamilyPoppins),
    //                                   TextSpan(
    //                                       text: label(
    //                                           e: "মোট ${_screenArgs.discussionModel!.comments != null ? _screenArgs.discussionModel!.comments!.length.toString() : "0"} টি",
    //                                           b: "মোট ${_screenArgs.discussionModel!.comments != null ? _screenArgs.discussionModel!.comments!.length.toString() : "0"} টি"),
    //                                       children: [
    //                                         const TextSpan(
    //                                           text: " | ",
    //                                         ),
    //                                         TextSpan(
    //                                           text:
    //                                               "তারিখ: ${_screenArgs.discussionModel!.createdAt!}",
    //                                         ),
    //                                       ])),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             ListView.builder(
    //               itemBuilder: (_, index) {
    //                 return CommentTile(
    //                   commentModel:
    //                       _screenArgs.discussionModel!.comments![index],
    //                 );
    //               },
    //               itemCount: _screenArgs.discussionModel!.comments!.length,
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //             ),
    //             SizedBox(
    //               height: 100.h,
    //             )
    //           ],
    //         ),
    //       ),
    //       Positioned(
    //         bottom: size.h20,
    //         right: size.w16,
    //         child: CustomButton(
    //           onTap: () {
    //             showCupertinoModalPopup(
    //               context: context,
    //               builder: (context) => OpinionBottomSheet(
    //                   masterModel: _screenArgs.discussionModel),
    //             );
    //           },
    //           icon: Icons.add_comment,
    //           title: label(e: en.yourOpinion, b: bn.yourOpinion),
    //           radius: size.r4,
    //         ),
    //       )
    //     ],
    //   );
    // }));
  }

  void onTapOpinion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => OpinionBottomSheet(
        discussionId: _screenArgs.discussionId,
        onSuccess: () {
          Navigator.of(context).pop();
          loadDiscussionData(_screenArgs.discussionId);
        },
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class CommentTile extends StatelessWidget with AppTheme, Language {
  final CommentDataEntity data;
  const CommentTile({super.key, required this.data});

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
            children: [
              Image.asset(
                ImageAssets.imgEmptyProfile,
                height: size.h24,
              ),
              SizedBox(width: size.w12),
              Expanded(
                child: Text(
                  "ব্যবহারকারীর নাম",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      color: clr.blackColor),
                ),
              ),
              Text(
                label(
                  e: "Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
                  b: "তারিখ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.createdAt))}",
                ),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textXXSmall,
                    color: clr.iconColorHint),
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
                onTap: () {},
                child: Icon(
                  Icons.thumb_up,
                  color: clr.placeHolderTextColorGray,
                  size: size.r20,
                ),
              ),
              SizedBox(width: size.w4),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${data.vote.toString()}  ভোট",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins,
                          fontSize: size.textXSmall,
                          color: clr.placeHolderTextColorGray),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.flag,
                color: clr.placeHolderTextColorGray,
                size: size.r20,
              ),
              SizedBox(width: size.w4),
              Text(
                "রিপোর্ট",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontSize: size.textXSmall,
                    color: clr.placeHolderTextColorGray),
              ),
            ],
          )
        ],
      ),
    );
  }
}
