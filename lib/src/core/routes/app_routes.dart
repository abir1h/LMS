import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../feature/course/presentation/screens/course_list_screen.dart';
import '../../feature/course/presentation/screens/course_screen.dart';
import '../../feature/course/presentation/screens/course_introduction_screen.dart';
import '../../feature/discussion/presentation/binding/discussion_binding.dart';
import '../../feature/discussion/presentation/screens/detailed_discussion.dart';
import '../../feature/discussion/presentation/screens/discussion_list_screen.dart';
import '../../feature/discussion/presentation/screens/discussion_screen.dart';

import '../../feature/course/presentation/bindings/course_binding.dart';
import '../../feature/course/presentation/screens/course_details_screen.dart';
import '../../feature/dashboard/presentation/binding/dashboard_binding.dart';
import '../../feature/dashboard/presentation/screens/dashboard_screen.dart';
import '../../feature/notes/presentation/bindings/note_binding.dart';
import '../../feature/notes/presentation/screens/note_screen.dart';
import '../../feature/notification/presentation/bindings/notification_binding.dart';
import '../../feature/notification/presentation/screens/notification_screen.dart';
import '../../feature/root/presentation/binding/root_binding.dart';
import '../../feature/root/presentation/screens/root_screen.dart';
import '../../feature/splash/presentation/bindings/splash_binding.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';
import '../../feature/authentication/presentation/bindings/authentication_binding.dart';
import '../../feature/authentication/presentation/screens/authentication_screen.dart';
import '../../feature/landing/presentation/bindings/landing_binding.dart';
import '../../feature/landing/presentation/screens/landing_screen.dart';
import '../../feature/ongoing_course/presentation/bindings/ongoing_course_binding.dart';
import '../../feature/ongoing_course/presentation/screens/ongoing_course_screen.dart';
import '../../feature/profile/presentation/bindings/profile_binding.dart';
import '../../feature/profile/presentation/screens/profile_screen.dart';
import '../../feature/transcript_video/presentaion/bindings/transcript_video_binding.dart';
import '../../feature/transcript_video/presentaion/screens/transcript_video_screen.dart';

class AppRoutes {
  AppRoutes._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splash = '/splash';
  static const String authenticate = '/authenticate';
  static const String landing = '/landing';
  static const String dashboard = '/dashboard';
  static const String course = '/course';
  static const String courseList = '/course_list';
  static const String courseDetails = '/course_details';
  static const String profile = '/profile';
  static const String ongoingCourse = '/ongoingCourse';
  static const String bottomNav = '/bottomNav';
  static const String transcriptVideo = '/transcript_video';
  static const String notification = '/notification';
  static const String notes = '/notes';
  static const String discussion = '/discussion';
  static const String discussionList = '/discussionList';
  static const String detailedDiscussion = '/detailedDiscussion';
  static const String introduction = '/introduction';
}

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.authenticate,
      page: () => const AuthenticationScreen(),
      binding: AuthenticationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.landing,
      page: () => const LandingScreen(),
      binding: LandingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.course,
      page: () => const CourseScreen(),
      binding: CourseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.courseList,
      page: () => const CourseListScreen(),
      binding: CourseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.courseDetails,
      page: () => const CourseDetailsScreen(),
      binding: CourseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ongoingCourse,
      page: () => const OngoingCourseScreen(),
      binding: OngoingCourseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const RootScreen(),
      binding: RootBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transcriptVideo,
      page: () => const TranscriptVideoScreen(),
      binding: TranscriptVideoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notes,
      page: () => const NoteScreen(),
      binding: NoteBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.discussion,
      page: () => const DiscussionScreen(),
      binding: DiscussionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.discussionList,
      page: () => const DiscussionListScreen(),
      binding: DiscussionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.detailedDiscussion,
      page: () => const DetailedDiscussion(),
      binding: DiscussionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.introduction,
      page: () => const CourseIntroductionScreen(),
      binding: CourseBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
