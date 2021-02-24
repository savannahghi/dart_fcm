import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sil_fcm/sil_fcm.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  @override
  Future<String> getToken() async {
    return Future<String>.value('token');
  }

  @override
  Future<bool> deleteInstanceID() async {
    return Future<bool>.value(true);
  }

  @override
  Stream<String> get onTokenRefresh {
    return Stream<String>.value('new-token');
  }

  @override
  Stream<IosNotificationSettings> get onIosSettingsRegistered {
    return Stream<IosNotificationSettings>.value(IosNotificationSettings());
  }

  @override
  FutureOr<bool> requestNotificationPermissions([
    IosNotificationSettings iosSettings = const IosNotificationSettings(),
  ]) {
    return Future<bool>.value(true);
  }
}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {
  @override
  Future<bool> initialize(InitializationSettings initializationSettings,
      {SelectNotificationCallback onSelectNotification}) async {
    await onSelectNotification('test');
    return true;
  }
}

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

  test('should instantiate SILFCM of correct type', () {
    final SILFCM fcm = SILFCM();
    expect(fcm, isA<SILFCM>());
    // fcm.getDeviceToken().then((String value) => expect(value, isA<String>()));
  });

  test('should get device token', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    fcm.getDeviceToken().then((String value) => expect(value, isA<String>()));
  });

  test('should get reset device token', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
    fcm.resetToken().then((bool value) => expect(value, isA<bool>()));
  });

  test('should refreshDeviceToken', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);

    final Future<String> Function({dynamic data}) func = ({dynamic data}) {
      return Future<String>.value('new-token');
    };

    fcm.refreshDeviceToken(func);

    expect(fbm.onTokenRefresh.first, completes);
  });

  test('should requestIOSMessagingPermission', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);

    final Future<String> Function({dynamic data}) func = ({dynamic data}) {
      return Future<String>.value('new-token');
    };

    fcm.requestIOSMessagingPermission(func);

    expect(fbm.onIosSettingsRegistered.first, completes);
    expect(fbm.requestNotificationPermissions, returnsNormally);
  });

  test('should initializeNotifications', () {
    final MockFirebaseMessaging fbm = MockFirebaseMessaging();
    final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
        MockFlutterLocalNotificationsPlugin();
    final SILFCM fcm = SILFCM(
        firebaseMessagingObj: fbm,
        localNotifications: mockFlutterNotificationsPlugin);

    fcm.initializeNotifications();

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
        iosSettings.onDidReceiveLocalNotification(1, 'test', 'test', 'test'),
        isA<Future<void>>());
  });
}
