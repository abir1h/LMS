import 'package:flutter/material.dart';

import 'src/core/di/dependency_injection.dart';
import 'src/core/utility/app_label.dart';
import 'src/feature/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalServices();
  setup();
  await App.getCurrentLanguage();
  runApp(const Application());
}
