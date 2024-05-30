import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../course/domain/entities/all_course_data_entity.dart';
import '../../../course/domain/entities/course_data_entity.dart';
import '../../../course/presentation/screens/course_live_class_screen.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/discussion_data_entity.dart';
import '../../domain/entities/weekly_view_data_entity.dart';
import '../services/discussion_screen_service.dart';
import 'discussion_bottom_sheet.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen>
    with AppTheme, Language, DiscussionScreenService {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.discussion, b: bn.discussion),
        body: LayoutBuilder(builder: (context, constraints) {
          return AppStreamBuilder<AllCourseDataEntity>(
            stream: allCourseDataStreamController.stream,
            loadingBuilder: (context) {
              return const Center(child: CircularLoader());
            },
            dataBuilder: (context, data) {
              return Stack(
                children: [
                  /*SingleChildScrollView(
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
                          SizedBox(height: size.h4),
                          if (data.running.isNotEmpty)
                            CustomTextWidget(
                              text: label(
                                  e: data.running.first.nameBn,
                                  b: data.running.first.nameBn),
                              textColor: clr.gapStrokeGrey,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w500,
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                surfaceTintColor: clr.shadeWhiteColor2,
                                padding: EdgeInsets.symmetric(horizontal: size.w8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.r4),
                                  ),
                                ),
                                position: PopupMenuPosition.under,
                                onSelected: (String? value) {
                                  setState(() {
                                    // loadDiscussions(value)
                                  });
                                },
                                itemBuilder: (context) => data.courses
                                    .map<PopupMenuEntry<String>>(
                                        (CourseDataEntity value) {
                                  return PopupMenuItem(
                                    onTap: () {
                                      loadDiscussions(value.id);
                                    },
                                    child: CustomTextWidget(
                                      text: label(e: value.nameEn, b: value.nameBn),
                                      fontSize: size.textXSmall,
                                      textColor: clr.gapStrokeGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }).toList(),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      color: clr.appPrimaryColorGreen,
                                      size: size.r16,
                                    ),
                                    SizedBox(width: size.w8),
                                    CustomTextWidget(
                                      text: label(e: "Courses", b: "কোর্সেস"),
                                      fontSize: size.textXSmall,
                                      textColor: clr.gapStrokeGrey,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.h12),
                          AppStreamBuilder<List<DiscussionDataEntity>>(
                            stream: discussionDataStreamController.stream,
                            loadingBuilder: (context) {
                              return const Center(child: CircularLoader());
                            },
                            dataBuilder: (context, data) {
                              return DiscussionSectionWidget(
                                  items: data,
                                  buildItem:
                                      (BuildContext context, int index, item) {
                                    return DiscussionItemWidget(
                                        data: item, onTap: () => onTap(item.id));
                                  });
                            },
                            emptyBuilder: (context, message, icon) => Container(),
                          ),
                        ],
                      ),
                    ),*/
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
                        SizedBox(height: size.h4),
                        if (data.running.isNotEmpty)
                          CustomTextWidget(
                            text: label(
                                e: data.running.first.nameBn,
                                b: data.running.first.nameBn),
                            textColor: clr.gapStrokeGrey,
                            fontSize: size.textXSmall,
                            fontWeight: FontWeight.w500,
                          ),
                        SizedBox(height: size.h16),

                        ///Filter
                        /*Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                surfaceTintColor: clr.shadeWhiteColor2,
                                padding: EdgeInsets.symmetric(horizontal: size.w8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.r4),
                                  ),
                                ),
                                position: PopupMenuPosition.under,
                                onSelected: (String? value) {
                                  setState(() {
                                    // loadDiscussions(value)
                                  });
                                },
                                itemBuilder: (context) => data.courses
                                    .map<PopupMenuEntry<String>>(
                                        (CourseDataEntity value) {
                                  return PopupMenuItem(
                                    onTap: () {
                                      loadDiscussions(value.id);
                                    },
                                    child: CustomTextWidget(
                                      text: label(e: value.nameEn, b: value.nameBn),
                                      fontSize: size.textXSmall,
                                      textColor: clr.gapStrokeGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }).toList(),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      color: clr.appPrimaryColorGreen,
                                      size: size.r16,
                                    ),
                                    SizedBox(width: size.w8),
                                    CustomTextWidget(
                                      text: label(e: "Courses", b: "কোর্সেস"),
                                      fontSize: size.textXSmall,
                                      textColor: clr.gapStrokeGrey,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.h12),*/
                        Center(
                          child: DiscussionTypeSelectorTab(
                            onSelected: (e) =>
                                onTabValueChange(e, data.running.first.id),
                          ),
                        ),
                        SizedBox(height: size.h20),
                        AppStreamBuilder<StateType>(
                          stream: stateDataStreamController.stream,
                          loadingBuilder: (context) {
                            return const Center(child: CircularLoader());
                          },
                          dataBuilder: (context, data) {
                            if (data is WeeklyDiscussionDataState) {
                              return data.weeklyViewDataEntity.isNotEmpty
                                  ? WeeklyDiscussionSectionWidget(
                                      items: data.weeklyViewDataEntity,
                                      buildItem: (BuildContext context,
                                          int index, item) {
                                        return WeeklyDiscussionItemWidget(
                                          data: item,
                                          onTap: () =>
                                              onTapWeek(item.courseId, item.id),
                                        );
                                      })
                                  : EmptyWidget(
                                      constraints: constraints,
                                      message: label(
                                          e: "No Weekly Discussions Found",
                                          b: "কোন সাপ্তাহিক আলোচনা পাওয়া যায়নি"),
                                    );
                            } else if (data is AllDiscussionDataState) {
                              return data.discussionDataEntity.isNotEmpty
                                  ? DiscussionSectionWidget(
                                      items: data.discussionDataEntity,
                                      buildItem: (BuildContext context,
                                          int index, item) {
                                        return DiscussionItemWidget(
                                            data: item,
                                            onTap: () => onTap(item.id));
                                      })
                                  : EmptyWidget(
                                      constraints: constraints,
                                      message: label(
                                          e: "No Discussions Found",
                                          b: "কোন আলোচনা পাওয়া যায়নি"),
                                    );
                            } else {
                              return CustomEmptyWidget(
                                icon: Icons.school_outlined,
                                message: label(
                                    e: "No Discussions Found",
                                    b: "কোন আলোচনা পাওয়া যায়নি"),
                              );
                            }
                          },
                          emptyBuilder: (context, message, icon) =>
                              CustomEmptyWidget(
                            message: message,
                            // constraints: constraints,
                            // offset: 350.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: CustomButton(
                  //     onTap: () => onTapCreateDiscussion(
                  //         courseId: data.running.first.id,
                  //         courseModuleId: 1,
                  //         contentId: 1,
                  //         contentType: 'course_script'),
                  //     icon: Icons.add_comment,
                  //     radius: 0.0,
                  //     title: label(e: en.newDiscussion, b: bn.newDiscussion),
                  //   ),
                  // )
                ],
              );
            },
            emptyBuilder: (context, message, icon) => CustomEmptyWidget(
              message: message,
              title: label(
                  e: "No Discussions Found", b: "কোন আলোচনা পাওয়া যায়নি"),
              // constraints: constraints,
              // offset: 350.w,
            ),
          );
        }));
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

  @override
  void navigateToModuleDiscussionScreen(int courseId, int courseModuleId) {
    Navigator.of(context).pushNamed(
      AppRoute.moduleDiscussionsScreen,
      arguments: ModuleDiscussionArgs(
          courseId: courseId, courseModuleId: courseModuleId),
    );
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

class WeeklyDiscussionSectionWidget<T> extends StatelessWidget
    with AppTheme, Language {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const WeeklyDiscussionSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
        borderRadius: BorderRadius.circular(size.r8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 4,
            offset: Offset(0, 3), // Adjust shadow offset as needed
          ),
        ],
      ),
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

class WeeklyDiscussionItemWidget extends StatelessWidget
    with AppTheme, Language {
  final WeeklyViewDataEntity data;
  final VoidCallback onTap;

  const WeeklyDiscussionItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.h12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.r8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label(e: data.nameEn, b: data.nameBn),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textSmall,
                        fontFamily: StringData.fontFamilyRoboto,
                        color: clr.blackText),
                  ),
                  SizedBox(
                    height: size.h8,
                  ),
                  Text(
                    label(
                        e: "Total Discussions ${data.coursediscussionsCount.toString()}",
                        b: "সর্বমোট আলোচনা ${replaceEnglishNumberWithBengali(data.coursediscussionsCount.toString())} টি"),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXSmall,
                        fontFamily: StringData.fontFamilyRoboto,
                        color: clr.gapStrokeGrey),
                  ),
                  SizedBox(
                    height: size.h8,
                  ),
                  Text(
                    data.latestTime.isNotEmpty
                        ? label(
                            e: timeago.format(DateTime.parse(data.latestTime)),
                            b: "সর্বশেষ আলোচনা ${timeAgoToBengali(timeago.format(DateTime.parse(data.latestTime.trim())))}")
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.textXSmall,
                        fontFamily: StringData.fontFamilyRoboto,
                        color: clr.gapStrokeGrey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_circle_right_outlined,
              size: size.r24,
              color: clr.gapStrokeGrey,
            )
          ],
        ),
      ),
    );
  }
}

