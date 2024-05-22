import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lms/src/feature/profile/domain/entities/all_progress_data_entity.dart';
import 'package:lms/src/feature/profile/presentation/widgets/running_course_item_widget.dart';
import 'package:lms/src/feature/profile/presentation/widgets/running_course_section_widget.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circuler_widget.dart';
import '../../../../core/common_widgets/custom_empty_widget.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../circular/presentation/screens/circular_details_screen.dart';
import '../../../course/presentation/screens/overall_progress_screen.dart';
import '../../../course/presentation/widgets/tab_switch_widget.dart';
import '../../domain/entities/profile_data_entity.dart';
import '../service/profile_service.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/service/auth_cache_manager.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/completed_course_item_widget.dart';
import '../widgets/completed_course_item_section_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AppTheme, Language, AppEventsNotifier, ProfileService {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppStreamBuilder<AllProgressDataEntity>(
          stream: headerDataStreamController.stream,
          loadingBuilder: (context) {
            return SizedBox(
              height: 130.h,
              width: 1.sw,
            );
          },
          dataBuilder: (context, data) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: size.h20),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: clr.cardStrokeColor, width: size.w1)),
                        child: CircleAvatar(
                          radius: 45.r,
                          /*backgroundImage: AssetImage(
                           ImageAssets.imgProfile,
                         ),*/
                          backgroundColor: clr.appPrimaryColorGreen,
                          child: Center(
                            child: Text(
                              data.userInfoDataEntity!.emisUserDataEntity !=
                                      null
                                  ? data.userInfoDataEntity!.emisUserDataEntity!
                                      .name[0]
                                      .toUpperCase()
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.textXLarge),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.h12),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.w16),
                        child: Text(
                          data.userInfoDataEntity!.emisUserDataEntity != null
                              ? label(
                                  e: data.userInfoDataEntity!
                                      .emisUserDataEntity!.name,
                                  b: data.userInfoDataEntity!
                                      .emisUserDataEntity!.name)
                              : "",
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXMedium,
                              fontWeight: FontWeight.w600,
                              fontFamily: StringData.fontFamilyRoboto),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        label(
                            e: data.userInfoDataEntity!.role,
                            b: data.userInfoDataEntity!.role),
                        style: TextStyle(
                            color: clr.gapStrokeGrey,
                            fontSize: size.textXXSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyRoboto),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.h10)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.w24, right: size.w16, top: size.h16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // SvgPicture.asset(ImageAssets.icEdit),
                        CustomSwitchButton(
                          value: App.currentAppLanguage == AppLanguage.english,
                          textOn: 'EN',
                          textSize: size.textXXSmall,
                          textOff: 'বাং',
                          bgColor: clr.whiteColor,
                          width: 64.w,
                          animationDuration: const Duration(milliseconds: 300),
                          onChanged: (bool state) {
                            App.setAppLanguage(state ? 1 : 0).then((value) {
                              if (mounted) {
                                setState(() {});
                              }
                              AppEventsNotifier.notify(
                                  EventAction.bottomNavBar);
                            });
                          },
                          buttonHolder: const Icon(
                            Icons.check,
                            color: Colors.transparent,
                          ),
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) => Container(),
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: size.w16),
            decoration: BoxDecoration(
                color: clr.shadeWhiteColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.w40),
                  topRight: Radius.circular(size.w40),
                ),
                border: Border(
                    top: BorderSide(color: clr.cardStrokeColor),
                    right: BorderSide(color: clr.cardStrokeColor))),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.h24),

                  /// Tab Button
                  TabSwitchWidget(
                    leftTitle: label(e: "Personal Info", b: "ব্যাক্তিগত তথ্য"),
                    rightTitle: label(e: "Progress Info", b: "অগ্রগতির তথ্য"),
                    onTabChange: onTabValueChange,
                  ),
                  SizedBox(height: size.h16),
                  AppStreamBuilder<StateType>(
                    stream: stateDataStreamController.stream,
                    loadingBuilder: (context) {
                      return const Center(child: CircularLoader());
                    },
                    dataBuilder: (context, data) {
                      if (data is ProfileDataState) {
                        return data.userInfoDataEntity.userInfoDataEntity!.emisUserDataEntity!=null? PersonalInfoWidget(
                          data: data.userInfoDataEntity,
                          onTapLogout: showLogoutPromptDialog,
                        ): SizedBox(
                          height: .5.sh,
                          child: CustomEmptyWidget(
                            icon: Icons.school_outlined,
                            title: label(e: "No data from server", b: "সার্ভার থেকে কোন তথ্য নেই"),
                            message: "",
                          )
                        );
                      } else if (data is ProgressDataState) {
                        return ProgressInfoWidget(
                          data: data.progressDataEntity,
                        );
                      } else {
                        return  CustomEmptyWidget(
                          icon: Icons.school_outlined,
                          message: label(e: "No matching data found!", b: "কোনও   ডেটা পাওয়া যায়নি!"),
                        );
                      }
                    },
                    emptyBuilder: (context, message, icon) => CustomEmptyWidget(
                      message: message,title: label(e: "No matching data found!", b: "কোনও   ডেটা পাওয়া যায়নি!"),
                      // constraints: constraints,
                      // offset: 350.w,
                    ),
                  ),
                  SizedBox(height: size.h40),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
      infoText: label(
          e: "Your ID login is required for your courses and assessment news.",
          b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
      leftButtonText: label(e: en.cancelText, b: bn.cancelText),
      rightButtonText: label(e: en.exitText, b: bn.exitText),
    ).then((value) {
      if (value) {
        if (value) {
          AuthCacheManager.userLogout();
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.authenticationScreen, (x) => false);
        }
      }
    });
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavAllScreen ||
        action == EventAction.profileScreen) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class TitleWithIcon extends StatelessWidget with AppTheme {
  final IconData? icon;
  final String? svgIcon;
  final String leftText;
  final String? rightText;
  final bool hasBorder;
  final bool hasTrailing;
  final VoidCallback? onTap;
  const TitleWithIcon(
      {super.key,
      this.icon,
      this.svgIcon,
      required this.leftText,
      this.rightText,
      this.hasBorder = true,
      this.hasTrailing = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: size.w4, top: size.h16, bottom: size.h16, right: size.w12),
        decoration: BoxDecoration(
          border: hasBorder
              ? Border(
                  bottom: BorderSide(color: clr.boxStrokeColor),
                )
              : null,
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: clr.appPrimaryColorGreen,
                size: size.r20,
              ),
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon!,
                colorFilter:
                    ColorFilter.mode(clr.appPrimaryColorGreen, BlendMode.srcIn),
                // color: clr.hintIconColor,
              ),
            SizedBox(width: size.w16),
            rightText != null
                ? Expanded(
                    child: RowItemWidgetText(
                      leftText: leftText,
                      rightText: rightText,
                      leftTextColor: clr.textColorAppleBlack,
                      rightTextColor: clr.appPrimaryColorGreen,
                    ),
                  )
                : Expanded(
                    child: Text(
                      leftText,
                      style: TextStyle(
                          color: clr.iconColorHint,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w500,
                          fontFamily: StringData.fontFamilyPoppins),
                    ),
                  ),
            if (hasTrailing)
              Icon(
                Icons.arrow_circle_right,
                color: clr.appPrimaryColorGreen,
                size: size.r16,
              ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoWidget extends StatelessWidget with AppTheme, Language {
  final AllProgressDataEntity data;
  final VoidCallback onTapLogout;
  const PersonalInfoWidget(
      {super.key, required this.data, required this.onTapLogout});

  @override
  Widget build(BuildContext context) {
    return data.userInfoDataEntity!.emisUserDataEntity != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithIcon(
                  icon: Icons.phone,
                  leftText: label(e: 'ফোন নম্বর', b: "Phone Number"),
                  rightText: label(
                      e: data.userInfoDataEntity!.emisUserDataEntity!.mobileNo,
                      b: data
                          .userInfoDataEntity!.emisUserDataEntity!.mobileNo)),
              TitleWithIcon(
                  icon: Icons.email,
                  leftText: label(e: "Email", b: 'ইমেইল'),
                  rightText: label(
                      e: data.userInfoDataEntity!.emisUserDataEntity!.email,
                      b: data.userInfoDataEntity!.emisUserDataEntity!.email)),
              TitleWithIcon(
                  icon: Icons.person,
                  leftText: label(e: "Gender", b: 'লিঙ্গ'),
                  rightText: 'N/A'),
              TitleWithIcon(
                  icon: Icons.calendar_month,
                  leftText: label(e: 'Birth Date', b: 'জন্ম তারিখ'),
                  rightText:
                      data.userInfoDataEntity!.emisUserDataEntity!.mobileNo),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.area_chart,
                  leftText: label(e: 'Zone', b: 'জোন'),
                  rightText: "N/A"),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.area_chart,
                  leftText: label(e: 'Division', b: 'বিভাগ '),
                  rightText: "N/A"),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.area_chart,
                  leftText: label(e: 'District', b: 'জেলা '),
                  rightText: "N/A"),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.area_chart,
                  leftText: label(e: 'Sub-District', b: 'উপজেলা '),
                  rightText: "N/A"),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.badge,
                  leftText: label(e: 'Emis Number', b: 'ইএমআইএস নম্বর '),
                  rightText: label(
                    e: data.userInfoDataEntity!.emisUserDataEntity!.pdsid,
                    b: data.userInfoDataEntity!.emisUserDataEntity!.pdsid,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  svgIcon: ImageAssets.shieldPerson,
                  leftText: label(e: 'Designation', b: 'পদবী '),
                  rightText: label(
                    e: data.userInfoDataEntity!.emisUserDataEntity!.designation,
                    b: data.userInfoDataEntity!.emisUserDataEntity!.designation,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.format_list_numbered,
                  leftText: label(e: 'Index Number', b: 'ইনডেক্স নম্বর '),
                  rightText: label(
                    e: data.userInfoDataEntity!.emisUserDataEntity!.indexNumber,
                    b: data.userInfoDataEntity!.emisUserDataEntity!.indexNumber,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.format_list_numbered,
                  leftText: label(e: 'MPO Status', b: 'এমপিও স্ট্যাটাস'),
                  rightText: label(
                    e: data.userInfoDataEntity!.emisUserDataEntity!.isMpo
                        ? label(e: "Yes", b: 'হ্যাঁ')
                        : label(e: "No", b: 'না'),
                    b: data.userInfoDataEntity!.emisUserDataEntity!.designation,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.format_align_left_outlined,
                  leftText: label(e: 'Subject', b: 'বিষয় '),
                  rightText: label(
                    e: "N/A",
                    b: "N/A",
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.account_balance,
                  leftText: label(e: 'Institute Name', b: 'ইনস্টিটিউটের নাম'),
                  rightText: label(
                    e: data
                        .userInfoDataEntity!.emisUserDataEntity!.instituteName,
                    b: data
                        .userInfoDataEntity!.emisUserDataEntity!.instituteName,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.school,
                  leftText: label(e: 'EIIN Number', b: 'ইআইআইএন নম্বর'),
                  rightText: label(
                    e: data.userInfoDataEntity!.emisUserDataEntity!.eiin,
                    b: data.userInfoDataEntity!.emisUserDataEntity!.eiin,
                  )),
              TitleWithIcon(
                  onTap: () {},
                  icon: Icons.school,
                  leftText: label(e: 'Role Name', b: 'রোল নেম'),
                  rightText: data.userInfoDataEntity!.role.isNotEmpty
                      ? label(
                          e: data.userInfoDataEntity!.role,
                          b: data.userInfoDataEntity!.role,
                        )
                      : ""),
              TitleWithIcon(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                svgIcon: ImageAssets.icEditorChoice,
                leftText: label(e: en.certificateText, b: bn.certificateText),
                hasTrailing: true,
              ),
              TitleWithIcon(
                icon: Icons.logout,
                leftText: label(e: en.logoutText, b: bn.logoutText),
                onTap: onTapLogout,
                hasBorder: false,
              ),
            ],
          )
        : Column(
            children: [],
          );
  }
}

class ProgressInfoWidget extends StatelessWidget with Language, AppTheme {
  final AllProgressDataEntity data;

  const ProgressInfoWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label(e: en.ongoingCurriculum, b: bn.ongoingCurriculum),
          style: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              fontFamily: StringData.fontFamilyRoboto),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: size.h12,
        ),
        data.running.isNotEmpty
            ? RunningItemSectionWidget(
                items: data.running,
                buildItem: (BuildContext context, int index, item) {
                  return RunningItemWidget(
                    progressCourseDataEntity: item,
                    onTap: () {},
                  );
                })
            : SizedBox(
                height: 300.h,
                child: CustomEmptyWidget(
                  icon: Icons.school_outlined,
                  title: '',
                  message:
                      label(e: "No Course Found", b: "কোন কোর্স পাওয়া যায় নি"),
                ),
              ),
        SizedBox(
          height: size.h16,
        ),
        Text(
          label(e: 'Courses Completed', b: 'সম্পন্ন কোর্সসমূহ'),
          style: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              fontFamily: StringData.fontFamilyRoboto),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: size.h12,
        ),
        data.completed.isNotEmpty
            ? CompletedItemSectionWidget(
                items: data.completed,
                buildItem: (BuildContext context, int index, item) {
                  return CompletedCourseItemWidget(
                    completedCourseDataEntity: item,
                    onTap: () {},
                  );
                })
            : SizedBox(
                height: 300.h,
                child: CustomEmptyWidget(
                  icon: Icons.school_outlined,
                  title: '',
                  message:
                      label(e: "No Course Found", b: "কোন কোর্স পাওয়া যায় নি"),
                ),
              ),
      ],
    );
  }
}
