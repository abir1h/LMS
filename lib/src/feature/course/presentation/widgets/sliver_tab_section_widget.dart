import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import 'chapter_details_widget.dart';
import 'discussion_widget.dart';
import 'note_widget.dart';

class SliverTabSectionWidget extends StatefulWidget {
  final String? tabTitle1, tabTitle2, tabTitle3;
  final String? description;
  final Widget? child;
  const SliverTabSectionWidget({
    super.key,
    this.tabTitle1,
    this.tabTitle2,
    this.tabTitle3,
    this.description,
    this.child,
  });

  @override
  State<SliverTabSectionWidget> createState() => _SliverTabSectionWidgetState();
}

class _SliverTabSectionWidgetState extends State<SliverTabSectionWidget>
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: widget.child),
        SliverAppBar(
          pinned: true,
          floating: true,
          automaticallyImplyLeading: false,
          surfaceTintColor: clr.whiteColor,
          flexibleSpace: TabBar.secondary(
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
            physics: const NeverScrollableScrollPhysics(),
            indicatorPadding: EdgeInsets.symmetric(horizontal: size.w16),
            tabs: [
              Tab(
                text: widget.tabTitle1 ?? label(e: en.details, b: bn.details),
              ),
              Tab(
                text:
                    widget.tabTitle2 ?? label(e: en.notesText, b: bn.notesText),
              ),
              Tab(
                text: widget.tabTitle3 ??
                    label(e: en.discussion, b: bn.discussion),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ChapterDetailsWidget(description: widget.description.toString()),
              const NoteWidget(physics: NeverScrollableScrollPhysics()),
              const DiscussionWidget(physics: NeverScrollableScrollPhysics()),
            ],
          ),
        ),
      ],
    );
  }
}
