import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/common_imports.dart';
import '../config/local_storage_services.dart';
import '../constants/urls.dart';

class BaseHttpClient {
  final localStorage = Get.find<LocalStorageService>();
  final _client = Dio();

  static String get baseURL {
    return ApiCredential.baseUrl;
  }

  Dio get client {
    _client.options.baseUrl = baseURL;
    _client.options.headers = {
      'Accept': 'application/json',
    };
    return _client;
  }

  Dio get authenticatedClient {
    final httpClient = client;
    String? token = localStorage.getStringValue(StringData.accessTokenKey);
    if(token == null){
      return httpClient;
    }else{
      httpClient.options.headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };
      return httpClient;
    }
  }
}
