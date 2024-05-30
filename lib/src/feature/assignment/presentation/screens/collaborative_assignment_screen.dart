import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/presentation/widgets/tab_switch_widget.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../services/assignment_screen_service.dart';

class CollaborativeAssignmentScreen extends StatefulWidget {
  final Object? arguments;
  const CollaborativeAssignmentScreen({super.key, this.arguments});

  @override
  State<CollaborativeAssignmentScreen> createState() =>
      _CollaborativeAssignmentScreenState();
}

class _CollaborativeAssignmentScreenState
    extends State<CollaborativeAssignmentScreen>
    with AppTheme, Language, ImagePreviewDialog, AssignmentScreenService {
  late AssignmentArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadCollaborativeData(_screenArgs.courseContentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: clr.boxStrokeColor))),
              child: CustomTextWidget(
                  text: label(e: "data.titleEn", b: "data.titleBn"),
                  fontFamily: StringData.fontFamilyPoppins),
            ),

            SizedBox(height: size.h16),

            /// Tab Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.w24),
              child: TabSwitchWidget(
                leftTitle: label(e: "Points Criteria", b: "পয়েন্টের মানদণ্ড"),
                rightTitle: label(e: "My Submission", b: "আমার সাবমিশন"),
                onTabChange: (e) =>
                    onTabValueChange(e, _screenArgs.courseContentId),
              ),
            ),
            SizedBox(height: size.h16),
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h8),
              margin: EdgeInsets.symmetric(horizontal: size.w2 + size.w28),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.r8),
                  border: Border.all(
                      color: clr.appPrimaryColorGreen, width: size.r1)),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(TextSpan(
                        text: label(
                            e: "data.titleEn",
                            b: "প্রথমবার কোলাবরেটিভ এসাইনমেন্ট এর সম্মুখীন হচ্ছেন? এ সম্পর্কে আরো জানতে এখানে "),
                        style: TextStyle(
                          color: clr.gapStrokeGrey,
                          fontSize: size.textXXSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyRoboto,
                        ),
                        children: [
                          TextSpan(
                            text: "ক্লিক করুন",
                            style: TextStyle(
                              color: clr.progressColorBlue,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyRoboto,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ])),
                  ),
                  SizedBox(width: size.w16),
                  Icon(
                    Icons.close,
                    size: size.r16,
                    color: clr.gapStrokeGrey,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.h20),
            AppStreamBuilder<StateType>(
              stream: stateDataStreamController.stream,
              loadingBuilder: (context) {
                return const Center(child: CircularLoader());
              },
              dataBuilder: (context, data) {
                if (data is CriteriaDataState) {
                  return const CriteriaWidget();
                } else if (data is SubmissionDataState) {
                  return const SubmissionWidget();
                } else {
                  return CustomEmptyWidget(
                    icon: Icons.school_outlined,
                    message: label(
                        e: "No matching data found!",
                        b: "কোনও ডেটা পাওয়া যায়নি!"),
                  );
                }
              },
              emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                message: message,
                title: label(
                    e: "No matching data found!",
                    b: "কোনও ডেটা পাওয়া যায়নি!"),
                // constraints: constraints,
                // offset: 350.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class CriteriaWidget extends StatelessWidget with AppTheme {
  const CriteriaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label(e: "Points Criteria", b: "পয়েন্টের মানদণ্ড"),
          textColor: clr.blackText,
          padding: EdgeInsets.symmetric(horizontal: size.w16),
        ),
        SizedBox(height: size.h8),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.w16),
          padding:
              EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
          decoration: BoxDecoration(
            color: clr.shadeWhiteColor2,
            borderRadius: BorderRadius.circular(size.r8),
            border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: clr.blackColor.withOpacity(.15))
            ],
          ),
          child: Column(
            children: [
              CustomTextWidget(
                text:
                    "প্রদত্ত নির্দেশাবলী এবং রুব্রিকের উপর ভিত্তি করে আপনাকে আপনার সহকর্মীদের অন্তত তিনজনের অ্যাসাইনমেন্ট মূল্যায়ন করতে হবে.আপনি আপনার অ্যাসাইনমেন্ট  দেওয়ার সাথে সাথে অন্যান্য শিক্ষার্থীদের অ্যাসাইনমেন্ট রিভিউ করা শুরু করতে পারবেন.",
                textColor: clr.gapStrokeGrey,
                fontSize: size.textXSmall,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SubmissionWidget extends StatelessWidget {
  const SubmissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssignmentInstructions(),
      ],
    );
  }
}

class AssignmentInstructions<T> extends StatefulWidget {
  const AssignmentInstructions({super.key});

  @override
  State<AssignmentInstructions<T>> createState() =>
      _AssignmentInstructionsState<T>();
}

class _AssignmentInstructionsState<T> extends State<AssignmentInstructions<T>>
    with AppTheme, Language {
  bool _isExpanded = false;

  _toggle() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.w24),
      padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h8),
      decoration: BoxDecoration(
        color: clr.cardFillColorMintCream,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.gapStrokeGrey.withOpacity(.15))
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _toggle(),
            child: Container(
              color: clr.cardFillColorMintCream,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextWidget(
                    text: label(
                        e: "Assignment Instructions",
                        b: "এসাইনমেন্ট এর নির্দেশাবলী"),
                    textColor: clr.blackText,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: size.w8),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: clr.iconColorBlack,
                    size: size.r20,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            CustomTextWidget(
              text: label(
                  e: en.whatWillBeInTheCourse, b: bn.whatWillBeInTheCourse),
              textColor: clr.textColorBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
            ),
        ],
      ),
    );
  }
}
