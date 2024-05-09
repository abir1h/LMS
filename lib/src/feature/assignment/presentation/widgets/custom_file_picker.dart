import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(String) onFilePicked;
  final Widget child;

  const CustomFilePicker(
      {super.key, required this.onFilePicked, required this.child});

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  final List<File> files = [];

  void _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      String filePath = result.files.single.path!;
      widget.onFilePicked(filePath);
    } else {
      // User canceled the file picking
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("tapped");
          _pickFile();
        },
        child: widget.child);
  }
}
