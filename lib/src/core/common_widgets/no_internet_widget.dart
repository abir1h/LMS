import '../constants/common_imports.dart';

class NoInternetWidget extends StatelessWidget with AppTheme {
  final IconData icon;
  final String title;
  final String message;

  const NoInternetWidget(
      {super.key,
      this.icon = Icons.signal_wifi_bad,
      this.title = StringData.noInternetText,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.w24, vertical: size.h24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 80.r, color: clr.iconColorRed),
              SizedBox(height: size.h40),
              Text(
                title,
                style: TextStyle(
                    color: clr.appPrimaryColorGreen,
                    fontSize: size.textXMedium,
                    fontWeight: FontWeight.w600,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h12),
              Text(
                message,
                style: TextStyle(
                    color: clr.textColorBlack,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
              SizedBox(height: size.h4 + size.h32),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w20, vertical: size.h8),
                decoration: BoxDecoration(
                    color: clr.appPrimaryColorGreen,
                    borderRadius: BorderRadius.circular(size.w1 + size.w4)),
                child: Text(
                  StringData.pageReloadText,
                  style: TextStyle(
                      color: clr.whiteColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
