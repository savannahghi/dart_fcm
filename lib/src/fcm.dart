library dart_fcm;

import 'package:dart_fcm/src/helpers.dart';
import 'package:dart_fcm/src/reminder_notification.dart';
import 'package:dart_fcm/src/setup_on_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class SILFCM {
  factory SILFCM(
      {FirebaseMessaging? firebaseMessagingObj,
      FlutterLocalNotificationsPlugin? localNotifications}) {
    firebaseMessaging = firebaseMessagingObj ?? FirebaseMessaging.instance;
    localNotificationsPlugin =
        localNotifications ?? FlutterLocalNotificationsPlugin();
    return _singleton;
  }

  SILFCM._internal();

  static final SILFCM _singleton = SILFCM._internal();

  static late FirebaseMessaging firebaseMessaging;

  late OnMessageCallback? navigationCallback;

  /// create an instance of [FlutterLocalNotificationsPlugin]
  static late FlutterLocalNotificationsPlugin localNotificationsPlugin;

  AndroidNotificationChannel? androidChannel;

  final BehaviorSubject<ReminderNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReminderNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  /// [configure] is responsible for correctly setting up local notifications ( and asking for permission if needed)
  /// and wiring-up firebase messaging [onMessage] callback to show fcm messages
  Future<SILFCM> configure({
    required BuildContext context,
    OnMessageCallback? callback,
  }) async {
    navigationCallback = callback;
    final TargetPlatform platform = Theme.of(context).platform;
    await this.initializeLocalNotifications();
    if (platform == TargetPlatform.iOS) {
      await requestIOSLocalNotificationsPermissions(
          localNotificationsPlugin: localNotificationsPlugin);
      final NotificationSettings settings =
          await this.requestIOSFCMMessagingPermission();
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        // call callback
      }
    }

    // create high importance channel for android
    if (platform == TargetPlatform.android) {
      androidChannel = await createAndroidHighImportanceChannel(
          localNotificationsPlugin: localNotificationsPlugin);
    }

    // setup device token
    await this.getDeviceToken();

    // enabling foreground notifications so that they can be visible while the app is in the foreground
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    onMessageSetup(context: context, callback: callback);

    return Future<SILFCM>.value(this);
  }

  /// [listenOnDeviceTokenChanges] when initiate a callback once the device token changes
  Future<void> listenOnDeviceTokenChanges(dynamic graphQLClient) async {}

  Future<void> onMessageSetup<T extends FirebaseMessaging>({
    required BuildContext context,
    OnMessageCallback? callback,
  }) async {
    final TargetPlatform platform = Theme.of(context).platform;
    return setupOnMessage(
        platform, androidChannel, localNotificationsPlugin, callback);
  }

  /// [initializeLocalNotifications] bootstraps local notifications to the application
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings iOSSettings =
        this.initializeIOSInitializationSettings();

    final MacOSInitializationSettings macOSSettings =
        this.initializeMacOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidSettings, iOS: iOSSettings, macOS: macOSSettings);

    await initializeIOS(
        initializationSettings: initializationSettings,
        localNotificationsPlugin: localNotificationsPlugin,
        onSelect: this.onNotificationSelected);
  }

  Future<bool> onNotificationSelected(String? payload) async {
    if (payload == null) {
      debugPrint('notification payload: $payload');
      return false;
    }
    this.selectNotificationSubject.add(payload);
    this.navigationCallback?.call(
        NotificationPayloadBehaviorObject().notificationData.value,
        NotificationPayloadBehaviorObject().notificationTitle.value,
        NotificationPayloadBehaviorObject().notificationBody.value);
    return true;
  }

  IOSInitializationSettings initializeIOSInitializationSettings() {
    return IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        this.didReceiveLocalNotificationSubject.add(ReminderNotification(
            id: id, title: title, body: body, payload: payload));
      },
    );
  }

  MacOSInitializationSettings initializeMacOSInitializationSettings() {
    return const MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
  }

  /// [requestIOSFCMMessagingPermission] used to request messaging permissions for
  /// ios platform.
  Future<NotificationSettings> requestIOSFCMMessagingPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(provisional: true);
    return settings;
  }

  /// [requestMacOSFCMMessagingPermission] used to request messaging permissions for
  /// macOS platform.
  Future<NotificationSettings> requestMacOSFCMMessagingPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(provisional: true);
    return settings;
  }

  /// [getDeviceToken] fetches unique device token
  Future<String?> getDeviceToken() => firebaseMessaging.getToken();

  /// [resetToken] deletes a device token
  Future<void> resetToken() => firebaseMessaging.deleteToken();

  Stream<String> onDeviceTokenRefresh() => firebaseMessaging.onTokenRefresh;
}
