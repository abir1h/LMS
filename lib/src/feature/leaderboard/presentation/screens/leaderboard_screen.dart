import 'package:flutter/material.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../widgets/leaderboard_item_section_widget.dart';
import '../../widgets/leaderboard_item_widget.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with AppTheme, Language {
  List<LeaderBoardDataEntity> leaderBoardList=[
    LeaderBoardDataEntity(position: label(e: '1st', b: '১ম'), name: label(e: 'Mynul Islam', b: 'মাইনুল ইসলাম'), emisUserId: label(e: '101353764', b: replaceEnglishNumberWithBengali('101353764'))),
    LeaderBoardDataEntity(position: label(e: '2nd', b: '২য়'), name: label(e: 'Tushar Imran', b: 'তুষার ইমরান'), emisUserId: label(e: '101353764', b: replaceEnglishNumberWithBengali('101353764'))),
    LeaderBoardDataEntity(position: label(e: '3rd', b: '৩য়'), name: label(e: 'Mr. Rashid', b: 'রশিদ সাহেব'), emisUserId:label(e: '101353764', b: replaceEnglishNumberWithBengali('101353764')))
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.leaderboard, b: bn.leaderboard),
      body: LeaderboardItemSectionWidget(
        items:leaderBoardList,
        buildItem: (BuildContext context, int index, item) {
          return  LeaderboardItemWidget(data: item, onTap: () {   },);
        },
      ),
    );
  }
}
