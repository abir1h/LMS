import 'package:get/get.dart';
import 'package:lms/src/core/constants/common_imports.dart';

import '../models/blank_model.dart';
import '../models/quiz_model.dart';

class AssessmentController extends GetxController {
  List<BlankModel> qusList = [
    BlankModel(
        fillInTheGapModelId: 0,
        title:
            "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
        description:
            "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"),
    BlankModel(
        fillInTheGapModelId: 0,
        title:
            "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
        description:
            "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"),
    BlankModel(
        fillInTheGapModelId: 0,
        title:
            "অনুগ্রহ করেবাক্য গুলো পড়ুন এবং শূন্যস্থানের জন্য সঠিক উত্তরটি লিখুন।",
        description:
            "রবীন্দ্রনাথ ঠাকুর  _____  উপন্যাসের উপর নভেল পুরস্কার লাভ করেন এবং তিনি _____ সালে এটি অর্জন করেন|"),
  ];

  List<QuestionsEntity> questions = [
    QuestionsEntity(
      id: 0,
      questionText:
          "শেখার জন্য শিক্ষাদানের প্রযুক্তি হল তাদের শিক্ষা, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো সময়?",
      questionImage: "",
      option1: "উত্তর বিকল্প ১",
      option2: "উত্তর বিকল্প ২",
      option3: "উত্তর বিকল্প ৩",
      option4: "উত্তর বিকল্প ৪",
      option5: "উত্তর বিকল্প ৫",
      option1Image: "",
      option2Image: "",
      option3Image: "",
      option4Image: "",
      option5Image: "",
      userAnswer1: false,
      userAnswer2: false,
      userAnswer3: false,
      userAnswer4: false,
      userAnswer5: false,
      answer1: true,
      answer2: false,
      answer3: false,
      answer4: false,
      answer5: false,
    ),
    QuestionsEntity(
      id: 0,
      questionText:
          "শেখার জন্য শিক্ষাদানের প্রযুক্তি হল তাদের শিক্ষা, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো সময়?",
      questionImage: "",
      option1: "উত্তর বিকল্প ১",
      option2: "উত্তর বিকল্প ২",
      option3: "উত্তর বিকল্প ৩",
      option4: "উত্তর বিকল্প ৪",
      option5: "উত্তর বিকল্প ৫",
      option1Image: "",
      option2Image: "",
      option3Image: "",
      option4Image: "",
      option5Image: "",
      userAnswer1: false,
      userAnswer2: false,
      userAnswer3: false,
      userAnswer4: false,
      userAnswer5: false,
      answer1: true,
      answer2: false,
      answer3: false,
      answer4: false,
      answer5: false,
    ),
    QuestionsEntity(
      id: 0,
      questionText:
          "শেখার জন্য শিক্ষাদানের প্রযুক্তি হল তাদের শিক্ষা, বা যারা শিক্ষা দিতে চান, যে কোনো বিষয়ে, যে কোনো সময়?",
      questionImage: "",
      option1: "উত্তর বিকল্প ১",
      option2: "উত্তর বিকল্প ২",
      option3: "উত্তর বিকল্প ৩",
      option4: "উত্তর বিকল্প ৪",
      option5: "উত্তর বিকল্প ৫",
      option1Image: "",
      option2Image: "",
      option3Image: "",
      option4Image: "",
      option5Image: "",
      userAnswer1: false,
      userAnswer2: false,
      userAnswer3: false,
      userAnswer4: false,
      userAnswer5: false,
      answer1: true,
      answer2: false,
      answer3: false,
      answer4: false,
      answer5: false,
    ),
    QuestionsEntity(
      id: 0,
      questionText:
          "নিচের চিত্রে পর্যায়ক্রম অনুসারে যে চিত্রটি আসবে সেটি নির্বাচন করুন",
      questionImage: ImageAssets.imgQuestion,
      option1: "",
      option2: "",
      option3: "",
      option4: "",
      option5: "",
      option1Image: ImageAssets.imgOption1,
      option2Image: ImageAssets.imgOption2,
      option3Image: ImageAssets.imgOption3,
      option4Image: ImageAssets.imgOption3,
      option5Image: "",
      userAnswer1: false,
      userAnswer2: false,
      userAnswer3: false,
      userAnswer4: false,
      userAnswer5: false,
      answer1: true,
      answer2: false,
      answer3: false,
      answer4: false,
      answer5: false,
    ),
  ];
  @override
  void onInit() {
    super.onInit();
  }
}
