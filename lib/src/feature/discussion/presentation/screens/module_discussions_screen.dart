import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../services/module_discussions_screen_service.dart';
import 'discussion_bottom_sheet.dart';

class ModuleDiscussionsScreen extends StatefulWidget {
  final Object? arguments;
  const ModuleDiscussionsScreen({super.key, this.arguments});

  @override
  State<ModuleDiscussionsScreen> createState() =>
      _ModuleDiscussionsScreenState();
}

class _ModuleDiscussionsScreenState extends State<ModuleDiscussionsScreen>
    with AppTheme, Language, ModuleDiscussionsScreenService {
  late ModuleDiscussionArgs _screenArgs;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as ModuleDiscussionArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadDiscussions(_screenArgs.courseId, _screenArgs.courseModuleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: label(e: en.discussion, b: bn.discussion),
      body: AppStreamBuilder<List<DiscussionDataEntity>>(
        stream: discussionDataStreamController.stream,
        loadingBuilder: (context) {
          return const Center(child: CircularLoader());
        },
        dataBuilder: (context, data) {
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: label(
                          e: "Running Course Discussion",
                          b: "চলমান কোর্সের আলোচনাক্ষেত্র"),
                      fontSize: size.textXMedium,
                    ),
                    // SizedBox(height: size.h4),
                    // if (data.running.isNotEmpty)
                    //   CustomTextWidget(
                    //     text: label(
                    //         e: data.running.first.nameBn,
                    //         b: data.running.first.nameBn),
                    //     textColor: clr.gapStrokeGrey,
                    //     fontSize: size.textXSmall,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    SizedBox(height: size.h12),
                    DiscussionSectionWidget(
                        items: data,
                        buildItem: (BuildContext context, int index, item) {
                          return DiscussionItemWidget(
                              data: item, onTap: () => onTap(item.id));
                        }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onTap: () => onTapCreateDiscussion(
                      courseId: 1,
                      courseModuleId: 1,
                      contentId: 1,
                      contentType: 'course_script'),
                  icon: Icons.add_comment,
                  radius: 0.0,
                  title: label(e: en.newDiscussion, b: bn.newDiscussion),
                ),
              )
            ],
          );
        },
        emptyBuilder: (context, message, icon) => CustomEmptyWidget(
          message: message,
          title:
              label(e: "No Discussions Found", b: "কোন আলোচনা পাওয়া যায়নি"),
          // constraints: constraints,
          // offset: 350.w,
        ),
      ),
    );
  }

  void onTapCreateDiscussion(
      {required int courseId,
      required int courseModuleId,
      required int contentId,
      required String contentType}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => DiscussionBottomSheet(
        courseId: courseId,
        courseModuleId: courseModuleId,
        contentId: contentId,
        contentType: contentType,
        onSuccess: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  void navigateToDetailedDiscussionScreen(int discussionId) {
    Navigator.of(context).pushNamed(
      AppRoute.detailedDiscussion,
      arguments: DetailedDiscussionArgs(discussionId: discussionId),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}

class DiscussionSectionWidget<T> extends StatelessWidget
    with AppTheme, Language {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const DiscussionSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w12),
      child: ListView.separated(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return buildItem(context, index, items[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(height: size.h1, color: clr.cardStrokeColorGrey2);
        },
      ),
    );
  }
}

class DiscussionItemWidget extends StatelessWidget with AppTheme, Language {
  final DiscussionDataEntity data;
  final VoidCallback onTap;
  const DiscussionItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.h12),
            CustomTextWidget(
              text: label(e: data.titleEn, b: data.titleBn),
              textColor: clr.progressColorBlue,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: size.h12),
            CustomTextWidget(
              text: label(e: data.description, b: data.description),
              textColor: clr.gapStrokeGrey,
              fontSize: size.textXSmall,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: size.h12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.thumb_up,
                  size: size.r16,
                  color: clr.gapStrokeGrey,
                ),
                SizedBox(width: size.w8),
                CustomTextWidget(
                  text: label(e: "Like ${data.vote}", b: "লাইক ${data.vote}"),
                  textColor: clr.gapStrokeGrey,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: size.w20),
                Icon(
                  Icons.reply_outlined,
                  size: size.r16,
                  color: clr.gapStrokeGrey,
                ),
                SizedBox(width: size.w8),
                CustomTextWidget(
                  text: label(
                      e: "Reply ${data.comments.length}",
                      b: "রিপ্লাই ${data.comments.length}"),
                  textColor: clr.gapStrokeGrey,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: size.h12),
          ],
        ),
      ),
    );
  }
}
