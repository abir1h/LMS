import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utility/app_label.dart';

class ProfileScreen extends StatefulWidget with AppTheme {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppTheme {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: clr.iconColorWhiteIce,
      drawer: const DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: "LMS My Profile",
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          trailingOnPressed: () {},
          trailing: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: clr.appPrimaryColorGreen,
                size: size.r24,
              ),
              Positioned(
                right: -1,
                top: 2.w,
                child: Container(
                  width: size.w12,
                  height: size.h12,
                  decoration: BoxDecoration(
                      color: clr.appPrimaryColorGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: clr.whiteColor)),
                ),
              ),
            ],
          ),
          leading: Icon(
            Icons.menu,
            color: clr.appPrimaryColorGreen,
            size: size.r24,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: size.h20),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: clr.cardStrokeColor)),
                      child: Image.asset(
                        ImageAssets.imgEmptyProfile2,
                        width: size.w4 + size.w56,
                      ),
                    ),
                    SizedBox(height: size.h12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.w16),
                      child: Text(
                        label(
                            e: StringData.userNameTextEn,
                            b: StringData.userNameTextBn),
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
                    SizedBox(height: size.h24)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.w24, right: size.w16, top: size.h16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(ImageAssets.icEdit),
                      CustomSwitchButton(
                        value: false,
                        textOn: 'English',
                        textSize: size.textXXSmall,
                        textOff: 'বাংলা',
                        bgColor: clr.whiteColor,
                        width: 85.w,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (bool state) {
                          print('turned ${(state) ? 'yes' : 'no'}');
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
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.w16),
              decoration: BoxDecoration(
                  color: clr.scaffoldBackgroundColor,
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
                  children: [
                    SizedBox(height: size.h40),
                    TitleWithIcon(
                        icon: Icons.account_balance,
                        title: label(
                            e: StringData.currentOrganizationNameTextEn,
                            b: StringData.currentOrganizationNameTextBn)),
                    TitleWithIcon(
                        icon: Icons.beenhere,
                        title: label(
                            e: StringData.positionNameTextEn,
                            b: StringData.positionNameTextBn)),
                    TitleWithIcon(
                        icon: Icons.badge,
                        title: label(
                            e: StringData.regNoTextEn,
                            b: StringData.regNoTextBn)),
                    TitleWithIcon(
                        icon: Icons.phone,
                        title: label(
                            e: StringData.phoneNumberTextEn,
                            b: StringData.phoneNumberTextBn)),
                    TitleWithIcon(
                        icon: Icons.email,
                        title: label(
                            e: StringData.emailTextEn,
                            b: StringData.emailTextBn)),
                    TitleWithIcon(
                      onTap: () => Get.toNamed(AppRoutes.certificate),
                      svgIcon: ImageAssets.icEditorChoice,
                      title: label(
                          e: StringData.certificateTextEn,
                          b: StringData.certificateTextBn),
                      hasTrailing: true,
                    ),
                    TitleWithIcon(
                      icon: Icons.logout,
                      title: label(
                          e: StringData.logoutTextEn,
                          b: StringData.logoutTextBn),
                      onTap: showLogoutPromptDialog,
                      hasBorder: false,
                    ),
                    SizedBox(height: size.h40),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: "আপনি কি লগ আউট করতে চান?",
      infoText:
          "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।",
      rightButtonText: "বাতিল করুন",
      leftButtonText: "প্রস্থান করুন",
    );
  }
}

class TitleWithIcon extends StatelessWidget with AppTheme {
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final bool hasBorder;
  final bool hasTrailing;
  final VoidCallback? onTap;
  const TitleWithIcon(
      {super.key,
      this.icon,
      this.svgIcon,
      required this.title,
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
            Expanded(
              child: Text(
                title,
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
