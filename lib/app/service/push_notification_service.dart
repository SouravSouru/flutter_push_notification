import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService extends GetxService {
  static late FirebaseMessaging _firebaseMessaging;
  static late String? _fcmToken;
  static FlutterLocalNotificationsPlugin flutterNotification =
      FlutterLocalNotificationsPlugin();

  static bool notificationsEnabled = false;

  static Future initialize() async {
    _firebaseMessaging = FirebaseMessaging.instance;
    await _requestPushNotificationPermissionRequest();
    _fcmToken = await _firebaseMessaging.getToken();

    // Listen to background notification
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessaging);
    // _firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isIOS || Platform.isAndroid) {
        // String topic = from.substring("/topics/".length());x
        // Handle the message based on the topic
        if (message.notification?.title != null ||
            message.notification?.body != null) {
          showCustomNotification(message);
        }
      }
    });

    //  Topic subscription
    // setupMessaging();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  static Future flutterNotificationInitialize() async {
    // Initialize native android notification
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    var iOSinitilize = const DarwinInitializationSettings(
        defaultPresentAlert: true, defaultPresentSound: true);

    var initilizationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSinitilize);

    // permission Request
    await _localNotificationPermissionsRequest();

    flutterNotification.initialize(initilizationsSettings);
  }

  static Future<void> _localNotificationPermissionsRequest() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterNotification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterNotification
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterNotification.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted =
          await androidImplementation?.requestNotificationsPermission();
      notificationsEnabled = granted ?? false;
    }
  }

  static Future _firebaseBackgroundMessaging(RemoteMessage message) async {
    if (message.notification != null) {
      print(message.notification?.title);
    }

    await Get.putAsync<PushNotificationService>(
      () async => PushNotificationService(),
    );

    showCustomNotification(message);
  }

  static Future<NotificationSettings>
      _requestPushNotificationPermissionRequest() async {
    return await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future showCustomNotification(RemoteMessage message) async {
    var androidDetails = const AndroidNotificationDetails(
      "channelID",
      "channelName",
      importance: Importance.max,
    );
    var iSODetails = const DarwinNotificationDetails();
    String payload = '';
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);
    // if (message.from!.contains(PushNotificationService.allUser)) {
    //   payload = PushNotificationService.allUser;
    // } else if (message.from!.contains(PushNotificationService.regUser)) {
    //   payload = PushNotificationService.regUser;
    // } else if (message.from!.contains(PushNotificationService.guestUser)) {
    //   payload = PushNotificationService.guestUser;
    // }

    await flutterNotification.show(
      0,
      message.notification?.title,
      message.notification?.body,
      generalNotificationDetails,
      payload: payload,
    );

    // Topic subscription

    //    static void setupMessaging() {
    //   final cacheBox = Hive.box('cacheBox');
    //   if (cacheBox.isNotEmpty) {
    //     firebaseMessaging.subscribeToTopic(allUser);
    //     if (cacheBox.get("userStatus") == guestUser) {
    //       firebaseMessaging.subscribeToTopic(guestUser);
    //       firebaseMessaging.unsubscribeFromTopic(regUser);`
    //     } else if (cacheBox.get("userStatus") == regUser) {
    //       firebaseMessaging.subscribeToTopic(regUser);
    //       firebaseMessaging.unsubscribeFromTopic(guestUser);
    //     }
    //   } else {
    //     firebaseMessaging.unsubscribeFromTopic(allUser);
    //     firebaseMessaging.unsubscribeFromTopic(guestUser);
    //     firebaseMessaging.unsubscribeFromTopic(regUser);
    //   }
    // }
  }
}
