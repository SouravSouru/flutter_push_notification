import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/service/push_notification_service.dart';
import 'package:flutter_push_notification/firebase_options.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Get.putAsync<PushNotificationService>(
    () async => PushNotificationService(),
  );

  PushNotificationService.initialize();
  PushNotificationService.flutterNotificationInitialize();
  runApp(
    GetMaterialApp(
      title: "push_notification",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
