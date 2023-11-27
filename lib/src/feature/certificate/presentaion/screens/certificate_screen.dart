import 'package:demo/src/core/constants/app_theme.dart';
import 'package:demo/src/core/constants/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../widgets/certificate_card.dart';
class CertificateScreen extends StatelessWidget with AppTheme{
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "স্বীকৃতিপত্র",
        actionChild: InkWell(
          onTap: () {},
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
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CertificateCard(),
              CertificateCard(),
              CertificateCard(),

            ],
          ),
        ));
  }
}
