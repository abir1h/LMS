import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({
    super.key,
  });

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.assessment, b: bn.assessment),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w20, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
            ],
          ),
        ));
  }
}
