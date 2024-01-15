import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../controllers/accessibility_controller.dart';

class AccessibilityBottomSheet extends StatefulWidget {
  const AccessibilityBottomSheet({super.key});

  @override
  State<AccessibilityBottomSheet> createState() =>
      _AccessibilityBottomSheetState();
}

class _AccessibilityBottomSheetState extends State<AccessibilityBottomSheet>
    with AppTheme, Language {
  final AccessibilityController accessibilityController =
      Get.put(AccessibilityController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
            decoration: BoxDecoration(
              color: clr.shadeWhiteColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.r12),
                topRight: Radius.circular(size.w12),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.h10),
                    child: Text(
                      label(e: en.accessibilityText, b: bn.accessibilityText),
                      style: TextStyle(
                        color: clr.textColorAppleBlack,
                        fontSize: size.textSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.w10),
                        child: Icon(
                          Icons.invert_colors,
                          size: size.r24,
                          color: clr.iconColorHint,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          label(e: en.monochromeText, b: bn.monochromeText),
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: size.w40,
                          height: size.h40,
                          child: FittedBox(
                            child: CupertinoSwitch(
                              applyTheme: true,
                              value: accessibilityController.isGrayscale.value,
                              onChanged: (v) {
                                accessibilityController.toggleGrayscale();
                              },
                              activeColor: clr.appPrimaryColorGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.w10),
                        child: Icon(
                          Icons.text_increase,
                          size: size.r24,
                          color: clr.iconColorHint,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          label(e: en.textSizeText, b: bn.textSizeText),
                          style: TextStyle(
                            color: clr.textColorAppleBlack,
                            fontSize: size.textSmall,
                            fontFamily: StringData.fontFamilyPoppins,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.w40,
                        height: size.h40,
                        child: FittedBox(
                            child: CupertinoSwitch(
                          applyTheme: true,
                          value: false,
                          onChanged: (v) {},
                          activeColor: clr.appPrimaryColorGreen,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
