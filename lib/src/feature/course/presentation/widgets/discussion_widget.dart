import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/routes/app_route.dart';
import '../../../discussion/domain/entities/discussion_data_entity.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../discussion/presentation/screens/discussion_bottom_sheet.dart';
import '../services/course_discussion_service.dart';

class DiscussionWidget extends StatefulWidget {
  final int courseId;
  final int courseModuleId;
  final int contentId;
  final String contentType;
  final ScrollPhysics? physics;
  const DiscussionWidget({
    super.key,
    required this.courseId,
    required this.courseModuleId,
    required this.contentId,
    required this.contentType,
    this.physics,
  });

  @override
  State<DiscussionWidget> createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget>
    with AppTheme, Language, AppEventsNotifier, CourseDiscussionWidgetService {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadDiscussionList(widget.courseId, widget.courseModuleId,
          widget.contentId, widget.contentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStreamBuilder<List<DiscussionDataEntity>>(
          stream: discussionDataStreamController.stream,
          loadingBuilder: (context) {
            return const Center(child: CircularLoader());
          },
          dataBuilder: (context, data) {
            return DiscussionItemSectionWidget(
                items: data,
                buildItem: (BuildContext context, int index, item) {
                  return DiscussionWidgetTile(
                    data: item,
                    onTap: () => onTapCourse(item.id),
                  );
                });
          },
          emptyBuilder: (context, message, icon) => CustomEmptyWidget(
            message: message,
            // constraints: constraints,
            // offset: 350.w,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            onTap: onTapCreateDiscussion,
            icon: Icons.add_comment,
            radius: 0.0,
            title: label(e: en.newDiscussion, b: bn.newDiscussion),
          ),
        )
      ],
    );
  }

  void onTapCreateDiscussion() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => DiscussionBottomSheet(
        courseId: widget.courseId,
        courseModuleId: widget.courseModuleId,
        contentId: widget.contentId,
        contentType: widget.contentType,
        onSuccess: () {
          Navigator.of(context).pop();
          loadDiscussionList(widget.courseId, widget.courseModuleId,
              widget.contentId, widget.contentType);
        },
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToDetailedDiscussionScreen(int discussionId) {
    Navigator.of(context).pushNamed(
      AppRoute.detailedDiscussion,
      arguments: DetailedDiscussionArgs(discussionId: discussionId),
    );
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.discussion) {
      if (mounted) {
        setState(() {
          loadDiscussionList(widget.courseId, widget.courseModuleId,
              widget.contentId, widget.contentType);
        });
      }
    }
  }
}

class DiscussionItemSectionWidget<T> extends StatelessWidget with AppTheme {
  final ScrollPhysics? physics;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const DiscussionItemSectionWidget(
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

class DiscussionWidgetTile extends StatelessWidget with AppTheme {
  final DiscussionDataEntity data;
  final VoidCallback? onTap;
  const DiscussionWidgetTile({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: size.w16, right: size.w16, top: size.h8, bottom: size.h6),
        decoration: BoxDecoration(
            color: clr.scaffoldBackgroundColor,
            border: Border(
                bottom: BorderSide(color: clr.placeHolderTextColorGray))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.mode_comment,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
            SizedBox(width: size.w8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label(e: data.description, b: data.description),
                    style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.h6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text.rich(
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: clr.placeHolderTextColorGray,
                                fontSize: size.textXXSmall,
                                fontWeight: FontWeight.w500,
                                fontFamily: StringData.fontFamilyPoppins),
                            TextSpan(
                                text: label(e: "Total 1", b: "মোট 1 টি"),
                                children: [
                                  const TextSpan(
                                    text: " | ",
                                  ),
                                  TextSpan(
                                    text: label(
                                        e: DateFormat('dd MMMM yyyy').format(
                                            DateTime.parse(data.createdAt)),
                                        b: DateFormat('dd MMMM yyyy').format(
                                            DateTime.parse(data.createdAt))),
                                    // text: "তারিখ: $time",
                                  ),
                                ])),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
