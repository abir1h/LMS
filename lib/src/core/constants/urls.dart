class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://103.209.40.89:91/api/clms/dev/mobile";

  static String apiKey = "";

  static String getEMISLink = "http://103.209.40.89:81/api/auth/dev/emis-link";
  static String getToken = "http://103.209.40.89:81/api/auth/dev/emis-auth";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "http://103.209.40.89/api/clms/dev/profile";

  static String userDashboard = "/dashboard";
  static String getCourse = "/courses";
  static String getScript = "/scripts";
  static String getBlendedClass = "/blended-classes";
  static String getVideo = "/videos";

  static String getDiscussion = "/discussions";
  static String getDiscussionComments = "/discussion-comments";
  static String getComments = "/comments";

  static String getAssessment = "/assessment";
  static String getAssignment = "/assignments";

  static String getNotes = "/notes";
  static String getNotesByContent = "/notes-by-content";
}
