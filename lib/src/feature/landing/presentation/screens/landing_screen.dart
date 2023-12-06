import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/notification_client.dart';
import '../../../../core/config/push_notification.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/landing_controller.dart';
import '../widgets/module_card_widget.dart';
import '../widgets/row_item_template.dart';
import '../../../../core/constants/common_imports.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with AppTheme {
  final LandingController landingController = Get.find<LandingController>();

  ///Service configurations
  @override
  void initState() {
    ///Init notification and firebase
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PushNotification.instance.init();
      NotificationClient.instance.startListening(onNotificationClicked,_onNotificationReceived).then(_onFCMTokenUpdate).catchError((_){});
    });
  }
  @override
  void dispose() {
    NotificationClient.instance.stopListening();
    PushNotification.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: clr.secondaryBackgroundColor,
        title: Text(
          StringData.appBarText,
          style: TextStyle(
              color: clr.appPrimaryColorGreen,
              fontSize: size.textXMedium,
              fontWeight: FontWeight.w500,
              fontFamily: StringData.fontFamilyPoppins),
        ),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.h1),
            child: Container(
              color: clr.cardStrokeColor,
              height: size.h1,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h16),
        child: Column(
          children: [
            RowItemTemplate(
                leftChild: ModuleCardWidget(
                  image: ImageAssets.imgModule1,
                  text: StringData.learningManagementSystem,
                  onTap: () => Get.toNamed(AppRoutes.bottomNav),
                ),
                rightChild: ModuleCardWidget(
                  image: ImageAssets.imgModule2,
                  text: StringData.teachersGuideBn,
                )),
            SizedBox(height: size.h16),
            RowItemTemplate(
              leftChild: ModuleCardWidget(
                image: ImageAssets.imgModule3,
                text: StringData.eLibraryBn,
              ),
              rightChild: ModuleCardWidget(
                image: ImageAssets.imgModule4,
                text: StringData.formativeAssessmentBn,
              ),
            ),
            SizedBox(height: size.h16),
            RowItemTemplate(
                leftChild: ModuleCardWidget(
                  image: ImageAssets.imgModule2,
                  text: StringData.socialLearningPlatformBn,
                ),
                rightChild: Container()),
          ],
        ),
      ),
    );
  }
  ///Push Notification Section
  void _onFCMTokenUpdate(String? token)async {
    print(token);
  }

  void onNotificationClicked(NotificationEntity notification, {bool isFromTray = true})async{
    try{
      ///Is notification clicked from system tray then wait some time to finish loading
      if(isFromTray) await Future.delayed(const Duration(milliseconds: 500));


      ///Mark notification as seen
      _markNotificationAsSeen(notification);
    }
    catch (error){
      debugPrint(error.toString());
    }
  }
  void _onNotificationReceived(NotificationEntity notification)async{


  }
  void _markNotificationAsSeen(NotificationEntity notification) {


  }

}
