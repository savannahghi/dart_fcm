import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// [setupOnMessage] is responsible for setting up what happens when a message is received
/// Disclaimer : please note that this method is excluded from coverage since we have have not identified a way
/// to extend/implement firebase or use generic for it's static methods which function consumes
/// Anyone with an idea of how to do, please implement and teach us.
void setupOnMessage(
    TargetPlatform platform,
    AndroidNotificationChannel? androidChannel,
    FlutterLocalNotificationsPlugin localNotificationsPlugin) {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      /// handle [notifications].The payload contains a notification property, which will be used to present a visible notification to the user.
      final RemoteNotification? notification = message.notification;
      late NotificationDetails notificationDetails;

      /// setup android NotificationDetails
      if (platform == TargetPlatform.android && androidChannel != null  ) {
        final AndroidNotification? android = message.notification?.android;
        notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            androidChannel.description,
            icon: android?.smallIcon,
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

      // todo: setup linux NotificationDetails

      localNotificationsPlugin.show(notification.hashCode, notification?.title,
          notification?.body, notificationDetails);
    },
  );
}
