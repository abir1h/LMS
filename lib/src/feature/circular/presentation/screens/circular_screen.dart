import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/all_circular_data_entity.dart';
import '../services/circular_screen_service.dart';
import '../widgets/circular_item_section_widget.dart';
import '../widgets/circular_item_widget.dart';

class CircularScreen extends StatefulWidget {
  const CircularScreen({super.key});

  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen>
    with AppTheme, Language, CircularScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.circularDetails, b: bn.circularDetails),
      body: AppStreamBuilder<AllCircularDataEntity>(
        stream: allCircularDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Running Circular Section
                if (data.running.isNotEmpty)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: clr.scaffoldBackgroundColor,
                      border:
                          Border.all(color: clr.boxStrokeColor, width: size.w1),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: clr.blackColor.withOpacity(.2))
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: size.h12),
                    child: CircularItemSectionWidget(
                        items: data.running,
                        buildItem: (BuildContext context, int index, item) {
                          return CircularItemWidget(
                            data: item,
                            onTap: () => onTapCircular(item.id),
                          );
                        }),
                  ),

                ///Upcoming Circular Section
                if (data.upcoming.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: size.h16),
                    child: CircularItemSectionWidget(
                        title: label(
                            e: "Upcoming Circular List",
                            b: "আসন্ন বিজ্ঞপ্তির তালিকা"),
                        items: data.upcoming,
                        buildItem: (BuildContext context, int index, item) {
                          return CircularItemWidget(
                            data: item,
                            onTap: () => onTapCircular(item.id),
                          );
                        }),
                  ),

                ///Completed Circular Section
                if (data.completed.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: size.h16),
                    child: CircularItemSectionWidget(
                        title: label(
                            e: "Completed Circular List",
                            b: "সম্পন্ন বিজ্ঞপ্তির তালিকা"),
                        items: data.completed,
                        buildItem: (BuildContext context, int index, item) {
                          return CircularItemWidget(
                            data: item,
                            onTap: () => onTapCircular(item.id),
                          );
                        }),
                  ),

                SizedBox(height: size.h64),
              ],
            ),
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          // constraints: constraints,
          // offset: 350.w,
        ),
      ),
    );
  }

  @override
  void navigateToCircularDetailsScreen(int circularId) {
    Navigator.of(context).pushNamed(AppRoute.circularDetailsScreen,
        arguments: CircularDetailsScreenArgs(circularId: circularId));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
