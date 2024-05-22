import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/common_widgets/custom_toasty.dart';
import 'package:lms/src/feature/course/domain/entities/video_choice_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/video_content_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/video_data_entity.dart';
import 'package:lms/src/feature/course/domain/entities/video_qustion_data_entity.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/presentation/widgets/tab_section_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../service/transcript_video_screen_service.dart';
import '../widgets/content_player_widget.dart';
import '../widgets/overlay_mcq_wiget.dart';

enum VideoCategory { s3, link }

class TranscriptVideoScreen extends StatefulWidget {
  final Object? arguments;
  const TranscriptVideoScreen({super.key, required this.arguments});

  @override
  State<TranscriptVideoScreen> createState() => _TranscriptVideoScreenState();
}

class _TranscriptVideoScreenState extends State<TranscriptVideoScreen>
    with AppTheme, Language, TranscriptScreenVideoService, AppEventsNotifier {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  final GlobalKey _bodyKey = GlobalKey();

  bool _onTouch = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    screenArgs = widget.arguments as CourseVideoScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadVideoData(screenArgs.data.contentId);
      // loadVideoData(220);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    _youtubeController?.dispose();
    _timer?.cancel();

    super.dispose();
  }

  bool playerFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: clr.whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) =>
            AppStreamBuilder<VideoContentDataEntity>(
          stream: videoDetailsDataStreamController.stream,
          loadingBuilder: (context) {
            return Column(
              children: [
                SizedBox(
                  height: .3.sh,
                ),
                const Center(
                  child: CircularLoader(),
                ),
              ],
            );
          },
          dataBuilder: (context, data) {
            return SafeArea(
              top: MediaQuery.of(context).orientation == Orientation.portrait,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ///Page body
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (data.videoData?.category ==
                          VideoCategory.s3.name) ...[
                        ///Activate solid video player
                        Stack(
                          fit: StackFit.loose,
                          children: [
                            ContentPlayerWidget(
                              playerStream:
                                  videoDetailsDataStreamController.stream,
                              playbackStream:
                                  playbackPausePlayStreamController.stream,
                              onProgressChanged: onPlaybackProgressChanged,
                              // interceptSeekTo: onInterceptPlaybackSeekToPosition,
                              // overlay: GestureDetector(
                              //     onTap: (){},
                              //     child: Icon(
                              //       Icons.arrow_back,
                              //       color: clr.shadeWhiteColor2,
                              //       size: size.r20,
                              //     ),
                              // ),
                            ),
                            Positioned(
                                top: size.h16,
                                left: size.w16,
                                child: InkWell(
                                  onTap: onGoBack,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: clr.shadeWhiteColor2,
                                    size: size.r20,
                                  ),
                                )),
                            AppStreamBuilder(
                                stream:
                                    videoQuestionDataStreamController.stream,
                                loadingBuilder: (context) {
                                  return Container();
                                },
                                dataBuilder: (context, data) {
                                  return showOverlay
                                      ? AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: OverlayMCQWidget(
                                            items: data.choices,
                                            data: data,
                                            onTapSkip: () {
                                              showOverlay = false;
                                              AppEventsNotifier.notify(
                                                  EventAction.videoWidget);
                                              playbackPausePlayStreamController
                                                  .add(DataLoadedState<bool>(
                                                      true));
                                            },
                                            onTapSubmit: () {
                                              showOverlay = false;
                                              AppEventsNotifier.notify(
                                                  EventAction.videoWidget);
                                              playbackPausePlayStreamController
                                                  .add(DataLoadedState<bool>(
                                                  true));
                                              // VideoChoiceDataEntity choice =
                                              //     data.choices.firstWhere(
                                              //         (element) =>
                                              //             element.isSelected ==
                                              //             true);
                                              // if (choice.isCorrect) {
                                              //   CustomToasty.of(context).showSuccess(label(e: "Correct Answer", b: "সঠিক উত্তর"));
                                              //   showOverlay = false;
                                              //   AppEventsNotifier.notify(
                                              //       EventAction.videoWidget);
                                              //   playbackPausePlayStreamController
                                              //       .add(DataLoadedState<bool>(
                                              //       true));
                                              // }
                                            },
                                            builder: (BuildContext context,
                                                int index, item) {
                                              return OverlayMCQAnswerOptionWidget(
                                                value: item.choiceText,
                                                isSelected: item.isSelected,
                                                onTap: () => setState(() {
                                                  item.isSelected =
                                                  !item.isSelected;
                                                  // for (VideoChoiceDataEntity videoChoice
                                                  //     in data.choices) {
                                                  //   if (data.choices.indexOf(
                                                  //           videoChoice) !=
                                                  //       index) {
                                                  //     item.isSelected = false;
                                                  //   } else {
                                                  //     item.isSelected =
                                                  //         !item.isSelected;
                                                  //   }
                                                  // }
                                                }),
                                              );
                                            },
                                          ),
                                        )
                                      : Container();
                                },
                                emptyBuilder: (context, message, icon) =>
                                    Container()),
                            // Positioned(
                            //   top: 80,
                            //   left: .45.sw,
                            //   child: Visibility(
                            //     visible: _onTouch,
                            //     child:  GestureDetector(
                            //       onTap: (){
                            //         _timer?.cancel();
                            //
                            //         // pause while video is playing, play while video is pausing
                            //         setState(() {
                            //           _controller!.value.isPlaying ?
                            //           _controller!.pause() :
                            //           _controller!.play();
                            //         });
                            //
                            //         // Auto dismiss overlay after 1 second
                            //         _timer = Timer.periodic(Duration(milliseconds: 2000), (_) {
                            //           setState(() {
                            //             _onTouch = false;
                            //           });
                            //         });
                            //       },
                            //       child: CircleAvatar(
                            //           backgroundColor: Colors.grey.withOpacity(0.5),
                            //           radius: 25,
                            //           child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,)),
                            //     ),
                            //
                            //
                            //   ),
                            // )
                          ],
                        )
                        // _controller!.value.isInitialized
                        //     ? Stack(
                        //   fit: StackFit.loose,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           _onTouch == true
                        //               ? _onTouch = false
                        //               : _onTouch = true;
                        //         });
                        //
                        //         /*  playVideo == true
                        //                 ? _controller!.pause()
                        //                 : _controller!.play();*/
                        //       },
                        //       child: AspectRatio(
                        //         aspectRatio: 16 / 9,
                        //         // child: VideoPlayer(_controller!),
                        //         //   child: Chewie(
                        //         //     controller: _chewieController!,
                        //         //   ),
                        //           child: ContentPlayerWidget(
                        //             playerStream: videoDetailsDataStreamController.stream,
                        //             playbackStream: playbackPausePlayStreamController.stream,
                        //             // onProgressChanged: onPlaybackProgressChanged,
                        //             // interceptSeekTo: onInterceptPlaybackSeekToPosition,
                        //             overlay: GestureDetector(
                        //               onTap: (){},
                        //               child: const Icon(Icons.arrow_back)
                        //             ),
                        //           ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //         top: size.h16,
                        //         left: size.w16,
                        //         child: InkWell(
                        //           onTap: () {
                        //             Navigator.pop(context);
                        //           },
                        //           child: Icon(
                        //             Icons.arrow_back,
                        //             color: clr.shadeWhiteColor2,
                        //             size: size.r20,
                        //           ),
                        //         )),
                        //     // Positioned(
                        //     //   top: 80,
                        //     //   left: .45.sw,
                        //     //   child: Visibility(
                        //     //     visible: _onTouch,
                        //     //     child:  GestureDetector(
                        //     //       onTap: (){
                        //     //         _timer?.cancel();
                        //     //
                        //     //         // pause while video is playing, play while video is pausing
                        //     //         setState(() {
                        //     //           _controller!.value.isPlaying ?
                        //     //           _controller!.pause() :
                        //     //           _controller!.play();
                        //     //         });
                        //     //
                        //     //         // Auto dismiss overlay after 1 second
                        //     //         _timer = Timer.periodic(Duration(milliseconds: 2000), (_) {
                        //     //           setState(() {
                        //     //             _onTouch = false;
                        //     //           });
                        //     //         });
                        //     //       },
                        //     //       child: CircleAvatar(
                        //     //           backgroundColor: Colors.grey.withOpacity(0.5),
                        //     //           radius: 25,
                        //     //           child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,)),
                        //     //     ),
                        //     //
                        //     //
                        //     //   ),
                        //     // )
                        //   ],
                        // )
                        //     : const Center(child: CircularProgressIndicator()),
                      ] else ...[
                        ///Activate Youtube video player
                        YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _youtubeController!,
                            aspectRatio: 16 / 9,
                            showVideoProgressIndicator: true,
                            progressColors: ProgressBarColors(
                                backgroundColor: clr.progressBGColor,
                                playedColor: clr.appSecondaryColorFlagRed,
                                handleColor: clr.appSecondaryColorFlagRed),
                          ),
                          builder: (context, player) {
                            return Column(
                              children: [
                                Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    player,
                                    Positioned(
                                        top: size.h16,
                                        left: size.w16,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: clr.shadeWhiteColor2,
                                            size: size.r20,
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            );
                          },
                        )
                      ],

                      ///Details section
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.h16),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.w16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          label(
                                              e: data.videoData!.titleEn,
                                              b: data.videoData!.titleEn),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontFamily:
                                                  StringData.fontFamilyPoppins,
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.textSmall,
                                              color: clr.appPrimaryColorGreen),
                                        ),
                                      ),

                                      ///Todo Add later
                                      // Icon(
                                      //   Icons.download,
                                      //   size: size.r20,
                                      //   color: clr.appPrimaryColorGreen,
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(left: size.w8),
                                        child: CustomSwitchButton(
                                          value: App.currentAppLanguage ==
                                              AppLanguage.english,
                                          textOn: 'EN',
                                          textSize: size.textXXSmall,
                                          textOff: 'বাং',
                                          bgColor: clr.whiteColor,
                                          width: 64.w,
                                          animationDuration:
                                              const Duration(milliseconds: 300),
                                          onChanged: (bool state) {
                                            App.setAppLanguage(state ? 1 : 0)
                                                .then((value) {
                                              if (mounted) {
                                                setState(() {});
                                              }
                                              /*AppEventsNotifier.notify(
                                            EventAction.courseDetailsScreen);
                                        AppEventsNotifier.notify(
                                            EventAction.onGoingCoursesScreen);
                                        AppEventsNotifier.notify(
                                            EventAction.dashBoardScreen);
                                        AppEventsNotifier.notify(
                                            EventAction.bottomNavBar);
                                        AppEventsNotifier.notify(
                                            EventAction.graphChart);*/
                                            });
                                          },
                                          buttonHolder: const Icon(
                                            Icons.check,
                                            color: Colors.transparent,
                                          ),
                                          onTap: () {},
                                          onDoubleTap: () {},
                                          onSwipe: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.h8),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.w16),
                                  child: Text(
                                    label(
                                        e: screenArgs.data.contentTitleEn,
                                        b: screenArgs.data.contentTitleBn),
                                    style: TextStyle(
                                        fontFamily:
                                            StringData.fontFamilyPoppins,
                                        fontSize: size.textSmall,
                                        fontWeight: FontWeight.w400,
                                        color: clr.textColorBlack),
                                  ),
                                ),
                                SizedBox(height: size.h16),
                                TabSectionWidget(
                                  tabTitle1:
                                      label(e: en.transcript, b: bn.transcript),
                                  videoDataEntity: data.videoData!,
                                  contentType: screenArgs.data.contentType,
                                )
                              ],
                            );
                            // return SingleChildScrollView(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       ///Title and Details section
                            //       SizedBox(height: size.h16),
                            //       Padding(
                            //         padding: EdgeInsets.symmetric(horizontal: size.w16),
                            //         child: Row(
                            //           children: [
                            //             Expanded(
                            //               child: Text(
                            //                 label(
                            //                     e: "Video 1: Course Introduction",
                            //                     b: "ভিডিও ১: কোর্সের পরিচিতি"),
                            //                 overflow: TextOverflow.ellipsis,
                            //                 maxLines: 1,
                            //                 style: TextStyle(
                            //                     fontFamily: StringData.fontFamilyPoppins,
                            //                     fontWeight: FontWeight.w600,
                            //                     fontSize: size.textSmall,
                            //                     color: clr.appPrimaryColorGreen),
                            //               ),
                            //             ),
                            //             Icon(
                            //               Icons.download,
                            //               size: size.r20,
                            //               color: clr.appPrimaryColorGreen,
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.only(left: size.w8),
                            //               child: CustomSwitchButton(
                            //                 value: App.currentAppLanguage ==
                            //                     AppLanguage.english,
                            //                 textOn: 'EN',
                            //                 textSize: size.textXXSmall,
                            //                 textOff: 'বাং',
                            //                 bgColor: clr.whiteColor,
                            //                 width: 64.w,
                            //                 animationDuration:
                            //                     const Duration(milliseconds: 300),
                            //                 onChanged: (bool state) {
                            //                   App.setAppLanguage(state ? 1 : 0)
                            //                       .then((value) {
                            //                     if (mounted) {
                            //                       setState(() {});
                            //                     }
                            //                     AppEventsNotifier.notify(
                            //                         EventAction.courseDetailsScreen);
                            //                     AppEventsNotifier.notify(
                            //                         EventAction.onGoingCoursesScreen);
                            //                     AppEventsNotifier.notify(
                            //                         EventAction.dashBoardScreen);
                            //                     AppEventsNotifier.notify(
                            //                         EventAction.bottomNavBar);
                            //                     AppEventsNotifier.notify(
                            //                         EventAction.graphChart);
                            //                   });
                            //                 },
                            //                 buttonHolder: const Icon(
                            //                   Icons.check,
                            //                   color: Colors.transparent,
                            //                 ),
                            //                 onTap: () {},
                            //                 onDoubleTap: () {},
                            //                 onSwipe: () {},
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       SizedBox(height: size.h8),
                            //       Padding(
                            //         padding: EdgeInsets.symmetric(horizontal: size.w16),
                            //         child: Text(
                            //           label(
                            //               e: "Traditional Concepts of Interconnected Formal Education",
                            //               b: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা"),
                            //           style: TextStyle(
                            //               fontFamily: StringData.fontFamilyPoppins,
                            //               fontSize: size.textSmall,
                            //               fontWeight: FontWeight.w400,
                            //               color: clr.textColorBlack),
                            //         ),
                            //       ),
                            //       SizedBox(height: size.h16),
                            //
                            //       ///Transcript, Discussions & Notes section
                            //       SectionTabWidget(
                            //         key: _bodyKey,
                            //         onTabChange: (value) {},
                            //         builder: (context, index) {
                            //           switch (index) {
                            //             ///Transcript
                            //             case 0:
                            //               return Container(
                            //                 color: Colors.red,
                            //                 height: 100,
                            //                 width: 100,
                            //               );
                            //
                            //             ///Notes
                            //             case 1:
                            //               return Container(
                            //                 color: Colors.green,
                            //                 height: 100,
                            //                 width: 100,
                            //               );
                            //
                            //             ///Discussions
                            //             case 2:
                            //               return Container(
                            //                 color: Colors.black,
                            //                 height: 100,
                            //                 width: 100,
                            //               );
                            //
                            //             ///Loading state
                            //             default:
                            //               return Container();
                            //           }
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // );
                          }),
                        ),
                    ],
                  )

                  // ///Back Button
                  // const  Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Offstage()
                  // ),

                  // SafeArea(
                  // child: CustomYoutubePlayer(
                  //   videoUrl: "uGqidUUFzwY",
                  //   body: Expanded(
                  //     child: ListView(
                  //       physics: const BouncingScrollPhysics(),
                  //       padding: EdgeInsets.only(
                  //           top: size.h16, right: size.w16, left: size.w16),
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 label(
                  //                     e: "Video 1: Course Introduction",
                  //                     b: "ভিডিও ১: কোর্সের পরিচিতি"),
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(
                  //                     fontFamily: StringData.fontFamilyPoppins,
                  //                     fontWeight: FontWeight.w600,
                  //                     fontSize: size.textSmall,
                  //                     color: clr.appPrimaryColorGreen),
                  //               ),
                  //             ),
                  //             Icon(
                  //               Icons.download,
                  //               size: size.r20,
                  //               color: clr.appPrimaryColorGreen,
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.only(left: size.w8),
                  //               child: CustomSwitchButton(
                  //                 value: App.currentAppLanguage == AppLanguage.english,
                  //                 textOn: 'EN',
                  //                 textSize: size.textXXSmall,
                  //                 textOff: 'বাং',
                  //                 bgColor: clr.whiteColor,
                  //                 width: 64.w,
                  //                 animationDuration: const Duration(milliseconds: 300),
                  //                 onChanged: (bool state) {
                  //                   App.setAppLanguage(state ? 1 : 0).then((value) {
                  //                     if (mounted) {
                  //                       setState(() {});
                  //                     }
                  //                     AppEventsNotifier.notify(
                  //                         EventAction.courseDetailsScreen);
                  //                     AppEventsNotifier.notify(
                  //                         EventAction.onGoingCoursesScreen);
                  //                     AppEventsNotifier.notify(
                  //                         EventAction.dashBoardScreen);
                  //                     AppEventsNotifier.notify(EventAction.bottomNavBar);
                  //                     AppEventsNotifier.notify(EventAction.graphChart);
                  //                   });
                  //                 },
                  //                 buttonHolder: const Icon(
                  //                   Icons.check,
                  //                   color: Colors.transparent,
                  //                 ),
                  //                 onTap: () {},
                  //                 onDoubleTap: () {},
                  //                 onSwipe: () {},
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(height: size.h8),
                  //         Text(
                  //           label(
                  //               e: "Traditional Concepts of Interconnected Formal Education",
                  //               b: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা"),
                  //           style: TextStyle(
                  //               fontFamily: StringData.fontFamilyPoppins,
                  //               fontSize: size.textSmall,
                  //               fontWeight: FontWeight.w400,
                  //               color: clr.textColorBlack),
                  //         ),
                  //         SizedBox(height: size.h12),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             CustomButton(
                  //               onTap: () => Get.to(() => const NoteEditScreen()),
                  //               icon: Icons.add,
                  //               title: label(e: en.takeNotes, b: bn.takeNotes),
                  //               textSize: size.textXXXSmall,
                  //               horizontalPadding: size.w10,
                  //               verticalPadding: 6.5.h,
                  //               radius: size.w8,
                  //             ),
                  //             SizedBox(width: size.w16),
                  //             CustomButton(
                  //               // onTap: onTapDiscussion,
                  //               onTap: () {},
                  //               icon: Icons.add,
                  //               title: label(e: en.discussion, b: bn.discussion),
                  //               textSize: size.textXXXSmall,
                  //               horizontalPadding: size.w10,
                  //               verticalPadding: 6.5.h,
                  //               radius: size.w8,
                  //             )
                  //           ],
                  //         ),
                  //         SizedBox(height: size.h16),
                  //         Text(
                  //           label(e: en.transcript, b: bn.transcript),
                  //           overflow: TextOverflow.ellipsis,
                  //           maxLines: 1,
                  //           style: TextStyle(
                  //               fontFamily: StringData.fontFamilyPoppins,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: size.textSmall,
                  //               color: clr.appPrimaryColorGreen),
                  //         ),
                  //         SizedBox(height: size.h8),
                  //         ExpandableText(
                  //           text: label(
                  //               e: StringData.transcriptTitle2Description,
                  //               b: StringData.transcriptTitle2DescriptionBn),
                  //           style: TextStyle(
                  //               fontFamily: StringData.fontFamilyPoppins,
                  //               fontSize: size.textSmall,
                  //               fontWeight: FontWeight.w400,
                  //               color: clr.textColorBlack),
                  //           minimumTextLengthToFold: 200,
                  //         ),
                  //         SizedBox(height: size.h56),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 106.w),
                  //           child: CustomButton(
                  //             onTap: () {},
                  //             title: label(e: en.next, b: bn.next),
                  //             verticalPadding: 2.h,
                  //             radius: size.w4,
                  //           ),
                  //         ),
                  //         SizedBox(height: size.h56),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
          emptyBuilder: (context, message, icon) => EmptyWidget(
            message: message,
            constraints: constraints,
            offset: 350.w,
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  // void setVideo(String url, String category) {
  //   if(category == VideoCategory.s3.name){
  //     _controller = VideoPlayerController.networkUrl(
  //         Uri.parse("http://116.204.155.53/$url"))
  //       ..initialize().then((_) {
  //         Future.delayed((const Duration(microseconds: 100))).then((value) {
  //           setState(() {
  //             _chewieController = ChewieController(
  //               videoPlayerController: _controller!,
  //               autoPlay: true,
  //               looping: true,
  //
  //               // Try playing around with some of these other options:
  //
  //               showControls: true,
  //
  //               materialProgressColors: ChewieProgressColors(
  //                 playedColor: Colors.red,
  //                 handleColor: Colors.grey,
  //                 backgroundColor: Colors.grey,
  //                 bufferedColor: Colors.grey,
  //               ),
  //               //
  //               // placeholder: Container(
  //               //   color: Colors.grey,
  //               // ),
  //               autoInitialize: true,
  //             );
  //           });
  //         });
  //       });
  //   }else{
  //     _youtubeController = YoutubePlayerController(
  //       initialVideoId: url.split("=").last,
  //       flags: const YoutubePlayerFlags(
  //           mute: false,
  //           autoPlay: false,
  //           disableDragSeek: false,
  //           loop: false,
  //           isLive: false,
  //           forceHD: false,
  //           enableCaption: true,
  //           showLiveFullscreenButton: true),
  //     );
  //   }
  //
  //   // _controller = VideoPlayerController.networkUrl(
  //   //     Uri.parse(url))
  //   //   ..initialize().then((_) {
  //   //     Future.delayed((const Duration(microseconds: 100))).then((value) {
  //   //       setState(() {});
  //   //     });
  //   //   });
  // }

  @override
  void navigateToBack() {
    Navigator.of(context).pop();
  }

  @override
  bool isPlayerFullscreen() {
    return MediaQuery.of(context).orientation != Orientation.portrait;
  }

  @override
  void changeOrientationToPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void setYoutubeVideo(String url) {
    _youtubeController = YoutubePlayerController(
      initialVideoId: url.split("=").last,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: true),
    );
  }

  @override
  void onEventReceived(EventAction action) {
    if (mounted) {
      if (action == EventAction.videoWidget) {
        setState(() {});
      }
    }
  }
}

class SectionTabWidget extends StatefulWidget {
  final Widget Function(BuildContext context, int index) builder;
  final void Function(MapEntry<int, String>) onTabChange;
  const SectionTabWidget(
      {Key? key, required this.builder, required this.onTabChange})
      : super(key: key);

  @override
  State<SectionTabWidget> createState() => _SectionTabWidgetState();
}

class _SectionTabWidgetState extends State<SectionTabWidget> with AppTheme {
  final Map<int, String> _options = {
    0: "Transcript",
    1: "Notes",
    2: "Discussion"
  };
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: clr.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.h12,
              right: size.h12,
              top: size.h12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _options.entries
                  .map((e) => GestureDetector(
                        onTap: () => onTabChange(e.key),
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: size.h8),
                          child: Text(
                            " ${e.value} ",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: e.key == _selectedIndex
                                      ? clr.appPrimaryColorGreen
                                      : clr.textColorBlack,
                                  offset: Offset(0, -size.h12),
                                ),
                              ],
                              color: Colors.transparent,
                              fontSize: size.textSmall,
                              fontWeight: e.key == _selectedIndex
                                  ? FontWeight.w600
                                  : null,
                              decoration: TextDecoration.underline,
                              decorationColor: e.key == _selectedIndex
                                  ? clr.appPrimaryColorGreen
                                  : Colors.transparent,
                              decorationThickness: 1.6.w,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Divider(
            thickness: 1.w,
            // height: 5.w,
            color: clr.greyColor,
          ),
          widget.builder(context, _selectedIndex)
        ],
      ),
    );
  }

  onTabChange(int key) {
    if (mounted && _selectedIndex != key) {
      setState(() {
        _selectedIndex = key;
      });
      widget.onTabChange(
          _options.entries.firstWhere((m) => m.key == _selectedIndex));
    }
  }
}
