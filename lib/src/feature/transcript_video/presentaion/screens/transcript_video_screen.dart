import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../discussion/presentation/screens/discussion_screen.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_expanded_text.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/utility/app_label.dart';
import '../../../notes/presentation/screens/note_edit_screen.dart';
import '../widgets/youtube_player.dart';

class TranscriptVideoScreen extends StatefulWidget {
  const TranscriptVideoScreen({super.key});

  @override
  State<TranscriptVideoScreen> createState() => _TranscriptVideoScreenState();
}

class _TranscriptVideoScreenState extends State<TranscriptVideoScreen>
    with AppTheme, Language {
  YoutubePlayerController? _controller;
  final GlobalKey _bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: "uGqidUUFzwY",
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
  bool playerFlag=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  SafeArea(
        top: MediaQuery.of(context).orientation == Orientation.portrait,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ///Page body
            Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  if (playerFlag) ...[
                    ///Activate solid video player
                  ] else if(playerFlag)...[
                    ///Activate HLS video player
                  ] else ...[
                    ///Activate Youtube video player
                    YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: _controller!,
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
                  if(MediaQuery.of(context).orientation == Orientation.portrait)
                    Expanded(
                      child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///Title and Details section

                                  SizedBox(height: 20,),
                                  ///Divider
                                  Container(
                                    color: clr.dividerStrokeColorGrey,
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(height: 20,),
                                  ///Transcript, Discussions & Notes section
                                  SectionTabWidget(
                                    key: _bodyKey,
                                    onTabChange: (value){},
                                    builder: (context, index){
                                      switch(index){
                                      ///Transcript
                                        case 0: return
                                          Container(
                                            color: Colors.red,
                                            height: 100,
                                            width: 100,
                                          );
                                      ///Notes
                                        case 1: return
                                          Container(
                                            color: Colors.green,
                                            height: 100,
                                            width: 100,
                                          );
                                      ///Discussions
                                        case 2: return
                                          Container(
                                            color: Colors.black,
                                            height: 100,
                                            width: 100,
                                          );
                                      ///Loading state
                                        default: return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                ]
            ),


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
              ]
        ),
      ),
    );
  }

  void onTapDiscussion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const DiscussionScreen(),
    );
  }
}


class SectionTabWidget extends StatefulWidget {
  final Widget Function(BuildContext context, int index) builder;
  final void Function(MapEntry<int,String>) onTabChange;
  const SectionTabWidget({Key? key,required this.builder,required this.onTabChange}) : super(key: key);

  @override
  _SectionTabWidgetState createState() => _SectionTabWidgetState();
}
class _SectionTabWidgetState extends State<SectionTabWidget> with AppTheme{
  final Map<int,String> _options = {0:"Transcript",1:"Notes",2:"Discussion"};
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: clr.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.h12,right: size.h12, top: size.h12,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _options.entries.map((e) => GestureDetector(
                onTap: ()=> onTabChange(e.key),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: size.h8),
                  child: Text(
                    " ${e.value} ",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: e.key == _selectedIndex ? clr.appPrimaryColorGreen:clr.textColorBlack,
                          offset: Offset(0, - size.h12),
                        ),
                      ],
                      color: Colors.transparent,
                      fontSize: size.textSmall,
                      fontWeight: e.key == _selectedIndex ? FontWeight.w600:null,
                      decoration: TextDecoration.underline,
                      decorationColor: e.key == _selectedIndex ? clr.appPrimaryColorGreen: Colors.transparent,
                      decorationThickness: 1.6.w,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          Divider(
            thickness: 1.w,
            height: 5.w,
            color: clr.greyColor,
          ),
          widget.builder(context,_selectedIndex)
        ],
      ),
    );
  }

  onTabChange(int key) {
    if(mounted && _selectedIndex != key){
      setState(() {
        _selectedIndex = key;
      });
      widget.onTabChange(_options.entries.firstWhere((m) => m.key == _selectedIndex));
    }
  }
}