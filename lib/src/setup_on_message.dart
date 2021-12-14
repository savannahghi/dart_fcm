import 'package:dart_fcm/src/helpers.dart';
import 'package:debug_logger/debug_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef OnMessageCallback = void Function(
    Map<String, dynamic>? data, String? title, String? body);

/// [setupOnMessage] is responsible for setting up what happens when a message is received
/// Disclaimer : please note that this method is excluded from coverage since we have have not identified a way
/// to extend/implement firebase or use generic for it's static methods which function consumes
/// Anyone with an idea of how to do, please implement and teach us.
void setupOnMessage(
  TargetPlatform platform,
  AndroidNotificationChannel? androidChannel,
  FlutterLocalNotificationsPlugin localNotificationsPlugin,
  OnMessageCallback? callback,
) {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      /// handle [notifications].The payload contains a notification property, which will be used to present a visible notification to the user.
      final RemoteNotification notification = message.notification!;
      late NotificationDetails notificationDetails;
      final NotificationPayloadBehaviorObject
          notificationPayloadBehaviorObject =
          NotificationPayloadBehaviorObject();

      /// setup android NotificationDetails
      if (platform == TargetPlatform.android && androidChannel != null) {
        final AndroidNotification? android = message.notification?.android;
        notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            androidChannel.description,
            icon: android?.smallIcon,
            importance: Importance.max,
            priority: Priority.high,
            showProgress: true,
          ),
        );
      }

      /// setup ios NotificationDetails
      if (platform == TargetPlatform.iOS) {
        notificationDetails = const NotificationDetails();
      }

      // setup macos NotificationDetails
      if (platform == TargetPlatform.macOS) {
        notificationDetails = const NotificationDetails();
      }

      // save the notification payload
      notificationPayloadBehaviorObject.notificationBody
          .add(notification.body!);
      notificationPayloadBehaviorObject.notificationTitle
          .add(notification.title!);
      notificationPayloadBehaviorObject.notificationData.add(message.data);

      localNotificationsPlugin.show(notification.hashCode, notification.title,
          notification.body, notificationDetails,
          payload: notification.title);
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      // ignore: unused_local_variable
      late NotificationDetails notificationDetails;

      callback!(message.data, message.notification!.title,
          message.notification!.body);

      /// setup android NotificationDetails
      if (platform == TargetPlatform.android && androidChannel != null) {
        final AndroidNotification? android = message.notification?.android;
        notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            androidChannel.description,
            icon: android?.smallIcon,
            importance: Importance.max,
            priority: Priority.high,
            showProgress: true,
          ),
        );
      }

      /// setup ios NotificationDetails
      if (platform == TargetPlatform.iOS) {
        notificationDetails = const NotificationDetails();
      }

      // setup macos NotificationDetails
      if (platform == TargetPlatform.macOS) {
        notificationDetails = const NotificationDetails();
      }
    },
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  DebugLogger.debug('Should be handling a background message');
}
