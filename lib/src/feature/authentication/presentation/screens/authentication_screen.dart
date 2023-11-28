import 'package:demo/src/core/common_widgets/custom_button.dart';
import 'package:demo/src/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with AppTheme {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  final _formKey = GlobalKey<FormState>();

  _sendAuthRequest() {
    if (authenticationController.userIdFocusNode.hasFocus) {
      authenticationController.userIdFocusNode.unfocus();
    }
    if (authenticationController.passFocusNode.hasFocus) {
      authenticationController.passFocusNode.unfocus();
    }
    if (_formKey.currentState!.validate()) {
      if (authenticationController.userIdEditingController.text.isNotEmpty &&
          authenticationController.passwordEditingController.text.isNotEmpty) {
        authenticationController.loginUserAccount(
          authenticationController.userIdEditingController.text,
          authenticationController.passwordEditingController.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: size.w28),
          child: Stack(
            children: [
              SizedBox(
                height: 1.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.h32),
                        Center(
                          child: Image.asset(
                            ImageAssets.icLogo,
                            height: size.h32 + size.h4,
                          ),
                        ),
                        SizedBox(height: size.h2 + size.h24),
                        Text(
                          StringData.authScreenHeaderText,
                          style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXMedium,
                              fontWeight: FontWeight.w500,
                              fontFamily: StringData.fontFamilyPoppins),
                        ),
                        SizedBox(height: size.h12),
                        Text(
                          StringData.authScreenContentText,
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textXSmall,
                            fontFamily: StringData.fontFamilyInter,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          StringData.authScreenContentText2,
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textXSmall,
                            fontFamily: StringData.fontFamilyInter,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          StringData.authScreenContentText3,
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textXSmall,
                            fontFamily: StringData.fontFamilyInter,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.h32 + size.h4),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AppTextField(
                                  hintText: StringData.userNameHintText,
                                  focusNode:
                                      authenticationController.userIdFocusNode,
                                  controller: authenticationController
                                      .userIdEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your PDSID';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: size.h12),
                                Obx(() => AppTextField(
                                      hintText: StringData.passwordHintText,
                                      focusNode: authenticationController
                                          .passFocusNode,
                                      controller: authenticationController
                                          .passwordEditingController,
                                      obscureText: authenticationController
                                              .watchPassword.value
                                          ? true
                                          : false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your password';
                                        }
                                        return null;
                                      },
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            authenticationController
                                                .toggleWatchPassword(
                                                    !authenticationController
                                                        .watchPassword.value);
                                          },
                                          child: Icon(
                                            authenticationController
                                                    .watchPassword.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: clr.iconColorHint,
                                            size: 20.r,
                                          )),
                                    )),
                                SizedBox(height: size.h24),
                              /*  CustomActionButton(
                                    title: StringData.loginText,
                                    controller: authenticationController
                                        .buttonController,
                                    onCheck: () => authenticationController
                                        .validateLoginForeignFormData(
                                            authenticationController
                                                .userIdEditingController,
                                            authenticationController
                                                .passwordEditingController),
                                    onSuccess: (e) {},
                                    tapAction: _sendAuthRequest),*/
                                CustomButton(onTap: ()=>Get.toNamed(AppRoutes.landing ), title: 'Login')
                              ],
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text.rich(TextSpan(
                            text: StringData.copyRightText2,
                            style: TextStyle(
                              color: clr.appPrimaryColorGreen,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyInter,
                            ),
                            children: [
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: StringData.copyRightText4,
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: StringData.copyRightText5,
                                style: TextStyle(
                                  color: clr.appPrimaryColorGreen,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                            ])),
                        Text.rich(TextSpan(
                            text: StringData.copyRightText,
                            style: TextStyle(
                              color: clr.textColorAppleBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: ThemeSize.instance.textXXSmall,
                              fontFamily: StringData.fontFamilyInter,
                            ),
                            children: [
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  color: clr.textColorAppleBlack,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                              TextSpan(
                                text: StringData.copyRightText3,
                                style: TextStyle(
                                  color: clr.textColorAppleBlack,
                                  fontSize: size.textXXSmall,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringData.fontFamilyInter,
                                ),
                              ),
                            ])),
                        SizedBox(height: size.h40)
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 16,
                child: CustomSwitchButton(
                  value: false,
                  textOn: 'English',
                  textSize: size.textXXSmall,
                  textOff: 'বাংলা',
                  bgColor: clr.whiteColor,
                  width: 85.w,
                  animationDuration: const Duration(milliseconds: 800),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
