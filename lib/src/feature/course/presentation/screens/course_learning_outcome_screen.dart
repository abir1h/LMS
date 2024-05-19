import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/empty_widget.dart';

import '../../../../core/common_widgets/custom_empty_widget.dart';
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
      title: label(e: "Learning Outcome", b: "শিখনফল"),
      bgColor: clr.whiteColor,
      body: _screenArgs.text.isNotEmpty
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: label(e: "Learning Outcome", b: "শিখনফল"),
                    textColor: clr.blackColor,
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: size.h8),
                  CustomTextWidget(
                    text: _screenArgs.text,
                  ),
                ],
              ),
            )
          : CustomEmptyWidget(
              message: '',
              title: label(
                  e: "No Learning Outcome Found",
                  b: "কোন শিখনফল পাওয়া যায়নি"),
            ),
    );
  }
}
