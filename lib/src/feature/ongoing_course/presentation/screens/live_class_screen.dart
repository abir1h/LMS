import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/constants/app_theme.dart';
import 'package:lms/src/core/utility/app_label.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/routes/app_routes.dart';

class LiveClassScreen extends StatefulWidget {
  const LiveClassScreen({super.key});

  @override
  State<LiveClassScreen> createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> with AppTheme {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.h56),
        child: CustomAppBar(
          title: "লাইভ ক্লাস",
          leadingOnPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          hasDivider: true,
          hasMenu: true,
          automaticallyImplyLeading: false,
          primaryColor: Colors.white,
          toolbarHeight: size.h56,
          trailingOnPressed: () {},
          trailing: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.notification),
            child: Stack(
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
          ),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: clr.appPrimaryColorGreen,
              size: size.r24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    ));
  }
}
