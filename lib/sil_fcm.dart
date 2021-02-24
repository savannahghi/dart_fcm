library sil_fcm;

import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

typedef FCMMessageHandler = Future<dynamic> Function({dynamic data});

typedef MessageCallback = Future<dynamic> Function(
    Map<String, dynamic> message);

/// [ReminderNotification] a model object for local notifications
class ReminderNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReminderNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class SILFCM {
  static final SILFCM _singleton = SILFCM._internal();

  factory SILFCM(
      {FirebaseMessaging firebaseMessagingObj,
      FlutterLocalNotificationsPlugin localNotifications}) {
    firebaseMessaging = firebaseMessagingObj ?? FirebaseMessaging();
    localNotificationsPlugin =
        localNotifications ?? FlutterLocalNotificationsPlugin();
    return _singleton;
  }

  SILFCM._internal();

  static FirebaseMessaging firebaseMessaging;

  /// create an instance of [FlutterLocalNotificationsPlugin]
  static FlutterLocalNotificationsPlugin localNotificationsPlugin;

  final BehaviorSubject<ReminderNotification>
      //ignore: close_sinks
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReminderNotification>();

  //ignore: close_sinks
  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  /// create FirebaseMessaging instance.
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  /// [configure] is responsible for correctly setting up local notifications ( and asking for permission if needed)
  /// and wiring-up firebase messaging [onMessage] callback to show fcm messages
  // ignore: always_declare_return_types
  get configure async {
    await this.initializeNotifications();
    if (Platform.isIOS) {
      this.requestIOSLocalNotificationsPermissions();
    }

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        // use local notifications here
        print('FCM message [onMessage]: $message');
        this._showNotification(message);
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        // use local notifications here
        print('FCM message [onLaunch]: $message');
        this._showNotification(message);
        return;
      },
      onResume: (Map<String, dynamic> message) {
        // use local notifications here
        print('FCM message [onResume]: $message');
        this._showNotification(message);
        return;
      },
    );
  }

  /// [getDeviceToken] fetches unique device token
  Future<String> getDeviceToken() => firebaseMessaging.getToken();

  Future<bool> resetToken() => firebaseMessaging.deleteInstanceID();

  /// [requestMessagingPermission] request platform aware messaging permissions
  void requestMessagingPermission(FCMMessageHandler onPermissions) {
    if (Platform.isIOS) {
      this.requestIOSMessagingPermission(onPermissions);
    }
  }

  /// [refreshDeviceToken] called to refresh the device.
  /// The callback should ideally receive the new token and save
  /// it to a remove server
  void refreshDeviceToken(FCMMessageHandler onRefresh) =>
      firebaseMessaging.onTokenRefresh.listen((String token) async {
        await onRefresh(data: token);
      });

  /// [setUpMessagingListener] sets up the configuration for when messages are received
  // setUpMessagingListener(
  //     {MessageCallback onMessage,
  //     MessageCallback onLaunch,
  //     MessageCallback onResume}) {
  //   this._firebaseMessaging.configure(
  //         onMessage: (message) async => await onMessage(message),
  //         onLaunch: (message) async => await onLaunch(message),
  //         onResume: (message) async => await onResume(message)   ,
  //       );
  // }

  /// [_requestIOSMessagingPermission] used to request messaging permissions for
  /// ios platform.
  /// [onSettingsDataCallback] is called after permissions are granted.
  /// The callback should ideally request for device token
  void requestIOSMessagingPermission(FCMMessageHandler onPermissions) {
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) async {
      await onPermissions();
    });

    firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true));
  }

  IOSInitializationSettings initializeIOSInitializationSettings() {
    return IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        this.didReceiveLocalNotificationSubject.add(ReminderNotification(
            id: id, title: title, body: body, payload: payload));
      },
    );
  }

  /// [initializeNotifications] bootstraps local notifications to the application
  Future<void> initializeNotifications() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');

    IOSInitializationSettings iOSSettings =
        this.initializeIOSInitializationSettings();

    InitializationSettings initializationSettings =
        InitializationSettings(androidSettings, iOSSettings);

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        this.selectNotificationSubject.add(payload);
      },
    );
  }

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

  Future<void> _showNotification(Map<String, dynamic> message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '0', message['notification']['title'], 'sil_fcm_message_channel',
            importance: Importance.Max,
            priority: Priority.High,
            autoCancel: true,
            ongoing: true,
            timeoutAfter: 300000);

    IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await localNotificationsPlugin.show(0, message['notification']['title'],
        message['notification']['body'], platformChannelSpecifics,
        payload: 'item x');
  }
}
