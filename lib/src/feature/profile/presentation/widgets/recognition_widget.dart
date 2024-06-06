import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/certificate_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../service/recognition_widget_service.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import 'recognition_card.dart';

class RecognitionWidget extends StatefulWidget {
  const RecognitionWidget({super.key});

  @override
  State<RecognitionWidget> createState() => _RecognitionWidgetState();
}

class _RecognitionWidgetState extends State<RecognitionWidget>
    with AppTheme, Language, RecognitionWidgetService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(left: 28.w),
        decoration: BoxDecoration(
            color: clr.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(size.r8))),
        child: Column(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(
                  horizontal: size.h16, vertical: size.h20),
              decoration: BoxDecoration(
                  color: clr.appPrimaryColorGreen,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(size.r8))),
              child: Text(
                label(e: en.acknowledgment, b: bn.acknowledgment),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyRoboto,
                    color: clr.shadeWhiteColor2),
              ),
            ),
            Expanded(
                child: AppStreamBuilder<CertificateDataEntity>(
              stream: certificateDataStreamController.stream,
              loadingBuilder: (context) {
                return const Center(child: CircularLoader());
              },
              dataBuilder: (context, data) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RecognitionCard(
                        title:
                            label(e: data.courseNameEn, b: data.courseNameBn),
                        fileName: data.certificateUrl.split("/").last,
                        time: "",
                        onTapView: () {
                          if (data.certificateUrl.isNotEmpty) {
                            Navigator.of(context).pushNamed(
                                AppRoute.documentViewScreen,
                                arguments: DocumentViewScreenArgs(
                                    url: data.certificateUrl));
                          }
                        },
                        onTapDownload: () {
                          if (data.certificateUrl.isNotEmpty) {
                            downloadFiles(
                                fileUrl: data.certificateUrl,
                                filename: data.certificateUrl.split("/").last,
                                context: context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                message: message,
                title: label(
                    e: "No certificates Found",
                    b: "কোনো সার্টিফিকেট পাওয়া যায়নি"),
                // constraints: constraints,
                // offset: 350.w,
              ),
            )),
          ],
        ),
      ),
    );
  }
  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
