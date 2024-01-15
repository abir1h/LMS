import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lms/src/core/config/notification_client.dart';
import 'src/core/di/dependency_injection.dart';
import 'src/core/utility/app_label.dart';
import 'src/feature/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initLocalServices();
  setup();
  await App.getCurrentLanguage();

  ///Init notification
  NotificationClient.instance.preInit();
  runApp(const Application());
}
