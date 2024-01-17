import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'push_notification.dart';

class NotificationClient {
  NotificationClient._();
  static NotificationClient? _instance;
  static NotificationClient get instance =>
      _instance ?? (_instance = NotificationClient._());
  void Function(NotificationEntity notification)? _onNotificationReceived;
  void Function(NotificationEntity notification)? _onNotificationClicked;

  static bool _isListening = false;
  final List<StreamSubscription> _subscriptions = [];
  RemoteMessage? _initialMessage;

  void preInit() async {
    _isListening = false;
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance
        .requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    )
        .then((value) {
      debugPrint(value.toString());
    }).catchError((_) {});

    ///Get is app launched from the first time via notification clicked
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      _initialMessage = value;
    }).catchError((_) {});
  }

  Future<String?> startListening(
      void Function(NotificationEntity notification) onNotificationClicked,
      void Function(NotificationEntity notification)
          onNotificationReceived) async {
    _isListening = true;
    _onNotificationClicked = onNotificationClicked;
    _onNotificationReceived = onNotificationReceived;

    ///Register background notification received
    FirebaseMessaging.onBackgroundMessage(_onBackgroundNotificationReceived);

    ///App opened from minimized via notification clicked
    _subscriptions.add(FirebaseMessaging.onMessageOpenedApp
        .listen(_onAppLaunchedFromNotification));

    ///App opened from minimized via notification clicked
    _subscriptions.add(
        FirebaseMessaging.onMessage.listen(_onForegroundNotificationReceived));

    ///Request permission
    _subscriptions.add(FirebaseMessaging.instance
        .requestPermission()
        .asStream()
        .listen(_onNotificationPermission));

    ///on local notification clicked
    _subscriptions.add(PushNotification
        .instance.onAppLaunceFromNotificationStream
        .listen(_onSelectNotification));

    if (_initialMessage != null) {
      _onAppLaunchedFromNotification(_initialMessage!);
      _initialMessage = null;
    }

    ///Get new token
    return FirebaseMessaging.instance.getToken();
  }

  ///Stop listening
  void stopListening() {
    _isListening = false;
    _onNotificationClicked = null;
    _onNotificationReceived = null;
    for (var element in _subscriptions) {
      element.cancel();
    }
    _subscriptions.clear();
  }

  /// App launched from minimized notification
  void _onAppLaunchedFromNotification(RemoteMessage message) {
    _onNotificationReceived?.call(NotificationEntity.fromJson(message.data));
    _onSelectNotification(message.data);
  }

  ///On permission fetched
  void _onNotificationPermission(NotificationSettings event) {
    debugPrint("====>Permission changed");
  }

  ///On notification received
  void _onForegroundNotificationReceived(RemoteMessage message) {
    _onNotificationReceived?.call(NotificationEntity.fromJson(message.data));
    PushNotification.instance.sendNotification(
      title: message.notification?.title ?? "HSEP-LMS",
      body: message.notification?.body ?? "",
      payload: message.data,
    );
  }

  ///App minimized notification received. Update badge if needed
  void onBackgroundNotificationReceived(RemoteMessage message) {
    _onNotificationReceived?.call(NotificationEntity.fromJson(message.data));
    debugPrint(
        "====>App minimized notification received. Update badge if needed");
  }

  ///Navigate to Actual page
  void _onSelectNotification(Map<String, dynamic> data) async {
    _onNotificationClicked?.call(NotificationEntity.fromJson(data));
  }
}

Future<void> _onBackgroundNotificationReceived(RemoteMessage message) async {
  debugPrint("====>Background notification received");
  if (NotificationClient._isListening) {
    NotificationClient.instance.onBackgroundNotificationReceived(message);
  }
}

NotificationEntity notificationEntityFromJson(String str) =>
    NotificationEntity.fromJson(json.decode(str));

String notificationEntityToJson(NotificationEntity data) =>
    json.encode(data.toJson());

class NotificationEntity {
  String id;
  String title;
  String details;
  String createdOn;
  String notificationType;
  String payload;
  String navigateTo;
  bool seen;
  NotificationEntity({
    required this.id,
    required this.title,
    required this.details,
    required this.createdOn,
    required this.notificationType,
    required this.payload,
    required this.navigateTo,
    required this.seen,
  });

  factory NotificationEntity.empty() => NotificationEntity(
        id: "",
        title: "",
        details: "",
        createdOn: "",
        notificationType: "",
        payload: "",
        navigateTo: "",
        seen: false,
      );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        id: json["Id"] ?? "",
        title: json["Title"] ?? "",
        details: json["Details"] ?? "",
        createdOn: json["CreatedOn"] ?? "",
        notificationType: json["NotificationType"]?.toString() ?? "",
        payload: json["Payload"] ?? "",
        navigateTo: json["NavigateTo"] ?? "",
        seen: json["Seen"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Details": details,
        "CreatedOn": createdOn,
        "NotificationType": notificationType,
        "Payload": payload,
        "NavigateTo": navigateTo,
        "Seen": seen,
      };

  static List<NotificationEntity> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, NotificationEntity>(
            json.map((x) => NotificationEntity.fromJson(x)).toList())
        : [];
  }
}
