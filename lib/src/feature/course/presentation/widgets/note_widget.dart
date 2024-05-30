import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../../notes/domain/entities/note_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../services/course_note_service.dart';
import 'note_bottom_sheet.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../notes/presentation/controllers/note_controller.dart';

class NoteWidget extends StatefulWidget {
  final ScrollPhysics? physics;
  final int courseModuleId;
  final int contentId;
  final String contentType;
  const NoteWidget(
      {super.key,
      this.physics,
      required this.courseModuleId,
      required this.contentId,
      required this.contentType});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget>
    with AppTheme, Language, AppEventsNotifier, CourseNoteWidgetService {
  final controller = Get.put(NoteController());
  // void onTapCreateDiscussion() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) => const NoteBottomSheet(),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeDateFormatting();
      loadNoteList(widget.contentId, widget.contentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<NoteDataEntity>>(
      stream: noteDataStreamController.stream,
      loadingBuilder: (context) {
        return const Center(child: CircularLoader());
      },
      dataBuilder: (context, data) {
        return Stack(
          children: [
            data.isNotEmpty
                ? NoteItemSectionWidget(
                    items: data,
                    buildItem: (BuildContext context, int index, item) {
                      return NoteWidgetTile(
                        noteContent: item.title,
                        title: item.title,
                        timestamp: DateFormat('dd MMMM yyyy', label(e: "en", b: "bn"))
                            .format(DateTime.parse(item.createdAt ?? "")),
                        onPressed: () => showCupertinoModalPopup(
                          context: context,
                          builder: (context) => NoteBottomSheet(
                            arguments: NoteDetailsScreenArgs(
                              noteType: NoteType.edit,
                              noteDataEntity: item,
                            ),
                            onSuccess: () {
                              Navigator.of(context).pop();
                              loadNoteList(
                                  widget.contentId, widget.contentType);
                            },
                          ),
                        ),
                        onDelete: () => _onDelete(noteId: item.id!),
                      );
                    })
                : Center(
                    child: Column(
                      children: [
                        Lottie.asset(ImageAssets.animEmpty,
                            height: size.h64 * 3),
                        CustomTextWidget(
                          text: label(
                              e: "No Notes Found", b: "কোন নোট পাওয়া যায়নি"),
                          textColor: clr.textColorBlack,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => NoteBottomSheet(
                    arguments: NoteDetailsScreenArgs(
                      noteType: NoteType.create,
                      noteDataEntity: NoteDataEntity(
                          courseModuleId: widget.courseModuleId,
                          contentId: widget.contentId,
                          contentType: widget.contentType,
                          title: "",
                          description: "",
                          status: 1),
                    ),
                    onSuccess: () {
                      Navigator.of(context).pop();
                      loadNoteList(widget.contentId, widget.contentType);
                    },
                  ),
                ),
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: clr.whiteColor,
                      border: Border(
                          top: BorderSide(
                              color: clr.boxStrokeColor, width: 1.w))),
                  padding: EdgeInsets.all(size.r16),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.r10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: clr.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          ImageAssets.icEditSquare,
                        ),
                      ),
                      SizedBox(
                        width: size.w8,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 14.w,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              color: clr.shadeWhiteColor2,
                              borderRadius: BorderRadius.circular(size.r8),
                              border: Border.all(color: clr.boxStrokeColor)),
                          child: Text(
                            label(e: "Take Note", b: "নোটস নিন"),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: clr.placeHolderTextColorGray,
                                fontSize: size.textSmall),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
      emptyBuilder: (context, message, icon) => CustomEmptyWidget(
        message: message,
        title: label(
            e: "No Notes Found", b: "কোন নোট পাওয়া যায়নি"),
        // constraints: constraints,
        // offset: 350.w,
      ),
    );
    // return Stack(
    //   children: [
    //     Obx(
    //       () => ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: controller.noteList.length,
    //           physics: widget.physics ?? const BouncingScrollPhysics(),
    //           padding: EdgeInsets.only(bottom: size.h64 * 2),
    //           itemBuilder: (_, index) {
    //             return NoteWidgetTile(
    //               noteContent:
    //                   controller.noteList[index].title.toString().isNotEmpty
    //                       ? controller.noteList[index].title.toString()
    //                       : controller.noteList[index].description != null
    //                           ? Document.fromJson(controller
    //                                   .noteList[index].description as List)
    //                               .toPlainText()
    //                           : "New Note",
    //               title: controller.noteList[index].title.toString().isNotEmpty
    //                   ? controller.noteList[index].title.toString()
    //                   : controller.noteList[index].description != null
    //                       ? Document.fromJson(controller
    //                               .noteList[index].description as List)
    //                           .toPlainText()
    //                       : "New Note",
    //               timestamp: DateFormat('dd MMMM yyyy')
    //                   .format(DateTime.parse(controller.noteList[index].time!)),
    //               onPressed: () => showCupertinoModalPopup(
    //                 context: context,
    //                 builder: (context) =>
    //                     NoteBottomSheet(noteModel: controller.noteList[index]),
    //               ),
    //             );
    //           }),
    //     ),
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: GestureDetector(
    //         onTap: () => showCupertinoModalPopup(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (context) => const NoteBottomSheet(),
    //         ),
    //         child: Container(
    //           width: 1.sw,
    //           decoration: BoxDecoration(
    //               color: clr.whiteColor,
    //               border: Border(
    //                   top: BorderSide(color: clr.boxStrokeColor, width: 1.w))),
    //           padding: EdgeInsets.all(size.r16),
    //           child: Row(
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.all(size.r10),
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: clr.whiteColor,
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.withOpacity(0.3),
    //                       spreadRadius: 2,
    //                       blurRadius: 3,
    //                       offset:
    //                           const Offset(0, 5), // changes position of shadow
    //                     ),
    //                   ],
    //                 ),
    //                 child: SvgPicture.asset(
    //                   ImageAssets.icEditSquare,
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: size.w8,
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   padding: EdgeInsets.only(
    //                     left: 14.w,
    //                     top: 10,
    //                     bottom: 10,
    //                   ),
    //                   decoration: BoxDecoration(
    //                       color: clr.shadeWhiteColor2,
    //                       borderRadius: BorderRadius.circular(size.r8),
    //                       border: Border.all(color: clr.boxStrokeColor)),
    //                   child: Text(
    //                     "নোটস নিন",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w400,
    //                         color: clr.placeHolderTextColorGray,
    //                         fontSize: size.textSmall),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  @override
  void onEventReceived(EventAction action) {
    // TODO: implement onEventReceived
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  void _onDelete({required int noteId}) {
    CustomDialogWidget.show(
            context: context,

            title: label(
                e: "Do you want to delete this note?",
                b: "আপনি কি এই নোটটি মুছতে চান?"),
            infoText: label(e: "Are you Sure?", b: "আপনি কি নিশ্চিত?"),
            leftButtonText: label(e: "Cancel", b: "বাতিল করুন"),
            rightButtonText: label(e: "Yes", b: "হ্যাঁ"))
        .then((x) {
      if (x) {
        onNoteDelete(noteId);
        loadNoteList(widget.contentId, widget.contentType);
      }
    });
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}

class NoteItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final ScrollPhysics? physics;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const NoteItemSectionWidget(
      {super.key, this.physics, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      physics: physics ?? const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: size.h64 * 2),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
    );
  }
}

class NoteWidgetTile extends StatelessWidget with AppTheme {
  final String noteContent;
  final String title;
  final String timestamp;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  const NoteWidgetTile(
      {super.key,
      required this.noteContent,
      required this.title,
      required this.timestamp,
      required this.onPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h8),
        decoration: BoxDecoration(
            color: clr.cardFillColorAliceBlue,
            border: Border(
                bottom: BorderSide(
              width: size.w1,
              color: clr.progressBGColor,
            ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteContent,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                    fontSize: size.textXXSmall,
                    color: clr.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: size.w16),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: clr.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.textSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                          onTap: onDelete,
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: size.r24,
                          ))
                    ],
                  ),
                  SizedBox(height: size.h8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "তারিখ: $timestamp",
                          style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontWeight: FontWeight.w400,
                            fontSize: size.textXXSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
