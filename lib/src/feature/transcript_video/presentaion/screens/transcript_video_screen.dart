import '../../../../core/constants/common_imports.dart';
import '../../../../core/common_widgets/custom_expanded_text.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_switch_button.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/youtube_player.dart';

class TranscriptVideoScreen extends StatefulWidget {
  const TranscriptVideoScreen({super.key});

  @override
  State<TranscriptVideoScreen> createState() => _TranscriptVideoScreenState();
}

class _TranscriptVideoScreenState extends State<TranscriptVideoScreen>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomYoutubePlayer(
          videoUrl: "uGqidUUFzwY",
          body: Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: size.h16, right: size.w16, left: size.w16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringData.transcriptTitle1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: StringData.fontFamilyPoppins,
                            fontWeight: FontWeight.w600,
                            fontSize: size.textSmall,
                            color: clr.appPrimaryColorGreen),
                      ),
                    ),
                    Icon(
                      Icons.download,
                      size: size.r20,
                      color: clr.appPrimaryColorGreen,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.w8),
                      child: CustomSwitchButton(
                        value: App.currentAppLanguage == AppLanguage.english,
                        textOn: 'English',
                        textSize: size.textXXSmall,
                        textOff: 'বাংলা',
                        bgColor: clr.whiteColor,
                        width: 85.w,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (bool state) {
                          App.setAppLanguage(state ? 1 : 0).then((value) {
                            if (mounted) {
                              setState(() {});
                            }
                          });
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
                SizedBox(height: size.h8),
                Text(
                  StringData.transcriptTitle1Description,
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w400,
                      color: clr.textColorBlack),
                ),
                SizedBox(height: size.h12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onTap: () {},
                      icon: Icons.add,
                      title: 'নোট নিন',
                      textSize: size.textXXXSmall,
                      horizontalPadding: size.w10,
                      verticalPadding: 6.5.h,
                      radius: size.w8,
                    ),
                    SizedBox(width: size.w16),
                    CustomButton(
                      onTap: () {},
                      icon: Icons.add,
                      title: 'আলোচনা',
                      textSize: size.textXXXSmall,
                      horizontalPadding: size.w10,
                      verticalPadding: 6.5.h,
                      radius: size.w8,
                    )
                  ],
                ),
                SizedBox(height: size.h16),
                Text(
                  StringData.transcriptTitle2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontWeight: FontWeight.w600,
                      fontSize: size.textSmall,
                      color: clr.appPrimaryColorGreen),
                ),
                SizedBox(height: size.h8),
                ExpandableText(
                  text: StringData.transcriptTitle2Description,
                  style: TextStyle(
                      fontFamily: StringData.fontFamilyPoppins,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w400,
                      color: clr.textColorBlack),
                  minimumTextLengthToFold: 200,
                ),
                SizedBox(height: size.h56),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 106.w),
                  child: CustomButton(
                    onTap: () {},
                    title: ' পরবর্তী',
                    verticalPadding: 2.h,
                    radius: size.w4,
                  ),
                ),
                SizedBox(height: size.h56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
