import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

/// [createAndroidHighImportanceChannel]
Future<AndroidNotificationChannel> createAndroidHighImportanceChannel(
    {required FlutterLocalNotificationsPlugin localNotificationsPlugin}) async {
  await localNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
  return androidChannel;
}

/// [initializeIOS] initialize local notifications for iOS in preparation of incoming messages
Future<void> initializeIOS(
    {required FlutterLocalNotificationsPlugin localNotificationsPlugin,
    required InitializationSettings initializationSettings,
    required Future<bool> Function(String?)? onSelect}) async {
  await localNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: onSelect,
  );
}

/// [requestIOSLocalNotificationsPermissions] request local notifications permissions for iOS
Future<bool?> requestIOSLocalNotificationsPermissions(
    {required FlutterLocalNotificationsPlugin localNotificationsPlugin}) async {
  return localNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

class NotificationPayloadBehaviorObject {
  factory NotificationPayloadBehaviorObject() {
    return _singleton;
  }

  NotificationPayloadBehaviorObject._internal();

  static final NotificationPayloadBehaviorObject _singleton =
      NotificationPayloadBehaviorObject._internal();

  BehaviorSubject<Map<String, dynamic>> notificationData =
      BehaviorSubject<Map<String, dynamic>>();

  BehaviorSubject<String> notificationTitle = BehaviorSubject<String>();
  BehaviorSubject<String> notificationBody = BehaviorSubject<String>();
}
