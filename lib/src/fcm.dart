library sil_fcm;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sil_fcm/src/reminder_notification.dart';

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

  /// create an instance of [FlutterLocalNotificationsPlugin]
  static late FlutterLocalNotificationsPlugin localNotificationsPlugin;

  late AndroidNotificationChannel androidChannel;

  final BehaviorSubject<ReminderNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReminderNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  /// [configure] is responsible for correctly setting up local notifications ( and asking for permission if needed)
  /// and wiring-up firebase messaging [onMessage] callback to show fcm messages
  Future<SILFCM> configure({required BuildContext context}) async {
    final TargetPlatform platform = Theme.of(context).platform;
    await this.initializeLocalNotifications();
    if (platform == TargetPlatform.iOS) {
      this.requestIOSLocalNotificationsPermissions();
      final NotificationSettings settings =
          await this.requestIOSFCMMessagingPermission();
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        // call callback
      }
    }

    // create high importance channel for android
    if (platform == TargetPlatform.android) {
      this.createAndroidHighImportanceChannel();
    }

    // setup device token
    // todo: save this intial device token to the backend
    await this.getDeviceToken();

    // todo : add mechanism to listen a register device tokens

    // enabling foreground notifications so that they can be visible while the app is in the foreground
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    onMessageSetup(context: context);

    return Future<SILFCM>.value(this);
  }

  /// [listenOnDeviceTokenChanges] when initiate a callback once the device token changes
  Future<void> listenOnDeviceTokenChanges(dynamic graphQLClient) async {}

  Future<void> onMessageSetup({required BuildContext context}) async {
    final TargetPlatform platform = Theme.of(context).platform;
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        /// handle [notifications].The payload contains a notification property, which will be used to present a visible notification to the user.
        final RemoteNotification? notification = message.notification;
        late NotificationDetails notificationDetails;

        /// setup android NotificationDetails
        if (platform == TargetPlatform.android) {
          final AndroidNotification? android = message.notification?.android;
          notificationDetails = NotificationDetails(
            android: AndroidNotificationDetails(
              this.androidChannel.id,
              this.androidChannel.name,
              this.androidChannel.description,
              icon: android?.smallIcon,
            ),
          );
        }

        /// setup ios NotificationDetails
        if (platform == TargetPlatform.iOS) {
          notificationDetails = const NotificationDetails();
        }

        // todo: setup macos NotificationDetails

        // todo: setup linux NotificationDetails

        localNotificationsPlugin.show(notification.hashCode,
            notification?.title, notification?.body, notificationDetails);
      },
    );
  }

  /// [initializeLocalNotifications] bootstraps local notifications to the application
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings iOSSettings =
        this.initializeIOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        this.selectNotificationSubject.add(payload!);
      },
    );
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

  /// [requestIOSFCMMessagingPermission] used to request messaging permissions for
  /// ios platform.
  Future<NotificationSettings> requestIOSFCMMessagingPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(provisional: true);
    return settings;
  }

  /// [getDeviceToken] fetches unique device token
  Future<String?> getDeviceToken() => firebaseMessaging.getToken();

  /// [resetToken] deletes a device token
  Future<void> resetToken() => firebaseMessaging.deleteToken();

  /// [requestIOSLocalNotificationsPermissions] request local notifications permissions for iOS
  void requestIOSLocalNotificationsPermissions() {
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// [createAndroidHighImportanceChannel]
  Future<void> createAndroidHighImportanceChannel() async {
    this.androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(this.androidChannel);
  }
}
