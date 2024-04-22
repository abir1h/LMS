import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import '../service/auth_cache_manager.dart';
import '../utility/log.dart';
import 'app_exceptions.dart';

/*class ApiService {
  final BaseHttpClient _baseClient = locator.get<BaseHttpClient>();


  Future<dynamic> getRequest(String url) async {
    appPrint('url ${ApiCredential.baseUrl + url}');
    try {
      final response = await _baseClient.authenticatedClient.get(url);
      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _returnResponse(e.response!);
      }
    } on SocketException {
      appPrint('No Internet');
      throw FetchDataException('No Internet connection');
    }
  }

  ///Todo must be modify later
  Future<dynamic> getRequestForAuth({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      var response = await _client.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization":
        "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  Future<dynamic> postRequest(String url, dynamic body) async {
    appPrint('url ${ApiCredential.baseUrl + url}');
    try {
      final response = await _baseClient.authenticatedClient.post(
        url,
        data: jsonEncode(body),
      );
      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _returnResponse(e.response!);
      }
    } on SocketException {
      appPrint('No Internet');
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(Response<dynamic> response) {
    appPrint("------------------------------");
    appPrint("Status Code ${response.statusCode}");
    appPrint("------------------------------");
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(response.data);
        return responseJson;
      case 201:
        var responseJson = jsonEncode(response.data);
        return responseJson;
      case 204:
        var responseJson = {'status_code': 204};
        return responseJson;
      case 400:
        var responseJson = jsonEncode(response.data);
        return responseJson;
      case 401:
        var responseJson = jsonEncode(response.data);
        return responseJson;
      case 403:
        throw UnauthorisedException(response.data);
      case 404:
        var responseJson = jsonEncode(response.data);
        return responseJson;
      case 422:
        throw ValidationException(response.data);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}*/

class Server {
  static final Server _s = Server._();
  late http.Client _client;
  static Server get instance => _s;
  Server._() {
    _client = http.Client();
  }

  final StreamController<String> _sessionExpireStreamController =
      StreamController.broadcast();
  Stream<String> get onUnauthorizedRequest =>
      _sessionExpireStreamController.stream;

  static String get host => ApiCredential
      .baseUrl; //TODO must check is HOST url active for production build

  Future<dynamic> postRequest({
    required String url,
    required dynamic postData,
  }) async {
    try {
      var body = json.encode(postData);
      // String token = await AuthCacheManager.getUserToken();///Todo Delete Later
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOm51bGwsInR5cGUiOiJzdXBlcmFkbWluIiwiaWF0IjoxNzEzNzY1OTcwLCJleHAiOjE3MTYzNTc5NzB9.ofkk_pPVNNwjKXxBb4g5B7f8_MT4PZOM9vN9yE0B3Do";
      var response = await _client.post(
        Uri.parse(host + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return '{"message": "Request failed! Check internet connection.", "error": "Error message"}';
    } on Exception catch (_) {
      return '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}';
    }
  }

  Future<dynamic> getRequest({required String url}) async {
    try {
      // String token = await AuthCacheManager.getUserToken();///Todo Delete Later
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOm51bGwsInR5cGUiOiJzdXBlcmFkbWluIiwiaWF0IjoxNzEzNzY1OTcwLCJleHAiOjE3MTYzNTc5NzB9.ofkk_pPVNNwjKXxBb4g5B7f8_MT4PZOM9vN9yE0B3Do";

      var response = await _client.get(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  ///Todo must be modify later
  Future<dynamic> getRequestForAuth({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      var response = await _client.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  Future<dynamic> deleteRequest({required String url}) async {
    try {
      // String token = await AuthCacheManager.getUserToken();///Todo Delete Later
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOm51bGwsInR5cGUiOiJzdXBlcmFkbWluIiwiaWF0IjoxNzEzNzY1OTcwLCJleHAiOjE3MTYzNTc5NzB9.ofkk_pPVNNwjKXxBb4g5B7f8_MT4PZOM9vN9yE0B3Do";

      var response = await _client.delete(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  void dispose() {
    _client.close();
    _sessionExpireStreamController.close();
  }

  dynamic _returnResponse(http.Response response) {
    appPrint("------------------------------");
    appPrint("Status Code ${response.statusCode}");
    appPrint("------------------------------");
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 204:
        return json.decode(response.body);
      case 400:
        return json.decode(response.body);
      case 401:
        return json.decode(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        return json.decode(response.body);
      case 422:
        return json.decode(response.body);
      case 500:
        return json.decode(response.body);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
