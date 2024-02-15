import '../constants/common_imports.dart';
import 'local_storage_services.dart';

class AuthCacheManager {
  AuthCacheManager._();

  static storeUserInfo(
      String accessToken, String refreshToken, String expireAt) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    localStorageService.storeStringValue(
        StringData.accessTokenKey, accessToken);
    localStorageService.storeStringValue(
        StringData.refreshTokenKey, refreshToken);
    localStorageService.storeStringValue(StringData.expiresAt, expireAt);
  }

  static Future<String> getUserToken() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String token = localStorageService
            .getStringValue(StringData.accessTokenKey) ??
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoie1wiaWRcIjoxLFwibmFtZVwiOm51bGwsXCJlbXBpZFwiOlwiMTAxMzUzNzY0XCJ9IiwiaXNzIjoiaHR0cDovLzEwMy4yMDkuNDAuODk6ODEvIiwiYXVkIjoiaHR0cDovLzEwMy4yMDkuNDAuODk6ODEvIiwiaWF0IjoxNzA3Nzk1MTEwLCJuYmYiOjE3MDc3OTUxMTAsImV4cCI6MTcwNzgwNTkxMH0.sATodrBleM3kXoVeC3cfu6K7WiinxeFuKS3iasKRjJo";
    return token;
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
    localStorageService.removeValue(StringData.accessTokenKey);
    localStorageService.removeValue(StringData.refreshTokenKey);
    localStorageService.removeValue(StringData.expiresAt);
  }
}
