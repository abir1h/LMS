import 'package:flutter/material.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../widgets/leaderboard_item_section_widget.dart';
import '../../widgets/leaderboard_item_widget.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.leaderboard, b: bn.leaderboard),
      body: LeaderboardItemSectionWidget(
        items: const ["", "", "", "", "", ""],
        buildItem: (BuildContext context, int index, item) {
          return const LeaderboardItemWidget();
        },
      ),
    );
  }
}
