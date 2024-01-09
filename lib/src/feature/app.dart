import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final GrayscaleController grayscaleController =
    Get.put(GrayscaleController());

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Obx(() => ColorFiltered(
           colorFilter: grayscaleController.isGrayscale.value? const ColorFilter.matrix(<double>[
             0.2126, 0.7152, 0.0722, 0, 0,
             0.2126, 0.7152, 0.0722, 0, 0,
             0.2126, 0.7152, 0.0722, 0, 0,
             0,      0,      0,      1, 0,
           ]):const ColorFilter.mode(
               Colors.transparent, BlendMode.srcOver),
            child: GetMaterialApp(
              title: 'CLMS',
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(primary: clr.appPrimaryColorGreen),
                  scaffoldBackgroundColor: clr.scaffoldBackgroundColor,
                  dividerColor: Colors.transparent,
                  fontFamily: StringData.fontFamilyPoppins,canvasColor: Colors.transparent

              ),
              initialRoute: AppRoutes.splash,
              getPages: AppPages.pages,
            ),
          ));
        });
  }
}

class GrayscaleController extends GetxController {
  RxBool isGrayscale = false.obs;

  void toggleGrayscale() {
    isGrayscale.toggle();
  }
}