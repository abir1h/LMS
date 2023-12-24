import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/constants/app_theme.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:lms/src/feature/assessment/presentation/controllers/assessment_controller.dart';
import 'package:lms/src/feature/assessment/presentation/models/blank_model.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/blank_card.dart';

class FillInTheBlankScreen extends StatefulWidget {
  const FillInTheBlankScreen({super.key});

  @override
  State<FillInTheBlankScreen> createState() => _FillInTheBlankScreenState();
}

class _FillInTheBlankScreenState extends State<FillInTheBlankScreen>
    with AppTheme, Language {
  final controller = Get.put(AssessmentController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "Assessment", b: "মূল্যায়ন"),
        bgColor: clr.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        child: GetBuilder<AssessmentController>(builder: (_) {
          return SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: size.h16, vertical: size.w16),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: controller.qusList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return BlankCard(
                        mainModel: controller.qusList[index],
                        onChangedv1: (v) {
                          controller.qusList[index].blank1=v;

                        },
                        onChangedv2: (v) {
                          controller.qusList[index].blank2=v;

                        },
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onTap: () {

                      },
                      title: label(e: en.submit, b: bn.submit),
                      radius: size.r4,
                      verticalPadding: size.h4,
                      bgColor: clr.appPrimaryColorGreen,
                      textColor: clr.whiteColor,
                      borderColor: clr.appPrimaryColorGreen,
                    ),
                  ],
                )


              ],
            ),
          );
        }));
  }
}
