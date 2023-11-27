import 'package:demo/src/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class RowItemTemplate extends StatelessWidget with AppTheme {
  final Widget leftChild;
  final Widget rightChild;
  const RowItemTemplate(
      {super.key, required this.leftChild, required this.rightChild});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: leftChild),
          SizedBox(width: size.w16),
          Expanded(child: rightChild),
        ],
      ),
    );
  }
}
