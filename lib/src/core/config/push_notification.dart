import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification{
  PushNotification._();
  static PushNotification? _instance;
  static PushNotification get instance => _instance ?? (_instance = PushNotification._());
  static const String androidChannelId = "clms";
  static const String androidChannelName = "CLMS";



  ///Notification plugin instance
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final StreamController<Map<String,dynamic>> _onAppLaunceFromNotificationStreamController = StreamController.broadcast();
  Stream<Map<String,dynamic>> get onAppLaunceFromNotificationStream => _onAppLaunceFromNotificationStreamController.stream;
  bool _initialized = false;


  ///Initialize notification instance
  Future<void> init()async{
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification).then((initialized){
    //   _initialized = initialized??false;
    //   if(_initialized){
    //     _requestNotificationPermissions();
    //     // _onAppLaunchedFromNotification();
    //   }
    // }).catchError((_){});
    // await _flutterLocalNotificationsPlugin.initialize(initializationSettings).then((initialized){
    //   _initialized = initialized??false;
    //   if(_initialized){
    //     _requestNotificationPermissions();
    //     // _onAppLaunchedFromNotification();
    //   }
    // }).catchError((_){});
    _requestNotificationPermissions();
  }

  void dispose(){
    _onAppLaunceFromNotificationStreamController.close();
  }

  ///Request android and ios notification permissions if required
  void _requestNotificationPermissions()async{
    ///Android specific permission
    if(Platform.isAndroid){
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled().catchError((_){});
    }

    ///IOS specific permission
    if(Platform.isIOS){
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      ).catchError((_){});
    }
  }
  // ///Check is app launched from notification
  // void _onAppLaunchedFromNotification(){
  //   ///Get app launches details
  //   _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((details){
  //     if(details != null
  //     && details.didNotificationLaunchApp && details.payload != null
  //     && details.payload!.isNotEmpty){
  //       _navigateToScreen(details.payload!);
  //     }
  //   }).catchError((_){});
  // }
  ///On notification clicked, if it has payload, navigate to screen
  void _onSelectNotification(String? payload) async {
    if(payload != null && payload.isNotEmpty){
      _navigateToScreen(payload);
    }
  }

  ///Unwrap the payload and navigate to specific screen
  void _navigateToScreen(String payload){
    if(!_onAppLaunceFromNotificationStreamController.isClosed){
      _onAppLaunceFromNotificationStreamController.sink.add(jsonDecode(payload));
    }
  }



  ///Show notification
  void sendNotification({required  String title,required  String body,required  Map<String, dynamic> payload})async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    await _notify(title,body,payload,android: androidPlatformChannelSpecifics);
  }

  ///Core stuff
  Future<void> _notify(String title, String body, Map<String, dynamic> payload, {AndroidNotificationDetails? android, DarwinNotificationDetails? ios})async{
    final NotificationDetails notificationDetails = NotificationDetails(android: android,iOS: ios,);
    await _flutterLocalNotificationsPlugin.show(
      Random().nextInt(99999999),
      title,
      body,
      notificationDetails,
      payload: "",
    ).catchError((_){});
  }
}