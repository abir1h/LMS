import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/assignment_bottom_sheet.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with AppTheme, Language {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "",
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label(e: en.assignmentInstruction, b: bn.assignmentInstruction),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h16),
              Center(child: Image.asset(ImageAssets.imgAssignment)),
              SizedBox(height: size.h20),
              Text(
                label(
                    e: en.answerTheFollowingQuestions,
                    b: bn.answerTheFollowingQuestions),
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Text(
                label(
                    e: "1. What are the foundations of teaching programs for learning?",
                    b: "১. শেখার জন্য শিক্ষাদান প্রোগ্রামের ফাউন্ডেশনস কি?"),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              GestureDetector(
                onTap: onTapWriteHere,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: size.w16,
                      right: size.w16,
                      top: size.h12,
                      bottom: size.h44),
                  decoration: BoxDecoration(
                    color: clr.whiteColor,
                    borderRadius: BorderRadius.circular(size.r8),
                    border:
                        Border.all(color: clr.boxStrokeColor, width: size.w1),
                  ),
                  child: Text(
                    label(e: en.writeHere, b: bn.writeHere),
                    style: TextStyle(
                        color: clr.placeHolderTextColorGray,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                ),
              ),
              SizedBox(height: size.h12),
              Center(
                child: Text(
                  label(e: en.or, b: bn.or),
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
              SizedBox(height: size.h12),
              Text(
                label(e: en.uploadTheFile, b: bn.uploadTheFile),
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h12),
                decoration: BoxDecoration(
                  color: clr.whiteColor,
                  borderRadius: BorderRadius.circular(size.r8),
                  border: Border.all(color: clr.boxStrokeColor, width: size.w1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "",
                        style: TextStyle(
                            color: clr.placeHolderTextColorGray,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: clr.iconColorHint,
                      size: size.r24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void onTapWriteHere() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const AssignmentBottomSheet(),
    );
  }
}
