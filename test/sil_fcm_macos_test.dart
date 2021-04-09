import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:sil_fcm/sil_fcm.dart';

import 'mocks.dart';

void main() {
  group('iOS', () {
    setUp(() async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    });

    test('should call initializeMacOSInitializationSettings', () {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
      expect(fcm, isA<SILFCM>());
      final MacOSInitializationSettings settings =
          fcm.initializeMacOSInitializationSettings();
      expect(settings, isA<MacOSInitializationSettings>());
    });

    test('should request macOS permission', () async {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
      expect(fcm.requestMacOSFCMMessagingPermission(),
          isA<Future<NotificationSettings>>());

      final NotificationSettings perms =
          await fcm.requestMacOSFCMMessagingPermission();

      expect(perms.alert, AppleNotificationSetting.enabled);
      expect(perms.announcement, AppleNotificationSetting.enabled);
    });

    testWidgets('should onMessageSetup for macOS', (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);

      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            return MaterialApp(
              theme: ThemeData(
                platform: TargetPlatform.macOS,
              ),
              home: TextButton(
                  onPressed: () async => fcm.onMessageSetup(context: context),
                  child: const Text('configure on macos')),
            );
          },
        ),
      );

      // should find the textButton
      expect(find.byType(TextButton), findsOneWidget);

      // should successfully tap the textbutton
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(fcm.getDeviceToken(), isA<Future<String?>>());

      debugDefaultTargetPlatformOverride = null;
    });

    test('should initializeMacOSInitializationSettings', () {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();
      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);

      final MacOSInitializationSettings macOSSettings =
          fcm.initializeMacOSInitializationSettings();

      expect(macOSSettings, isA<MacOSInitializationSettings>());
    });

    test('should initializeMacOSInitializationSettings', () {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();
      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);

      final MacOSInitializationSettings macOSSettings =
          fcm.initializeMacOSInitializationSettings();

      expect(macOSSettings, isA<MacOSInitializationSettings>());
    });

    test('should call initializeMacOSInitializationSettings', () {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
      expect(fcm, isA<SILFCM>());
      final MacOSInitializationSettings settings =
          fcm.initializeMacOSInitializationSettings();
      expect(settings, isA<MacOSInitializationSettings>());
    });

    test('should request macOS permission', () async {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
      expect(fcm.requestMacOSFCMMessagingPermission(),
          isA<Future<NotificationSettings>>());

      final NotificationSettings perms =
          await fcm.requestMacOSFCMMessagingPermission();

      expect(perms.alert, AppleNotificationSetting.enabled);
      expect(perms.announcement, AppleNotificationSetting.enabled);
    });
  });
}
