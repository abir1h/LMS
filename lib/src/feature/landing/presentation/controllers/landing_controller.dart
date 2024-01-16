import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_routes.dart';

class LandingController extends GetxController {
  final localStorage = Get.find<LocalStorageService>();

  RxBool isLogged = false.obs;

  @override
  void onInit() {
    isLogged.value =
        localStorage.getStringValue(StringData.accessTokenKey) != null;
    super.onInit();
  }

  void logout() {
    localStorage.clearAllValues();
    isLogged(false);
    // Get.offAllNamed(AppRoutes.authenticate);
    Navigator.of(AppRoute.navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(AppRoute.authenticationScreen, (x) => false);
  }
}
