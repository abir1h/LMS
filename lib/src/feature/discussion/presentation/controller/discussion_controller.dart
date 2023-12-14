import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:lms/src/feature/discussion/models/comment_model.dart';
import 'package:lms/src/feature/discussion/models/discusion_model.dart';

class DiscussionController extends GetxController {
  final discussionList = <DiscussionModel>[
    DiscussionModel(
        discussionId: 1,
        userName: "ব্যবহারকারীর নাম",
        description:
            "শিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে।",
        createdAt: " ২০ নভেম্বর ২০২৩",
        avatar: ImageAssets.imgEmptyProfile,
        title:
            "শিক্ষার্থীদের যোগ্যতাশিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান",
        comments: [
          CommentModel(
              commentId: 1,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 2,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 3,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
        ]),
    DiscussionModel(
        discussionId: 2,
        userName: "ব্যবহারকারীর নাম",
        description:
            "শিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে।",
        createdAt: " ২০ নভেম্বর ২০২৩",
        avatar: ImageAssets.imgEmptyProfile,
        title: "শিক্ষার্থীদের যোগ্যতা",
        comments: [
          CommentModel(
              commentId: 1,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 2,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 3,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
        ]),
    DiscussionModel(
        discussionId: 3,
        userName: "ব্যবহারকারীর নাম",
        description:
            "শিক্ষার্থীদের যোগ্যতা ফিজিওলজি হল একটি সমন্বিত বিজ্ঞান যা প্রতিটি অঙ্গ এবং অঙ্গ সিস্টেমের কাজ এবং জীবনের রক্ষণাবেক্ষণে তাদের মিথস্ক্রিয়া বিবেচনা করে।",
        createdAt: " ২০ নভেম্বর ২০২৩",
        avatar: ImageAssets.imgEmptyProfile,
        title: "শিক্ষার্থীদের যোগ্যতা",
        comments: [
          CommentModel(
              commentId: 1,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 2,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 3,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
          CommentModel(
              commentId: 4,
              userName: "ব্যবহারকারীর নাম",
              avatar: ImageAssets.imgEmptyProfile,
              comment:
                  "শিক্ষার্থীদের যোগ্যতাগুলো অর্জনের জন্য এই সহায়িকায় যেসব শিখন-অভিজ্ঞতা রয়েছে",
              likeCount: 0,
              createdAt: "২০ নভেম্বর ২০২৩"),
        ]),
  ];

  addDiscussion(DiscussionModel model) {
    discussionList.add(model);
    update();
    Get.back();
  }

  addComment(DiscussionModel master, CommentModel comment) {
    master.comments!.add(comment);
    update();
  }

  addVote() {}

  @override
  void onInit() {
    super.onInit();
  }
}
