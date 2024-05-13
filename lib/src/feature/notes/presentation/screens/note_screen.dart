import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/src/core/common_widgets/custom_toasty.dart';
import 'package:lms/src/core/utility/app_label.dart';
import 'package:lms/src/feature/notes/domain/entities/note_data_entity.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/paginated_list_view.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../controllers/note_controller.dart';
import '../service/note_screen_service.dart';
import '../widgets/note_tile.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AppTheme, Language, AppEventsNotifier, NoteScreenService {
  final List<dynamic> contents = [
    {
      "insert":
          "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া."
    },
    {
      "attributes": {"code-block": true},
      "insert": "\n\n\n"
    },
    {"insert": "\n"}
  ];

  final controller = Get.put(NoteController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.h12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.h16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<int>(
                    color: clr.whiteColor,
                    surfaceTintColor: clr.whiteColor,
                    padding: EdgeInsets.only(
                        left: size.h12,
                        right: 40.w,
                        bottom: size.h20,
                        top: size.h12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.r8)),
                    position: PopupMenuPosition.under,
                    onSelected: (int value) {
                      setState(() {
                        selectedValue = value;
                        if (value == 1) {
                          loadNotesData(1, sortBy: null, sortDesc: true);
                        } else {
                          String? sortBy = (value == 2) ? 'created_at' : 'updated_at';
                          loadNotesData(1, sortBy:sortBy,sortDesc:  null);
                        }
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: SizedBox(
                          width: 1.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                label(e: "Title", b: "টাইটেল"),
                                style: selectedValue == 1
                                    ? TextStyle(
                                        color: clr.appPrimaryColorGreen,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins,
                                        fontSize: size.textSmall)
                                    : TextStyle(
                                        color: clr.blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins,
                                        fontSize: size.textSmall),
                              ),
                              SizedBox(width: size.w8),
                              if (selectedValue == 1)
                                Icon(
                                  Icons.check,
                                  color: clr.appPrimaryColorGreen,
                                ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label(e: 'Date Created', b: 'ডেট ক্রিটেড'),
                              style: selectedValue == 2
                                  ? TextStyle(
                                      color: clr.appPrimaryColorGreen,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: StringData.fontFamilyPoppins,
                                      fontSize: size.textSmall)
                                  : TextStyle(
                                      color: clr.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: StringData.fontFamilyPoppins,
                                      fontSize: size.textSmall),
                            ),
                            SizedBox(width: size.w8),
                            if (selectedValue == 2)
                              Icon(
                                Icons.check,
                                color: clr.appPrimaryColorGreen,
                                size: size.r24,
                              ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label(e: 'Date Modified', b: 'ডেট মডিফাইড'),

                              style: selectedValue == 3
                                  ? TextStyle(
                                      color: clr.appPrimaryColorGreen,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: StringData.fontFamilyPoppins,
                                      fontSize: size.textSmall)
                                  : TextStyle(
                                      color: clr.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: StringData.fontFamilyPoppins,
                                      fontSize: size.textSmall),
                            ),
                            SizedBox(width: size.w8),
                            if (selectedValue == 3)
                              Icon(
                                Icons.check,
                                color: clr.appPrimaryColorGreen,
                                size: size.r24,
                              ),
                          ],
                        ),
                      ),
                    ],
                    child: Padding(
                      padding: EdgeInsets.only(right: size.w4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: clr.appPrimaryColorGreen,
                            size: size.r16,
                          ),
                          SizedBox(width: size.w8),
                          Text(
                            selectedValue == 1
                                ?  label(e: "Title", b: "টাইটেল")
                                : selectedValue == 2
                                    ? label(e: 'Date Created', b: 'ডেট ক্রিটেড')
                                    :   label(e: 'Date Modified', b: 'ডেট মডিফাইড'),
                            style: TextStyle(
                              color: clr.textColorBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: size.textXSmall,
                              fontFamily: StringData.fontFamilyPoppins,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.h8),
                    Expanded(
              child:
                  AppStreamBuilder<PaginatedListViewController<NoteDataEntity>>(
                stream: pageStateStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(child: CircularLoader());
                },
                dataBuilder: (context, data) {
                  return PaginatedListView<NoteDataEntity>(
                    controller: paginationController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.h16,
                    ),
                    itemBuilder: (context, item, index) {
                      return NoteItemWidget(
                        noteDataEntity: item,
                        onDelete: () => _onDelete(noteId: item.id!),
                        onPressed: () => onTapNote(item),
                      );
                    },
                    separatorBuilder: (context) {
                      return SizedBox(
                        height: size.h16,
                      );
                    },
                    loaderBuilder: (context) => Padding(
                      padding: EdgeInsets.all(4.0.w),
                      child: Center(
                        child: CircularLoader(
                          loaderSize: 16.w,
                        ),
                      ),
                    ),
                  );
                  // return NoteItemSectionWidget(
                  //     items: data,
                  //     buildItem: (context, index, item) {
                  //       return item.book != null ? NoteItemWidget(
                  //         noteDataEntity: item,
                  //         onDelete: () => _onDelete(noteId: item.id!),
                  //         onPressed: () => onTapNote(item),
                  //       ) : const Offstage();
                  //     });
                },
                emptyBuilder: (context, message, icon) => EmptyWidget(
                  message: message,
                  constraints: constraints,
                  offset: 350.w,
                ),
              ),
            ),
            // SizedBox(height: size.h64),
          ],
        ),
      ),
    );
  }

  void _onDelete({required int noteId}) {
    CustomDialogWidget.show(
            context: context,
            title: "Do you want to delete Notes?",
            infoText: "Are you Sure?")
        .then((x) {
      if (!x) {
        onNotesDelete(noteId);
      }
    });
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.notesScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void onNavigateToNoteDetailsScreen(NoteDataEntity noteDataEntity) {
    Navigator.of(context).pushNamed(AppRoute.noteDetailsScreen,
        arguments: NoteDetailsScreenArgs(
            noteDataEntity: noteDataEntity, noteType: NoteType.edit));
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}

class NoteItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const NoteItemSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

class NoteItemWidget extends StatelessWidget with AppTheme {
  final NoteDataEntity noteDataEntity;
  final VoidCallback onDelete;
  final VoidCallback onPressed;
  const NoteItemWidget({
    super.key,
    required this.noteDataEntity,
    required this.onDelete,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.h8, horizontal: size.h4),
        decoration: BoxDecoration(
          color: clr.noteBoxColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 4,
                spreadRadius: 0,
                color: clr.blackColor.withOpacity(.2))
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r12),
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  noteDataEntity.title,
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
                          noteDataEntity.title,
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
                  SizedBox(height: size.h4),
                  noteDataEntity.contentTitleEn!.isNotEmpty ||
                          noteDataEntity.contentTitleBn!.isNotEmpty
                      ? Text(
                          label(
                              e: noteDataEntity.contentTitleEn!,
                              b: noteDataEntity.contentTitleBn!),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.textXSmall,
                              fontFamily: StringData.fontFamilyPoppins,
                              color: clr.appPrimaryColorGreen),
                        )
                      : const SizedBox(),
                  SizedBox(height: size.h4),
                  Row(
                    mainAxisAlignment:
                        noteDataEntity.contentTitleEn!.isNotEmpty ||
                                noteDataEntity.contentTitleBn!.isNotEmpty
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "তারিখ: ${label(e: DateFormat('dd MMMM yyyy').format(
                                DateTime.parse(noteDataEntity.createdAt!),
                              ), b: timeAgoToBengali(DateFormat('dd MMMM yyyy').format(DateTime.parse(noteDataEntity.createdAt!))))}",
                          style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontWeight: FontWeight.w400,
                            fontSize: size.textXXSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: /*reference != null
                              ? TextAlign.end
                              : */
                              TextAlign.start,
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
    /*GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.h8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  width: size.w1,
                  color: clr.boxStrokeColor,
                ))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(size.r12),
                decoration: BoxDecoration(
                  color: clr.shadeWhiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(size.r10)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                 " AppUtility.parseHtmlToText(noteDataEntity.note)",
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
            SizedBox(width: size.w12),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Html(
                          data: noteDataEntity.note,
                          shrinkWrap: true,
                          style: {
                            '#': Style(
                              color: clr.appPrimaryColorBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize(size.textSmall),
                              fontFamily: StringData.fontFamilyPoppins,
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: onDelete,
                        child: SvgPicture.asset(
                          ImageAssets.icDelete,
                          height: size.h20,
                          colorFilter: ColorFilter.mode(
                              clr.iconColorSweetRed, BlendMode.srcIn),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.h4),
                  Padding(
                    padding: EdgeInsets.only(left: size.w8),
                    child: noteDataEntity.book != null ? Text(
                      label(
                          e: noteDataEntity.book!.titleEn,
                          b: noteDataEntity.book!.titleEn),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.textXSmall,
                          fontFamily: StringData.fontFamilyPoppins,
                          color: clr.appSecondaryColorPurple),
                    ) : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "তারিখ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(noteDataEntity.createdAt!))}",
                          style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontWeight: FontWeight.w500,
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
    )*/

  }
}
