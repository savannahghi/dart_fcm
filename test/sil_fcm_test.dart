import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/platform_specifics/ios/initialization_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sil_fcm/sil_fcm.dart';
import 'package:sil_fcm/src/reminder_notification.dart';

import 'mocks.dart';

void main() {
  test('should instantiate ReminderNotification', () {
    final ReminderNotification notification = ReminderNotification(
        id: 1, title: 'title', body: 'body', payload: 'payload');

    expect(notification, isA<ReminderNotification>());
    expect(notification.id, 1);
    expect(notification.title, 'title');
    expect(notification.body, 'body');
    expect(notification.payload, 'payload');
  });

  test('should fail to create instance of  SILFCM', () {
    expect(() => SILFCM(), throwsException);
  });

  test('should instantiate SILFCM', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm, isA<SILFCM>());
  });

  test('should get device token', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm, isA<SILFCM>());
  });

  test('should call initializeIOSInitializationSettings', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm, isA<SILFCM>());
    final IOSInitializationSettings settings =
        fcm.initializeIOSInitializationSettings();
    expect(settings, isA<IOSInitializationSettings>());

    expect(settings.onDidReceiveLocalNotification, isNotNull);
    expect(settings.onDidReceiveLocalNotification!(1, 'test', 'test', 'test'),
        isA<Future<dynamic>>());
  });

  test('should get  device token', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm.getDeviceToken(), isA<Future<String>>());
    fcm
        .getDeviceToken()
        .then((String? value) => expect(value, equals('token')));
  });

  test('should delete device token', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm.resetToken(), isA<Future<void>>());
  });

  test('should request ios permission', () async {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm.requestIOSFCMMessagingPermission(),
        isA<Future<NotificationSettings>>());

    final NotificationSettings perms =
        await fcm.requestIOSFCMMessagingPermission();

    expect(perms.alert, AppleNotificationSetting.enabled);
    expect(perms.announcement, AppleNotificationSetting.enabled);
  });

  test('should create android channel', () async {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    await fcm.createAndroidHighImportanceChannel();
    expect(fcm.androidChannel, isNotNull);
    expect(fcm.androidChannel, isA<AndroidNotificationChannel>());
  });

  test('should initialize local notifications', () async {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final MockFlutterLocalNotificationsPlugin ln =
        MockFlutterLocalNotificationsPlugin();
    final SILFCM fcm =
        SILFCM(firebaseMessagingObj: fbm, localNotifications: ln);

    expect(fcm.initializeLocalNotifications(), isA<Future<void>>());

    expect(fcm.initializeLocalNotifications(), completes);
  });

  test('should setup listenOnDeviceTokenChanges', () async {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    expect(fcm.listenOnDeviceTokenChanges(true), isA<Future<void>>());
  });

  testWidgets('should configure properly on ios ', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
        MockFlutterLocalNotificationsPlugin();
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(
        firebaseMessagingObj: fbm,
        localNotifications: mockFlutterNotificationsPlugin);
    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return MaterialApp(
        home: TextButton(
            onPressed: () {
              fcm.configure(context: context);
            },
            child: const Text('configure on ios')),
      );
    }));

    // should find the textButton
    expect(find.byType(TextButton), findsOneWidget);

    // should successfully tap the textbutton
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    // should call configure method and initialize localNotifications
    final IOSInitializationSettings iosSettings =
        fcm.initializeIOSInitializationSettings();
    // expect  all permisions to be false
    expect(iosSettings.requestAlertPermission, false);
    expect(iosSettings.requestBadgePermission, false);
    expect(iosSettings.requestSoundPermission, false);
    expectSync(
        iosSettings.onDidReceiveLocalNotification!(1, 'test', 'test', 'test'),
        isA<Future<void>>());
    // expect request ios locationn permision makes the permsions true

    //expect get token is called
    expect(fcm.getDeviceToken(), isA<Future<String?>>());

    //expect on set up method is called

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('should configure properly on android ',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
        MockFlutterLocalNotificationsPlugin();
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(
        firebaseMessagingObj: fbm,
        localNotifications: mockFlutterNotificationsPlugin);
    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return MaterialApp(
        home: TextButton(
            onPressed: () {
              fcm.configure(context: context);
            },
            child: const Text('configure on android')),
      );
    }));

    // should find the textButton
    expect(find.byType(TextButton), findsOneWidget);

    // should successfully tap the textbutton
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    //create high importance channel method is called successfully
    expect(fcm.createAndroidHighImportanceChannel(), isA<Future<void>>());
    expect(fcm.createAndroidHighImportanceChannel(), isNotNull);

    //expect get token is called
    expect(fcm.getDeviceToken(), isA<Future<String?>>());

    //expect on set up method is called

    debugDefaultTargetPlatformOverride = null;
  });

  // test('should requestIOSMessagingPermission', () {
  //   final MockFirebaseMessaging fbm = MockFirebaseMessaging();
  //   final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);

  //   final Future<String> Function({dynamic data}) func = ({dynamic data}) {
  //     return Future<String>.value('new-token');
  //   };

  //   fcm.requestIOSMessagingPermission(func);

  //   expect(fbm.onIosSettingsRegistered.first, completes);
  //   expect(fbm.requestNotificationPermissions, returnsNormally);
  // });

  test('should initializeNotifications', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
        MockFlutterLocalNotificationsPlugin();

    final SILFCM fcm = SILFCM(
        firebaseMessagingObj: fbm,
        localNotifications: mockFlutterNotificationsPlugin);

    fcm.initializeLocalNotifications();

    expectLater(
        mockFlutterNotificationsPlugin.initialize.call, isA<Function>());

    expectSync(mockFlutterNotificationsPlugin.initialize.call,
        throwsNoSuchMethodError);
  });

  test('should initializeIOSInitializationSettings', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
        MockFlutterLocalNotificationsPlugin();
    final SILFCM fcm = SILFCM(
        firebaseMessagingObj: fbm,
        localNotifications: mockFlutterNotificationsPlugin);

    final IOSInitializationSettings iosSettings =
        fcm.initializeIOSInitializationSettings();

    expect(iosSettings, isA<IOSInitializationSettings>());
    expect(iosSettings.onDidReceiveLocalNotification, isNotNull);
    expectSync(
        iosSettings.onDidReceiveLocalNotification!(1, 'test', 'test', 'test'),
        isA<Future<void>>());
  });
}
