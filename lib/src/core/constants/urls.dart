class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://103.209.40.89:81/api";
  static String apiKey = "";

  static String getEMISLink = "/auth/dev/emis-link";
  static String getToken = "/auth/dev/token";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "/profile";
  static String userDashboard = "/dashboard";

}
