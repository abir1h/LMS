class ApiCredential {
  const ApiCredential._();

  // static String baseUrl = "http://103.209.40.89:91/api/clms/dev/mobile";
  static String baseUrl = "http://103.209.40.89";

  static String apiKey = "";

  static String getEMISLink = "http://103.209.40.89:81/api/auth/dev/emis-link";
  static String eMISLink =
      "http://103.69.149.41/SSO/Account/Login?MerchantId=000010&token=obA5ijGMXHoQEiOtEYTlw34tyKVqM9pUVFcqaPNlC5e1reRojM&RETURNURL=http://103.209.40.89/auth-service/api/auth/emis-login";
  // static String getToken = "http://103.209.40.89:81/api/auth/dev/emis-auth";
  static String getToken =
      "http://103.209.40.89/auth-service/api/auth/emis-login";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "http://103.209.40.89:70/api/clms/dev/profile";

  static String userDashboard = "/circular-service/api/mobile/dashboard";

  static String getCourse = "/circular-service/api/mobile/courses";
  static String getScript = "/circular-service/api/mobile/scripts";
  static String getBlendedClass =
      "/circular-service/api/mobile/blended-classes";
  static String getVideo = "/videos";

  static String getCircular = "/circular-service/api/mobile/circulars";

  static String discussion = "/circular-service/api/mobile/discussion";
  static String getAllDiscussion = "/circular-service/api/mobile/discussions";
  static String getDiscussion =
      "/circular-service/api/mobile/discussion-content-wise";
  static String getDiscussionComments =
      "/circular-service/api/mobile/discussion-comments/";
  static String voteDiscussion = "/circular-service/api/mobile/vote-discussion";
  static String reportDiscussion =
      "/circular-service/api/mobile/report-discussion";

  static String createComment = "/circular-service/api/mobile/comment";
  static String voteComment = "/circular-service/api/mobile/vote-comment";
  static String reportComment = "/circular-service/api/mobile/report-comment";

  static String getAssessment = "/assessment-service/web/assessment-details";
  static String getAssessmentQuestionType =
      "/assessment-service/admin/quiz-types";
  static String startExam = "/assessment-service/web/exam/start";

  static String getAssignment = "/assignment-service/api/mobile/assignments";
  static String createAssignment =
      "/assignment-service/api/mobile/assignment-submissions";
  static String requestAssignment =
      "/assignment-service/api/mobile/assignment-request";

  static String getNotes = "/circular-service/api/mobile/notes";
  static String createNotes = "/circular-service/api/mobile/notes";
  static String getNotesByContent = "/circular-service/api/mobile/notes-by-content";
  static String contentRead = "/circular-service/api/mobile/content-read";

  static String getProfile = "/circular-service/api/mobile/profile";
  static String imageUrl = "$baseUrl/circular-service/uploads/";
}
