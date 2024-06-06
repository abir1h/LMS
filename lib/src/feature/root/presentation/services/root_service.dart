import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../notification/data/data_sources/remote/notification_data_source.dart';
import '../../../notification/data/repositories/notification_repository_imp.dart';
import '../../../notification/domain/use_cases/notification_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {}

mixin RootService<T extends StatefulWidget> on State<T> implements _ViewModel {
  // late _ViewModel _view;

  final NotificationUseCase _notificationUseCase = NotificationUseCase(
      notificationRepository: NotificationRepositoryImp(
          notificationRemoteDataSource: NotificationRemoteDataSourceImp()));

  Future<ResponseEntity> updateFCMTokenData(String token) async {
    return _notificationUseCase.updateFCMTokenUseCase(token);
  }

  ///Update FCM Token
  void onFCMTokenUpdate(String? token) async {
    log("FCM Token: $token");
    if (token != null && token.isNotEmpty) {
      updateFCMTokenData(token).then((value) {
        if (value.error == null) {
          //success
          log("Successfully Updated FCM Token");
        } else {
          //error
        }
      });
    }
  }
}
