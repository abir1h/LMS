class ApiCredential {
  const ApiCredential._();

  // static String baseUrl = "http://103.209.40.89:91/api/clms/dev/mobile";
  static String baseUrl = "http://103.209.40.89";

  static String apiKey = "";

  static String getEMISLink = "http://103.209.40.89:81/api/auth/dev/emis-link";
  static String getToken = "http://103.209.40.89:81/api/auth/dev/emis-auth";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "http://103.209.40.89:70/api/clms/dev/profile";

  static String userDashboard = "/circular-service/api/mobile/dashboard";

  static String getCourse = "/circular-service/api/mobile/courses";
  static String getScript = "/circular-service/api/mobile/scripts";
  static String getBlendedClass =
      "/circular-service/api/mobile/blended-classes";
  static String getVideo = "/videos";

  static String getCircular = "/circular-service/api/mobile/circulars";

  static String createDiscussion = "/circular-service/api/web/discussion";
  static String getDiscussion =
      "/circular-service/api/web/discussion-content-wise";
  static String getDiscussionDetails = "/circular-service/api/web/discussion/";
  static String getDiscussionComments =
      "/circular-service/api/web/discussion-comments/";

  static String createComment = "/circular-service/api/web/comment";

  static String getAssessment = "/circular-service/api/mobile/assessment";
  static String getAssignment = "/assignment-service/api/mobile/assignments";

  static String getNotes = "/notes";
  static String getNotesByContent = "/notes-by-content";
}
