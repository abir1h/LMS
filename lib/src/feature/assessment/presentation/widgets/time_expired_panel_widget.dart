import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/exam_data_entity.dart';
import '../../domain/entities/result_data_entity.dart';

class TimeExpiredPanelWidget<T> extends StatefulWidget {
  final ExamDataEntity questionDataEntity;
  final Future<ResponseEntity> Function(ExamDataEntity datat) doSubmitResult;
  const TimeExpiredPanelWidget({
    Key? key,
    required this.questionDataEntity,
    required this.doSubmitResult,
  }) : super(key: key);

  @override
  State<TimeExpiredPanelWidget<T>> createState() =>
      _TimeExpiredPanelWidgetState<T>();
}

class _TimeExpiredPanelWidgetState<T> extends State<TimeExpiredPanelWidget<T>>
    with AppTheme {
  final BehaviorSubject<ResponseEntity> answerSubmissionController =
      BehaviorSubject();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _submitResult();
    });
  }

  void _submitResult() {
    widget.doSubmitResult(widget.questionDataEntity).then((value) {
      if (value.error == null && value.data != null) {
        if (mounted) {
          answerSubmissionController.sink.add(value.data as ResponseEntity);
        }
      } else {
        Future.delayed(const Duration(seconds: 5)).then((_) {
          if (mounted) {
            _submitResult();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: EdgeInsets.all(size.h24),
      child: StreamBuilder<ResponseEntity>(
          stream: answerSubmissionController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(bottom: size.h64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: clr.iconColorRed,
                      size: size.r20 * 4,
                    ),
                    SizedBox(height: size.h32),
                    Text(
                      "Time Up!",
                      style: TextStyle(
                        color: clr.appSecondaryColorFlagRed,
                        fontSize: size.textXLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.h12),
                    Text(
                      "Your exam time is up. The answer is automatically being submitted.\nPlease wait..",
                      style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.h24),
                    const Center(
                      child: CircularLoader(),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: clr.iconColorRed,
                          size: size.r20 * 4,
                        ),
                        SizedBox(height: size.h32),
                        Text(
                          "Time Up!",
                          style: TextStyle(
                            color: clr.appSecondaryColorFlagRed,
                            fontSize: size.textXLarge,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.h12),
                        Text(
                          "Your exam time is up. Don't worry! your answer have been auto submitted.\n\nThank you for your participation.",
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.h42),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
