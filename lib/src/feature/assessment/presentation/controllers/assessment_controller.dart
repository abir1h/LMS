import 'package:get/get.dart';

import '../models/blank_model.dart';

class AssessmentController extends GetxController {
  List<BlankModel> qusList=[
    BlankModel(
      fillIntheGapModelId:0,
      title: "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
      description: "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"

    ), BlankModel(
      fillIntheGapModelId:0,
      title: "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
      description: "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"

    ), BlankModel(
      fillIntheGapModelId:0,
      title: "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
      description: "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"

    ),
  ];
  @override
  void onInit() {
    super.onInit();
  }
}
