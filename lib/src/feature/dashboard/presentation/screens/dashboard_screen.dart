import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../landing/presentation/widgets/row_item_template.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../widgets/custom_notice_card.dart';
import '../controller/dashboard_controller.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../widgets/course_card.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/graph_chart.dart';
import '../../../../core/constants/common_imports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AppTheme {
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: clr.scaffoldBackgroundColor,
        drawer: const DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.h56),
          child: CustomAppBar(
            title: StringData.appBarText1,
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomTextWidgets(text: StringData.runningCourse),
                    Padding(
                      padding: EdgeInsets.only(right: size.w6),
                      child: SvgPicture.asset(ImageAssets.icLockOpenRight),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                CourseCard(
                  onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                  image: Image.asset("assets/images/image.png"),
                  text1: StringData.cardText1,
                  text2: StringData.cardText2,
                  text3: StringData.cardText3,
                  primaryColor: Colors.white,
                ),
                SizedBox(height: size.h20),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      text1: StringData.dashboardCard1,
                      onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                      text2: StringData.dashboardCardValue1,
                      borderColor: clr.cardStrokeColorOrange,
                      primaryColor: clr.cardFillColorOrange,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard1,
                        height: size.h32,
                      ),
                    ),
                    rightChild: DashboardCard(
                      text1: StringData.dashboardCard2,
                      onPressed: () => Get.toNamed(AppRoutes.ongoingCourse),
                      text2: StringData.dashboardCardValue2,
                      borderColor: clr.cardStrokeColorGreen,
                      primaryColor: clr.cardFillColorGreen,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard1,
                        height: size.h32,
                      ),
                    )),
                SizedBox(height: size.h12),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      text1: StringData.dashboardCard3,
                      onPressed: () {},
                      text2: StringData.dashboardCardValue3,
                      borderColor: clr.cardStrokeColorPurple,
                      primaryColor: clr.cardFillColorPurple,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard3,
                        height: size.h32,
                      ),
                    ),
                    rightChild: DashboardCard(
                      text1: StringData.dashboardCard4,
                      onPressed: () {
                        Get.toNamed(AppRoutes.certificate);
                      },
                      text2: StringData.dashboardCardValue4,
                      borderColor: clr.cardFillColorBlue,
                      primaryColor: clr.cardStrokeColorBlue,
                      image: SvgPicture.asset(
                        ImageAssets.imgTraineeCard3,
                        height: size.h32,
                      ),
                    )),
                SizedBox(height: size.h32),
                const CustomTextWidgets(text: StringData.karjo),
                SizedBox(height: size.h12),
                const GraphChart(),
                SizedBox(height: size.h20),
                const CustomTextWidgets(text: StringData.noticeBoard),
                SizedBox(height: size.h12),
                CustomNoticeCard(
                    leading: Icon(
                      Icons.auto_stories,
                      color: clr.appPrimaryColorGreen,
                      size: size.r20,
                    ),
                    title: StringData.notice1),
                SizedBox(height: size.h32),
              ],
            ),
          ),
        ));
  }
}
