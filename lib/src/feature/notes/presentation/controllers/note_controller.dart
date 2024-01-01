import 'package:get/get.dart';

import '../models/note_model.dart';

class NoteController extends GetxController {
  final edit = false.obs;
  final noteIndex = "";
  final keyboardFocused = false.obs;
  final selectedTopic = ''.obs;
  List<String> topicList = [
    "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
    "টপিক নেইম : ভিডিও 3 | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
    "টপিক নেইম : ভিডিও 4 | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা."
  ];

  Future<List<String>> getDropDown() async {
    return topicList;
  }

  RxList<NoteModel> noteList = <NoteModel>[
    NoteModel(
        id: 1,
        title: "শিক্ষার্থীদের যোগ্যতা",
        reference: "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
        description: [
          {
            "insert":
                "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া."
          },
          {
            "attributes": {"code-block": true},
            "insert": "\n\n\n"
          },
          {"insert": "\n"}
        ],
        time: "2023-12-06"),
    NoteModel(
        id: 2,
        title: "আন্তঃসংযুক্ত আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা",
        reference: "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
        description: [
          {
            "insert":
                "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া.    সংক্ষিপ্ত করুন "
          },
          {
            "attributes": {"code-block": true},
            "insert": "\n\n\n"
          },
          {"insert": "\n"}
        ],
        time: "2023-12-06"),
    NoteModel(
        id: 3,
        title: "শিক্ষার্থীদের যোগ্যতা",
        reference: "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
        description: [
          {
            "insert":
                "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া."
          },
          {
            "attributes": {"code-block": true},
            "insert": "\n\n\n"
          },
          {"insert": "\n"}
        ],
        time: "2023-12-06"),
    NoteModel(
        id: 4,
        title: "শিক্ষার্থীদের যোগ্যতা",
        reference: "টপিক নেইম : ভিডিও ২ | শিক্ষাগত প্রয়োগ মানব-কল্যাণ ধারণা.",
        description: [
          {
            "insert":
                "প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া. প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া | প্রযুক্তি বিশ্বজুড়ে মানুষের কাছে শিক্ষা দেওয়ার পদ্ধতিকে বদলে দিয়েছে আমরা এখন একটি আন্তঃসংযুক্ত বিশ্বে বাস করি যেখানে আনুষ্ঠানিক শিক্ষার ঐতিহ্যগত ধারণা, একটি একক শারীরিক অবস্থানে সংঘটিত হওয়া."
          },
          {
            "attributes": {"code-block": true},
            "insert": "\n\n\n"
          },
          {"insert": "\n"}
        ],
        time: "2023-12-06"),
  ].obs;
}
