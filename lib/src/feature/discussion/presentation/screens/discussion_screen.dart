import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        type: MaterialType.transparency,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                    horizontal: size.w16, vertical: size.h16 + size.h2),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .84),
                decoration: BoxDecoration(
                  color: clr.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.r8),
                    topRight: Radius.circular(size.r8),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("hello"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
