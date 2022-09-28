import 'package:dart_fcm/dart_fcm.dart';
import 'package:dart_fcm/src/helpers.dart';
import 'package:dart_fcm/src/reminder_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {
  group('android', () {
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

    test('should listen to token refresh', () {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(firebaseMessagingObj: fbm);
      expect(fcm.onDeviceTokenRefresh(), isA<Stream<String>>());
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

    testWidgets('should configure properly on android ',
        (WidgetTester tester) async {
      //debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);
      void testFunction(
        Map<String, dynamic>? data,
        String? title,
        String? body,
      ) {}

      await tester.pumpWidget(Builder(builder: (BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            platform: TargetPlatform.android,
          ),
          home: TextButton(
              onPressed: () {
                fcm.configure(context: context, callback: testFunction);
              },
              child: const Text('configure on android')),
        );
      }));

      // should find the textButton
      expect(find.byType(TextButton), findsOneWidget);

      // should successfully tap the text button
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(fcm.androidChannel, isNotNull);

      //expect get token is called
      expect(fcm.getDeviceToken(), isA<Future<String?>>());
    });

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

    test('should onNotificationSelected and return false', () async {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();

      NotificationPayloadBehaviorObject()
          .notificationData
          .add(<String, dynamic>{'test': 'test'});
      NotificationPayloadBehaviorObject().notificationTitle.add('title');
      NotificationPayloadBehaviorObject().notificationBody.add('body');

      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);

      final bool v1 = await fcm.onNotificationSelected(null);
      expectLater(v1, equals(false));
      expect(fcm.selectNotificationSubject.valueOrNull, isNull);
    });

    test('should onNotificationSelected and return true', () async {
      final MockFirebaseMessaging fbm = MockFirebaseMessaging();
      final MockFlutterLocalNotificationsPlugin mockFlutterNotificationsPlugin =
          MockFlutterLocalNotificationsPlugin();

      NotificationPayloadBehaviorObject()
          .notificationData
          .add(<String, dynamic>{'test': 'test'});
      NotificationPayloadBehaviorObject().notificationTitle.add('title');
      NotificationPayloadBehaviorObject().notificationBody.add('body');

      final SILFCM fcm = SILFCM(
          firebaseMessagingObj: fbm,
          localNotifications: mockFlutterNotificationsPlugin);

      final bool v2 = await fcm.onNotificationSelected('payload');
      expectLater(v2, equals(true));
      expect(fcm.selectNotificationSubject.valueOrNull, isNotNull);
      expect(fcm.selectNotificationSubject.valueOrNull, equals('payload'));
    });
  });
}
