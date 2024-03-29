import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  @override
  Future<String?> getToken({
    String? vapidKey,
  }) {
    return Future<String>.value('token');
  }

  @override
  Stream<String> get onTokenRefresh {
    return BehaviorSubject<String>.seeded('token').stream;
  }

  @override
  Future<void> setForegroundNotificationPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  }) async {}

  @override
  Future<void> deleteToken({String? senderId}) async {}

  @override
  Future<NotificationSettings> requestPermission(
          {bool alert = true,
          bool announcement = false,
          bool badge = true,
          bool carPlay = false,
          bool criticalAlert = false,
          bool provisional = false,
          bool sound = true}) async =>
      const NotificationSettings(
        alert: AppleNotificationSetting.enabled,
        announcement: AppleNotificationSetting.enabled,
        authorizationStatus: AuthorizationStatus.authorized,
        badge: AppleNotificationSetting.disabled,
        carPlay: AppleNotificationSetting.enabled,
        lockScreen: AppleNotificationSetting.enabled,
        notificationCenter: AppleNotificationSetting.enabled,
        showPreviews: AppleShowPreviewSetting.never,
        sound: AppleNotificationSetting.enabled,
      );
}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {
  @override
  Future<bool?> initialize(
    InitializationSettings initializationSettings, {
    SelectNotificationCallback? onSelectNotification,
  }) async =>
      true;
}

class MockMethodChannel extends Mock implements MethodChannel {}
