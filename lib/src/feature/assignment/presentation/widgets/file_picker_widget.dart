import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../dashboard/presentation/widgets/custom_text_widget.dart';

class FilePickerWidget<T> extends StatelessWidget with AppTheme, Language {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  final VoidCallback? onPickImage;
  final VoidCallback onPickFile;
  const FilePickerWidget({
    super.key,
    required this.items,
    required this.builder,
    this.onPickImage,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        borderRadius: BorderRadius.circular(size.r8),
        border: Border.all(color: clr.boxStrokeColor, width: size.w1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items.isEmpty
              ? Expanded(
                  child: CustomTextWidget(
                    text: label(
                        e: "Upload Your File Here",
                        b: "আপনার ফাইলটি এখানে আপলোড করুন"),
                    textColor: clr.textColorGray,
                    fontSize: size.textXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        builder(context, index, items[index]),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.h4);
                    },
                  ),
                ),
          // InkWell(
          //   onTap: onPickImage,
          //   child: Icon(
          //     Icons.add_a_photo,
          //     color: clr.iconColorHint,
          //     size: size.r24,
          //   ),
          // ),
          SizedBox(width: size.w12),
          InkWell(
            onTap: onPickFile,
            child: Icon(
              Icons.attach_file,
              color: clr.iconColorHint,
              size: size.r24,
            ),
          ),
        ],
      ),
    );
  }
}
