import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class CollaborativeAssignmentInstructionScreen extends StatefulWidget {
  final Object? arguments;
  const CollaborativeAssignmentInstructionScreen({super.key, this.arguments});

  @override
  State<CollaborativeAssignmentInstructionScreen> createState() =>
      _CollaborativeAssignmentInstructionScreenState();
}

class _CollaborativeAssignmentInstructionScreenState
    extends State<CollaborativeAssignmentInstructionScreen>
    with AppTheme, Language {
  late AssignmentReviewArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentReviewArgs;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Title
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: clr.boxStrokeColor))),
              child: CustomTextWidget(
                  text: label(
                      e: _screenArgs.assignmentDataEntity!.titleEn,
                      b: _screenArgs.assignmentDataEntity!.titleBn),
                  fontFamily: StringData.fontFamilyPoppins),
            ),
            SizedBox(height: size.h16),
            CustomTextWidget(
              text: label(e: "Assignment Guide", b: "এসাইনমেন্ট সহায়িকা"),
              textColor: clr.blackText,
              padding: EdgeInsets.symmetric(horizontal: size.w16),
            ),
            SizedBox(height: size.h8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.w16),
              padding: EdgeInsets.symmetric(
                  horizontal: size.w10, vertical: size.h12),
              decoration: BoxDecoration(
                color: clr.scaffoldBackgroundColor,
                border: Border.all(color: clr.cardStrokeColorGrey2),
                borderRadius: BorderRadius.circular(size.r8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: 8,
                    color: clr.gapStrokeGrey.withOpacity(.15),
                  )
                ],
              ),
              child: CustomTextWidget(
                text: label(
                    e: _screenArgs.assignmentDataEntity!.instructionsEn,
                    b: _screenArgs.assignmentDataEntity!.instructionsBn),
                textColor: clr.gapStrokeGrey,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyRoboto,
                fontSize: size.textSmall,
              ),
            ),
            SizedBox(height: size.h32 + size.h4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () => Navigator.of(context).pop(),
                  verticalPadding: size.h8,
                  horizontalPadding: size.w28 + size.w1,
                  title: label(e: 'Reject', b: 'প্রত্যাখ্যান'),
                  bgColor: clr.cardFillColorMintCream,
                  borderColor: clr.cardStrokeColor,
                  textColor: clr.appPrimaryColorGreen,
                ),
                SizedBox(
                  width: size.w24,
                ),
                CustomButtonGradient(
                  onTap: () => Navigator.of(context).pushNamed(
                      AppRoute.assignmentReviewScreen,
                      arguments: AssignmentReviewArgs(
                          traineeId: _screenArgs.traineeId)),
                  verticalPadding: size.h8,
                  horizontalPadding: size.w40 + size.w1,
                  title: label(e: 'Agree', b: 'সম্মত'),
                  gradient: LinearGradient(
                    colors: [
                      clr.appPrimaryColorGreen,
                      clr.appPrimaryColorGreen.withOpacity(.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.1, 1],
                  ),
                  textColor: clr.whiteColor,
                ),
              ],
            ),
            SizedBox(height: size.h56),
          ],
        ),
      ),
    );
  }
}

class CustomButtonGradient extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final Color? bgColor, borderColor;
  final IconData? icon;
  final LinearGradient? gradient;
  final String title;
  final Color? textColor;
  final double? textSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final bool expanded;
  const CustomButtonGradient(
      {super.key,
      required this.onTap,
      this.bgColor,
      this.borderColor,
      this.icon,
      required this.title,
      this.textColor,
      this.textSize,
      this.horizontalPadding,
      this.verticalPadding,
      this.radius,
      this.gradient,
      this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? size.w16,
              vertical: verticalPadding ?? size.h10),
          width: expanded ? double.maxFinite : null,
          decoration: BoxDecoration(
              color: bgColor ?? clr.appPrimaryColorGreen,
              gradient: gradient,
              borderRadius: BorderRadius.circular(radius ?? size.w10),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: size.w1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: size.w4),
                  child: Icon(
                    icon,
                    color: clr.shadeWhiteColor2,
                    size: size.r16,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                    color: textColor ?? clr.shadeWhiteColor2,
                    fontSize: textSize ?? size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
