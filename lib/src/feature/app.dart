import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constants/strings.dart';
import '../core/routes/app_routes.dart';
import '../core/constants/app_theme.dart';

class Application extends StatelessWidget with AppTheme {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'CLMS',
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(primary: clr.appPrimaryColorGreen),
              scaffoldBackgroundColor: clr.scaffoldBackgroundColor,
              dividerColor: Colors.transparent,
              fontFamily: StringData.fontFamilyPoppins,
            ),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          );
        });
  }
}
