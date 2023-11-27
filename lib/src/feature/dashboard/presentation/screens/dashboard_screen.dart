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
                  // image: SvgPicture.asset(
                  //   ImageAssets.imgRunningCourse,
                  //   width: 66.w,
                  //   fit: BoxFit.cover,
                  // ),
                  text1: StringData.cardText1,
                  text2: StringData.cardText2,
                  text3: StringData.cardText3,
                  primaryColor: Colors.white,
                ),
                SizedBox(height: size.h20),
                RowItemTemplate(
                    leftChild: DashboardCard(
                      text1: StringData.dashboardCard1,
                      onPressed: () {},
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
                      onPressed: () {},
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
                const LineChartSample2(),
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


                /*LineChartSample2(),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(.4),
                  highlightColor: Colors.grey.shade100,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BannerPlaceholder(),
                      TitlePlaceholder(width: double.infinity),
                      SizedBox(height: 16.0),
                      ContentPlaceholder(
                        lineType: ContentLineType.threeLines,
                      ),
                      SizedBox(height: 16.0),
                      TitlePlaceholder(width: 200.0),
                      SizedBox(height: 16.0),
                      ContentPlaceholder(
                        lineType: ContentLineType.twoLines,
                      ),
                      SizedBox(height: 16.0),
                      TitlePlaceholder(width: 200.0),
                      SizedBox(height: 16.0),
                      ContentPlaceholder(
                        lineType: ContentLineType.twoLines,
                      ),
                    ],
                  ),
                  ),*/
              ],
            ),
          ),
        ));
  }
}

/*class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}*/
