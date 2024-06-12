import '../constants/common_imports.dart';
import 'local_storage_services.dart';

class AuthCacheManager {
  AuthCacheManager._();

  static storeUserInfo(String userId, String userName, String role,
      String accessToken, String refreshToken, String expireIn) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    localStorageService.storeStringValue(StringData.userId, userId);
    localStorageService.storeStringValue(StringData.userName, userName);
    localStorageService.storeStringValue(StringData.role, role);
    localStorageService.storeStringValue(
        StringData.accessTokenKey, accessToken);
    localStorageService.storeStringValue(
        StringData.refreshTokenKey, refreshToken);
    localStorageService.storeStringValue(StringData.expiresIn, expireIn);
  }

  static Future<String> getUserToken() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String token =
        localStorageService.getStringValue(StringData.accessTokenKey) ?? "";
    return token;
  }

  static Future<String> getUserId() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String userId = localStorageService.getStringValue(StringData.userId) ?? "";
    return userId;
  }

  static Future<bool> isUserLoggedIn() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? token =
        localStorageService.getStringValue(StringData.accessTokenKey);
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  static userLogout() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    localStorageService.removeValue(StringData.userId);
    localStorageService.removeValue(StringData.userName);
    localStorageService.removeValue(StringData.role);
    localStorageService.removeValue(StringData.accessTokenKey);
    localStorageService.removeValue(StringData.refreshTokenKey);
    localStorageService.removeValue(StringData.expiresIn);
  }
}
