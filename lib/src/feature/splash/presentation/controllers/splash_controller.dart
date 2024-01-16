import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  final localStorage = Get.find<LocalStorageService>();
  final isLogged = false.obs;

  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () {
      _navigateBasedOnLogin();
    });
    super.onInit();
  }

  Future<void> _navigateBasedOnLogin() async {
    final loggedIn = await _isLoggedIn();

    if (loggedIn) {
      // Get.offNamed(AppRoutes.landing);
      Navigator.of(AppRoute.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
    } else {
      // Get.offNamed(AppRoutes.authenticate);
      Navigator.of(AppRoute.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoute.authenticationScreen, (x) => false);
    }
  }

  Future<bool> _isLoggedIn() async {
    isLogged.value =
        localStorage.getStringValue(StringData.accessTokenKey) != null;
    return isLogged.value;
  }
}