class DiscussionTypeSelectorTab extends StatefulWidget {
  final void Function(int type) onSelected;
  final int type;
  const DiscussionTypeSelectorTab(
      {Key? key, required this.onSelected, this.type = 0})
      : super(key: key);
  @override
  State<DiscussionTypeSelectorTab> createState() =>
      _DiscussionTypeSelectorTabState();
}

class _DiscussionTypeSelectorTabState extends State<DiscussionTypeSelectorTab>
    with AppTheme, Language {
  int _selectedType = 0;

  @override
  void initState() {
    _selectedType = widget.type;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DiscussionTypeSelectorTab oldWidget) {
    setState(() {
      _selectedType = widget.type;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizeConstraints) {
      return Container(
        height: size.h42,
        decoration: BoxDecoration(
          color: clr.whiteColor,
          border: Border.all(color: clr.cardStrokeColor, width: size.r1),
          borderRadius: BorderRadius.circular(size.r12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _onChanged(0),
              child: Container(
                height: double.maxFinite,
                width: sizeConstraints.maxWidth / 2.05,
                decoration: BoxDecoration(
                  color: _selectedType == 0 ? null : Colors.transparent,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.83),
                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.r12),
                      bottomLeft: Radius.circular(size.r12)),
                ),
                child: Center(
                    child: Text(
                  label(e: "Weekly View", b: 'সাপ্তাহিক ভিউ'),
                  style: TextStyle(
                    color: _selectedType == 0
                        ? clr.shadeWhiteColor2
                        : clr.textColorAppleBlack,
                    fontWeight:
                        _selectedType == 0 ? FontWeight.w500 : FontWeight.w400,
                    fontSize: size.textSmall,
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () => _onChanged(1),
              child: Container(
                height: double.maxFinite,
                width: sizeConstraints.maxWidth / 2.05,
                decoration: BoxDecoration(
                  color: _selectedType == 1 ? null : Colors.transparent,
                  gradient: LinearGradient(colors: [
                    clr.appPrimaryColorGreen,
                    clr.appPrimaryColorGreen.withOpacity(.83),
                  ]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.r12),
                      bottomRight: Radius.circular(size.r12)),
                ),
                child: Center(
                    child: Text(
                  label(e: "All Discussion", b: 'সকল টপিক'),
                  style: TextStyle(
                    color: _selectedType == 1
                        ? clr.shadeWhiteColor2
                        : clr.textColorAppleBlack,
                    fontWeight:
                        _selectedType == 1 ? FontWeight.w500 : FontWeight.w400,
                    fontSize: size.textSmall,
                  ),
                )),
              ),
            ),
          ],
        ),
      );
    });
  }

  _onChanged(int type) {
    if (mounted && _selectedType != type) {
      setState(() {
        _selectedType = type;
      });
      widget.onSelected.call(_selectedType);
    }
  }
}

