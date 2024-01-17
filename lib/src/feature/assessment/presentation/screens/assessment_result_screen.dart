import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lms/src/core/constants/app_theme.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/utility/app_label.dart';

class AssessmentResultScreen extends StatefulWidget {
  const AssessmentResultScreen({super.key});

  @override
  State<AssessmentResultScreen> createState() => _AssessmentResultScreenState();
}

class _AssessmentResultScreenState extends State<AssessmentResultScreen>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: "Result Details", b: "ফলাফলের বিস্তারিত"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.w16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.h42),
                          child: SizedBox(
                            height: size.h64,
                            width: size.h64,
                            child: PieChart(
                              PieChartData(
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 0,
                                sections: showingSections(),
                              ),
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Correct - 40"),
                            Text("Not Answered - 20"),
                            Text("Wrong - 40")
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.select_all,
                            color: Colors.white,
                            size: size.r24,
                          ),
                          Text(
                            label(b: "উত্তর সংক্ষিপ্তসার", e: "Answer Summary"),
                            style: TextStyle(
                              fontSize: size.textXMedium,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    //Answer summary containers
                    AnswerSummaryContainer(
                        bodyText:
                            label(b: "মোট প্রশ্ন: ", e: "Total Question: "),
                        bodyResultNumber: 100,
                        bodyIcon: Icons.question_mark_sharp,
                        containerColor: Colors.blue[50]!,
                        txtColor: Colors.blue),

                    const SizedBox(
                      height: 10,
                    ),

                    AnswerSummaryContainer(
                        bodyText:
                            label(b: "সঠিক উত্তর: ", e: "Correct Answer: "),
                        bodyResultNumber: 40,
                        bodyIcon: Icons.check,
                        containerColor: Colors.blue[50]!,
                        txtColor: Colors.blue),

                    const SizedBox(
                      height: 10,
                    ),

                    AnswerSummaryContainer(
                        bodyText: label(b: "ভুল উত্তর: ", e: "Wrong Answer: "),
                        bodyResultNumber: 40,
                        bodyIcon: Icons.close,
                        containerColor: Colors.blue[50]!,
                        txtColor: Colors.blue),

                    const SizedBox(
                      height: 10,
                    ),

                    AnswerSummaryContainer(
                        bodyText: label(e: "Unanswered: ", b: "অনুত্তরিত: "),
                        bodyResultNumber: 20,
                        bodyIcon: Icons.adjust_rounded,
                        containerColor: Colors.blue[50]!,
                        txtColor: Colors.blue),

                    const SizedBox(
                      height: 74,
                    ),
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Column(
              //     children: <Widget>[
              //       const Spacer(),
              //       Padding(
              //           padding: EdgeInsets.only(
              //               left: size.w32, right: size.w32, top: size.h12, bottom: size.h16),
              //           child: CustomButton(
              //             title: label(
              //                 b: "ব্যাখ্যা দেখুন", e: "See Explanation"),
              //             onTap: () {
              //               Get.to(MCQExplanationScreen());
              //
              //             },
              //           )),
              //     ],
              //   ),
              // )
            ],
          ),
        ));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clr.appPrimaryColorGreen,
            value: 40,
            title: '40',
            radius: 50.0,
          );
        case 1:
          return PieChartSectionData(
            color: clr.greyColor,
            value: 20,
            title: '20',
            radius: 50.0,
          );
        case 2:
          return PieChartSectionData(
            color: clr.iconColorRed,
            value: 40,
            title: '40',
            radius: 50.0,
          );
        default:
          return PieChartSectionData(
            color: clr.iconColorRed,
            value: 0,
            title: '0',
            radius: 0.0,
          );
      }
    });
  }
}

class AnswerSummaryContainer extends StatelessWidget {
  final String bodyText;
  final int bodyResultNumber;
  final IconData bodyIcon;
  final Color containerColor;
  final Color txtColor;
  const AnswerSummaryContainer(
      {super.key,
      required this.bodyText,
      required this.bodyResultNumber,
      required this.bodyIcon,
      required this.containerColor,
      required this.txtColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.1, 1],
          colors: [
            containerColor,
            Colors.white70,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8),
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                bodyIcon,
                size: 16,
                color: txtColor,
              ),
            ),
          ),
          Text(
            bodyText,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "$bodyResultNumber",
              style: TextStyle(
                  fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
