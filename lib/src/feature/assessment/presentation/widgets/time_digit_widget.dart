import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';

class TimeDigitWidget<T> extends StatefulWidget {
  final Stream<Duration> timerStream;
  final Stream<DataState<T>> examStateStream;
  final bool Function(DataState<T>? snapshot) isExamRunning;
  const TimeDigitWidget(
      {Key? key,
      required this.timerStream,
      required this.examStateStream,
      required this.isExamRunning})
      : super(key: key);

  @override
  State<TimeDigitWidget<T>> createState() => _TimeDigitWidgetState<T>();
}

class _TimeDigitWidgetState<T> extends State<TimeDigitWidget<T>> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
        stream: widget.examStateStream,
        builder: (context, snapshot) {
          if (widget.isExamRunning(snapshot.data)) {
            return Container(
              padding:
                  EdgeInsets.symmetric(horizontal: size.w6, vertical: size.h6),
              decoration: BoxDecoration(
                  color: clr.whiteColor,
                  borderRadius: BorderRadius.circular(size.h4),
                  border:
                      Border.all(color: clr.toastSuccessColor, width: size.r1)),
              child: StreamBuilder<Duration>(
                  initialData: const Duration(),
                  stream: widget.timerStream,
                  builder: (context, snapshot) {
                    int min = snapshot.data!.inMinutes;
                    int sec = snapshot.data!.inSeconds % 60;

                    var minMsbRaw = min ~/ 10;
                    var minMMsb = minMsbRaw ~/ 10;
                    var minMsb = minMsbRaw % 10;
                    var minLsb = min % 10;

                    var secMsb = sec ~/ 10;
                    var secLsb = sec % 10;
                    return Row(
                      children: [
                        if (minMMsb > 0) _buildDigitBox(minMMsb),
                        if (minMMsb > 0) SizedBox(width: size.w2),
                        _buildDigitBox(minMsb),
                        SizedBox(width: size.w2),
                        _buildDigitBox(minLsb),
                        SizedBox(width: size.w2),
                        _buildDigitSeparatorBox(":"),
                        SizedBox(width: size.w2),
                        _buildDigitBox(secMsb),
                        SizedBox(width: size.w2),
                        _buildDigitBox(secLsb),
                      ],
                    );
                  }),
            );
          } else {
            return const Offstage();
          }
        });
  }

  Widget _buildDigitBox(int value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.w6),
      decoration: BoxDecoration(
        color: clr.appPrimaryColorGreen,
        borderRadius: BorderRadius.circular(size.w2),
      ),
      child: FittedBox(
        child: Text(
          replaceEnglishNumberWithBengali(value.toString()),
          style: TextStyle(
            fontSize: size.textLarge,
            color: clr.whiteColor,
            fontWeight: FontWeight.w400,
            fontFamily: StringData.fontFamilyRoboto,
          ),
        ),
      ),
    );
  }

  Widget _buildDigitSeparatorBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.w6),
      decoration: BoxDecoration(
        color: clr.appPrimaryColorGreen,
        borderRadius: BorderRadius.circular(size.w2),
      ),
      child: FittedBox(
        child: Text(
          value,
          style: TextStyle(
            fontSize: size.textLarge,
            color: clr.whiteColor,
            fontWeight: FontWeight.w400,
            fontFamily: StringData.fontFamilyRoboto,
          ),
        ),
      ),
    );
  }
}

abstract class DataState<T> {}