///Previous
/* AppStreamBuilder<AllCourseDataEntity>(
        stream: allCourseDataStreamController.stream,
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
                    SizedBox(height: size.h4),
                    if (data.running.isNotEmpty)
                      CustomTextWidget(
                        text: label(
                            e: data.running.first.nameBn,
                            b: data.running.first.nameBn),
                        textColor: clr.gapStrokeGrey,
                        fontSize: size.textXSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                          surfaceTintColor: clr.shadeWhiteColor2,
                          padding: EdgeInsets.symmetric(horizontal: size.w8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.r4),
                            ),
                          ),
                          position: PopupMenuPosition.under,
                          onSelected: (String? value) {
                            setState(() {
                              // loadDiscussions(value)
                            });
                          },
                          itemBuilder: (context) => data.courses
                              .map<PopupMenuEntry<String>>(
                                  (CourseDataEntity value) {
                            return PopupMenuItem(
                              onTap: () {
                                loadDiscussions(value.id);
                              },
                              child: CustomTextWidget(
                                text: label(e: value.nameEn, b: value.nameBn),
                                fontSize: size.textXSmall,
                                textColor: clr.gapStrokeGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }).toList(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list,
                                color: clr.appPrimaryColorGreen,
                                size: size.r16,
                              ),
                              SizedBox(width: size.w8),
                              CustomTextWidget(
                                text: label(e: "Courses", b: "কোর্সেস"),
                                fontSize: size.textXSmall,
                                textColor: clr.gapStrokeGrey,
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.h12),
                    AppStreamBuilder<List<DiscussionDataEntity>>(
                      stream: discussionDataStreamController.stream,
                      loadingBuilder: (context) {
                        return const Center(child: CircularLoader());
                      },
                      dataBuilder: (context, data) {
                        return DiscussionSectionWidget(
                            items: data,
                            buildItem: (BuildContext context, int index, item) {
                              return DiscussionItemWidget(
                                  data: item, onTap: () => onTap(item.id));
                            });
                      },
                      emptyBuilder: (context, message, icon) => Container(),
                    ),
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: CustomButton(
              //     onTap: () => onTapCreateDiscussion(
              //         courseId: data.running.first.id,
              //         courseModuleId: 1,
              //         contentId: 1,
              //         contentType: 'course_script'),
              //     icon: Icons.add_comment,
              //     radius: 0.0,
              //     title: label(e: en.newDiscussion, b: bn.newDiscussion),
              //   ),
              // )
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
      )

 */
