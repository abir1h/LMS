import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/common_imports.dart';

class OpinionBottomSheet extends StatefulWidget {
  const OpinionBottomSheet({super.key});

  @override
  State<OpinionBottomSheet> createState() => _OpinionBottomSheetState();
}

class _OpinionBottomSheetState extends State<OpinionBottomSheet>
    with AppTheme, Language {
  TextEditingController titleController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.h28,
                ),
                SizedBox(width: size.w8),
                Expanded(
                  child: AppTextField(
                      hintText:
                          label(e: en.writeYourOpinion, b: bn.writeYourOpinion),
                      controller: titleController,
                      onTaped: () {
                        _scrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }),
                ),
                SizedBox(width: size.w4),
                InkWell(
                  onTap: () {
                    _scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(
                    Icons.send,
                    size: size.r28,
                    color: titleController.text.isNotEmpty
                        ? clr.appPrimaryColorGreen
                        : clr.placeHolderDeselectGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
