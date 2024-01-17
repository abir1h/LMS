import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';

class LandingController extends GetxController {
  RxBool isLogged = false.obs;

  @override
  void onInit() {
    localStorage();
    super.onInit();
  }

  localStorage() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    isLogged.value =
        localStorageService.getStringValue(StringData.accessTokenKey) != null;
  }

  void logout() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    localStorageService.clearAllValues();
    isLogged(false);
    Navigator.of(AppRoute.navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(AppRoute.authenticationScreen, (x) => false);
  }
}
