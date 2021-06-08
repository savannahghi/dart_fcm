import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/platform_specifics/ios/initialization_settings.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sil_fcm/sil_fcm.dart';

import 'mocks.dart';

void main() {
  group('iOS', () {
    setUp(() async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
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

    testWidgets('should configure properly on ios  ',
        (WidgetTester tester) async {
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
                platform: TargetPlatform.iOS,
              ),
              home: TextButton(
                  onPressed: () async => fcm.configure(context: context),
                  child: const Text('configure on ios')),
            );
          },
        ),
      );

      // should find the textButton
      expect(find.byType(TextButton), findsOneWidget);

      // should successfully tap the text button
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(fcm.getDeviceToken(), isA<Future<String?>>());

      debugDefaultTargetPlatformOverride = null;
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
  });
}
