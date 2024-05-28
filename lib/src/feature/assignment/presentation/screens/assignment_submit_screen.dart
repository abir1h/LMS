import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/quil_text_viewer.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../services/written_assignment_submit_screen_service.dart';
import '../widgets/assignment_bottom_sheet.dart';

class AssignmentSubmitScreen extends StatefulWidget {
  final Object? arguments;
  const AssignmentSubmitScreen({super.key, this.arguments});

  @override
  State<AssignmentSubmitScreen> createState() => _AssignmentSubmitScreenState();
}

class _AssignmentSubmitScreenState extends State<AssignmentSubmitScreen>
    with
        AppTheme,
        Language,
        WrittenAssignmentSubmitScreenService,
        AppEventsNotifier {
  late AssignmentSubmitScreenArgs _screenArgs;

  final _controller = QuillController.basic();

  String data = '';
  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as AssignmentSubmitScreenArgs;
    setContent();
  }

  setContent() {
    if (_screenArgs.answer != null) {
      if (_screenArgs.answer != null) {
        final Document doc =
            Document.fromJson(json.decode(_screenArgs.answer!));
        _controller.document = doc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "",
        actionChild: InkWell(
            onTap: () => onTapWriteHere(),
            child: Icon(Icons.edit,
                size: size.r24, color: clr.appPrimaryColorGreen)),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuilTextViewer(
                    controller: _controller,
                  ),
                  SizedBox(height: size.h20 * 5),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.w16),
                padding: EdgeInsets.only(
                    left: size.w12,
                    right: size.w12,
                    top: size.h24,
                    bottom: size.h16),
                decoration: BoxDecoration(
                    color: clr.shadeWhiteColor2,
                    border: Border(
                        top: BorderSide(
                            color: clr.boxStrokeColor, width: size.w1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                        onPressed: () {
                          _screenArgs.type == "store"
                              ? onStoreAssignment(
                                  assignmentId:
                                      _screenArgs.assignmentDataEntity!.id,
                                  subAssignmentId: _screenArgs.assignmentDataEntity?.circularSubAssignments != null
                                      ? _screenArgs.assignmentDataEntity!
                                          .circularSubAssignments!.id
                                      : -1,
                                  courseId: _screenArgs
                                      .assignmentDataEntity!.courseId,
                                  circularId: _screenArgs
                                      .assignmentDataEntity!.circularId,
                                  answer: _screenArgs.answer!,
                                  files: []).then((value) {
                                  contentReadPost(
                                      _screenArgs.assignmentDataEntity!.id,
                                      _screenArgs
                                          .assignmentDataEntity!.courseId,
                                      true);
                                  Navigator.of(context).pushNamed(
                                      AppRoute.assignmentScreen,
                                      arguments: AssignmentArgs(
                                          courseContentId: _screenArgs
                                              .assignmentDataEntity!.id));
                                })
                              : onUpdateAssignment(
                                  submissionId:
                                      _screenArgs.assignmentDataEntity!.type == "individual"
                                          ? _screenArgs.assignmentDataEntity!
                                              .assignmentSubmissions!.id
                                          : _screenArgs.assignmentDataEntity!.circularSubAssignments!.assignmentSubmissions!.id,
                                  assignmentId: _screenArgs.assignmentDataEntity!.id,
                                  subAssignmentId: _screenArgs.assignmentDataEntity?.circularSubAssignments != null ? _screenArgs.assignmentDataEntity!.circularSubAssignments!.id : -1,
                                  courseId: _screenArgs.assignmentDataEntity!.courseId,
                                  circularId: _screenArgs.assignmentDataEntity!.circularId,
                                  answer: _screenArgs.answer!,
                                  files: []).then((value) {
                                  contentReadPost(
                                      _screenArgs.assignmentDataEntity!.id,
                                      _screenArgs
                                          .assignmentDataEntity!.courseId,
                                      true);
                                  Navigator.of(context).pushNamed(
                                      AppRoute.assignmentScreen,
                                      arguments: AssignmentArgs(
                                          courseContentId: _screenArgs
                                              .assignmentDataEntity!.id));
                                });
                        },
                        style: FilledButton.styleFrom(
                          side: BorderSide(
                              color: clr.appPrimaryColorGreen, width: size.r1),
                          backgroundColor: clr.scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size.r4),
                          ),
                        ),
                        child: Text(
                          label(e: en.submit, b: bn.submit),
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w600,
                              fontFamily: StringData.fontFamilyPoppins),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void onTapWriteHere() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AssignmentBottomSheet(
        type: _screenArgs.type!,
        answer: _screenArgs.answer!,
        assignmentDataEntity: _screenArgs.assignmentDataEntity,
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

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.courseDetailsScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
