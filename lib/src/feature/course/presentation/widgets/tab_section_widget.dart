import 'package:flutter/material.dart';

import '../../domain/entities/video_data_entity.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'chapter_details_widget.dart';
import 'discussion_widget.dart';
import 'note_widget.dart';

class TabSectionWidget extends StatefulWidget {
  final String? tabTitle1, tabTitle2, tabTitle3;
  final String contentType;
  final VideoDataEntity videoDataEntity;
  const TabSectionWidget({
    super.key,
    this.tabTitle1,
    this.tabTitle2,
    this.tabTitle3,
    required this.contentType,
    required this.videoDataEntity,
  });

  @override
  State<TabSectionWidget> createState() => _TabSectionWidgetState();
}

class _TabSectionWidgetState extends State<TabSectionWidget>
    with AppTheme, Language, TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar.secondary(
            controller: _tabController,
            labelStyle: TextStyle(
                color: clr.appPrimaryColorGreen,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyPoppins),
            unselectedLabelStyle: TextStyle(
                color: clr.textColorBlack,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
            dividerColor: clr.placeHolderTextColorGray,
            indicatorPadding: EdgeInsets.symmetric(horizontal: size.w16),
            tabs: [
              Tab(
                  text:
                      widget.tabTitle1 ?? label(e: en.details, b: bn.details)),
              Tab(
                  text: widget.tabTitle2 ??
                      label(e: en.notesText, b: bn.notesText)),
              Tab(
                  text: widget.tabTitle3 ??
                      label(e: en.discussion, b: bn.discussion)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChapterDetailsWidget(
                    description: label(
                        e: widget.videoDataEntity.transcriptEn,
                        b: widget.videoDataEntity.transcriptBn)),
                NoteWidget(
                  courseModuleId: widget.videoDataEntity.courseModuleId,
                  contentId: widget.videoDataEntity.id,
                  contentType: widget.contentType,
                ),
                DiscussionWidget(
                    courseId: widget.videoDataEntity.courseId,
                    courseModuleId: widget.videoDataEntity.courseModuleId,
                    contentId: widget.videoDataEntity.id,
                    contentType: widget.contentType),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
