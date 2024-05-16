import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class CourseLearningOutcomeScreen extends StatefulWidget {
  final Object? arguments;
  const CourseLearningOutcomeScreen({super.key, this.arguments});

  @override
  State<CourseLearningOutcomeScreen> createState() =>
      _CourseLearningOutcomeScreenState();
}

class _CourseLearningOutcomeScreenState
    extends State<CourseLearningOutcomeScreen> with AppTheme, Language {
  late CourseLearningOutcomeScreenArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as CourseLearningOutcomeScreenArgs;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: "Learning Outcomes", b: "শিখনফল"),
      bgColor: clr.whiteColor,
      body: SingleChildScrollView(
        child: CustomTextWidget(
          text: _screenArgs.text,
        ),
      ),
    );
  }
}
