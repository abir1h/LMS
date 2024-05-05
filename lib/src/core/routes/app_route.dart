import 'package:flutter/material.dart';

import '../../feature/assessment/presentation/screens/assessment_screen.dart';
import '../../feature/assignment/presentation/screens/assignment_screen.dart';
import '../../feature/assignment/presentation/screens/assignment_submit_screen.dart';
import '../../feature/authentication/presentation/screens/authentication_screen.dart';
import '../../feature/authentication/presentation/screens/emis_webview_screen.dart';
import '../../feature/circular/presentation/screens/circular_details_screen.dart';
import '../../feature/circular/presentation/screens/circular_screen.dart';
import '../../feature/course/presentation/screens/course_assessment_screen.dart';
import '../../feature/course/presentation/screens/course_assignment_screen.dart';
import '../../feature/course/presentation/screens/course_details_screen.dart';
import '../../feature/course/presentation/screens/course_script_screen.dart';
import '../../feature/course/presentation/screens/course_list_screen.dart';
import '../../feature/course/presentation/screens/course_live_class_screen.dart';
import '../../feature/course/presentation/screens/overall_progress_screen.dart';
import '../../feature/discussion/presentation/screens/detailed_discussion.dart';
import '../../feature/discussion/presentation/screens/discussion_list_screen.dart';
import '../../feature/discussion/presentation/screens/discussion_screen.dart';
import '../../feature/landing/presentation/screens/landing_screen.dart';
import '../../feature/leaderboard/presentation/screens/leaderboard_screen.dart';
import '../../feature/notes/presentation/screens/note_details_screen.dart';
import '../../feature/notes/presentation/screens/note_edit_screen.dart';
import '../../feature/notification/presentation/screens/notification_screen.dart';
import '../../feature/root/presentation/screens/root_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';
import '../../feature/transcript_video/presentaion/screens/transcript_video_screen.dart';

class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String authenticationScreen = "authenticationScreen";
  static const String eMISWebViewScreen = "eMISWebViewScreen";

  static const String landingScreen = "landingScreen";
  static const String rootScreen = "rootScreen";
  static const String notificationScreen = "notificationScreen";
  static const String leaderboardScreen = "leaderboardScreen";
  static const String overallProgressScreen = "overallProgressScreen";
  static const String courseListScreen = "courseListScreen";
  static const String courseDetailsScreen = "courseDetailsScreen";
  static const String courseScriptScreen = "courseScriptScreen";
  static const String transcriptVideoScreen = "transcriptVideoScreen";
  static const String courseAssignmentScreen = "courseAssignmentScreen";
  static const String courseLiveClassScreen = "courseLiveClassScreen";
  static const String courseAssessmentScreen = "courseAssessmentScreen";
  static const String discussionScreen = "discussionScreen";
  static const String assignmentScreen = "assignmentScreen";
  static const String assignmentSubmitScreen = "assignmentSubmitScreen";
  static const String assessmentScreen = "assessmentScreen";
  static const String detailedDiscussion = "detailedDiscussion";
  static const String discussionListScreen = "discussionListScreen";
  static const String noteDetailsScreen = "noteDetailsScreen";
  static const String noteEditScreen = "noteEditScreen";
  static const String circularScreen = "circularScreen";
  static const String circularDetailsScreen = "circularDetailsScreen";
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(
      builder: (context) {
        switch (setting.name) {
          ///StartUp
          case AppRoute.splashScreen:
            return const SplashScreen();
          case AppRoute.authenticationScreen:
            return const AuthenticationScreen();
          case AppRoute.eMISWebViewScreen:
            return EMISWebViewScreen(arguments: setting.arguments);

          ///User Landing
          case AppRoute.landingScreen:
            return const LandingScreen();
          case AppRoute.rootScreen:
            return RootScreen(arguments: setting.arguments);

          case AppRoute.notificationScreen:
            return const NotificationScreen();
          case AppRoute.leaderboardScreen:
            return const LeaderboardScreen();
          case AppRoute.overallProgressScreen:
            return const OverallProgressScreen();

          ///Course
          case AppRoute.courseListScreen:
            return CourseListScreen(arguments: setting.arguments);
          case AppRoute.courseDetailsScreen:
            return CourseDetailsScreen(arguments: setting.arguments);
          case AppRoute.courseScriptScreen:
            return CourseScriptScreen(arguments: setting.arguments);
          case AppRoute.transcriptVideoScreen:
            return const TranscriptVideoScreen();
          case AppRoute.courseAssignmentScreen:
            return CourseAssignmentScreen(arguments: setting.arguments);
          case AppRoute.courseLiveClassScreen:
            return CourseLiveClassScreen(arguments: setting.arguments);
          case AppRoute.courseAssessmentScreen:
            return CourseAssessmentScreen(arguments: setting.arguments);
          case AppRoute.discussionScreen:
            return const DiscussionScreen();
          case AppRoute.assignmentScreen:
            return const AssignmentScreen();
          case AppRoute.assignmentSubmitScreen:
            return AssignmentSubmitScreen(arguments: setting.arguments);
          case AppRoute.assessmentScreen:
            return const AssessmentScreen();
          case AppRoute.detailedDiscussion:
            return DetailedDiscussion(arguments: setting.arguments);
          case AppRoute.discussionListScreen:
            return const DiscussionListScreen();
          case AppRoute.noteDetailsScreen:
            return NoteDetailsScreen(arguments: setting.arguments);
          case AppRoute.noteEditScreen:
            return NoteEditScreen(arguments: setting.arguments);
          case AppRoute.circularScreen:
            return const CircularScreen();
          case AppRoute.circularDetailsScreen:
            return CircularDetailsScreen(arguments: setting.arguments);

          default:
            return const SplashScreen();
        }
      },
    );
  }
}

///This defines the animation of routing one page to another
class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  FadeInOutRouteBuilder({required this.builder})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return builder(context);
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                  0.50,
                  1.00,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: child,
          );
        });
}
