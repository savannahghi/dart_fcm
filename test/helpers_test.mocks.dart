// Mocks generated by Mockito 5.0.7 from annotations
// in sil_fcm/test/helpers_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart'
    as _i3;
import 'package:flutter_local_notifications/src/initialization_settings.dart'
    as _i5;
import 'package:flutter_local_notifications/src/notification_details.dart'
    as _i7;
import 'package:flutter_local_notifications/src/platform_flutter_local_notifications.dart'
    as _i12;
import 'package:flutter_local_notifications/src/platform_specifics/android/active_notification.dart'
    as _i17;
import 'package:flutter_local_notifications/src/platform_specifics/android/initialization_settings.dart'
    as _i13;
import 'package:flutter_local_notifications/src/platform_specifics/android/notification_channel.dart'
    as _i16;
import 'package:flutter_local_notifications/src/platform_specifics/android/notification_channel_group.dart'
    as _i15;
import 'package:flutter_local_notifications/src/platform_specifics/android/notification_details.dart'
    as _i14;
import 'package:flutter_local_notifications/src/platform_specifics/ios/enums.dart'
    as _i9;
import 'package:flutter_local_notifications/src/platform_specifics/ios/initialization_settings.dart'
    as _i18;
import 'package:flutter_local_notifications/src/platform_specifics/ios/notification_details.dart'
    as _i19;
import 'package:flutter_local_notifications/src/typedefs.dart' as _i6;
import 'package:flutter_local_notifications/src/types.dart' as _i10;
import 'package:flutter_local_notifications_platform_interface/src/notification_app_launch_details.dart'
    as _i2;
import 'package:flutter_local_notifications_platform_interface/src/types.dart'
    as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:timezone/src/date_time.dart' as _i8;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeNotificationAppLaunchDetails extends _i1.Fake
    implements _i2.NotificationAppLaunchDetails {}

/// A class which mocks [FlutterLocalNotificationsPlugin].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterLocalNotificationsPlugin extends _i1.Mock
    implements _i3.FlutterLocalNotificationsPlugin {
  MockFlutterLocalNotificationsPlugin() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool?> initialize(
          _i5.InitializationSettings? initializationSettings,
          {_i6.SelectNotificationCallback? onSelectNotification}) =>
      (super.noSuchMethod(
          Invocation.method(#initialize, [initializationSettings],
              {#onSelectNotification: onSelectNotification}),
          returnValue: Future<bool?>.value(false)) as _i4.Future<bool?>);
  @override
  _i4.Future<_i2.NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() => (super.noSuchMethod(
              Invocation.method(#getNotificationAppLaunchDetails, []),
              returnValue: Future<_i2.NotificationAppLaunchDetails?>.value(
                  _FakeNotificationAppLaunchDetails()))
          as _i4.Future<_i2.NotificationAppLaunchDetails?>);
  @override
  _i4.Future<void> show(int? id, String? title, String? body,
          _i7.NotificationDetails? notificationDetails, {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(#show, [id, title, body, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> cancel(int? id, {String? tag}) =>
      (super.noSuchMethod(Invocation.method(#cancel, [id], {#tag: tag}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> cancelAll() =>
      (super.noSuchMethod(Invocation.method(#cancelAll, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> schedule(int? id, String? title, String? body,
          DateTime? scheduledDate, _i7.NotificationDetails? notificationDetails,
          {String? payload, bool? androidAllowWhileIdle = false}) =>
      (super.noSuchMethod(
          Invocation.method(#schedule, [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails
          ], {
            #payload: payload,
            #androidAllowWhileIdle: androidAllowWhileIdle
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> zonedSchedule(
          int? id,
          String? title,
          String? body,
          _i8.TZDateTime? scheduledDate,
          _i7.NotificationDetails? notificationDetails,
          {_i9.UILocalNotificationDateInterpretation?
              uiLocalNotificationDateInterpretation,
          bool? androidAllowWhileIdle,
          String? payload,
          _i10.DateTimeComponents? matchDateTimeComponents}) =>
      (super.noSuchMethod(
          Invocation.method(#zonedSchedule, [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails
          ], {
            #uiLocalNotificationDateInterpretation:
                uiLocalNotificationDateInterpretation,
            #androidAllowWhileIdle: androidAllowWhileIdle,
            #payload: payload,
            #matchDateTimeComponents: matchDateTimeComponents
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> periodicallyShow(
          int? id,
          String? title,
          String? body,
          _i11.RepeatInterval? repeatInterval,
          _i7.NotificationDetails? notificationDetails,
          {String? payload,
          bool? androidAllowWhileIdle = false}) =>
      (super.noSuchMethod(
          Invocation.method(#periodicallyShow, [
            id,
            title,
            body,
            repeatInterval,
            notificationDetails
          ], {
            #payload: payload,
            #androidAllowWhileIdle: androidAllowWhileIdle
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showDailyAtTime(
          int? id,
          String? title,
          String? body,
          _i10.Time? notificationTime,
          _i7.NotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showDailyAtTime,
              [id, title, body, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showWeeklyAtDayAndTime(
          int? id,
          String? title,
          String? body,
          _i10.Day? day,
          _i10.Time? notificationTime,
          _i7.NotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showWeeklyAtDayAndTime,
              [id, title, body, day, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<List<_i11.PendingNotificationRequest>>
      pendingNotificationRequests() => (super.noSuchMethod(
              Invocation.method(#pendingNotificationRequests, []),
              returnValue: Future<List<_i11.PendingNotificationRequest>>.value(
                  <_i11.PendingNotificationRequest>[]))
          as _i4.Future<List<_i11.PendingNotificationRequest>>);
}

/// A class which mocks [AndroidFlutterLocalNotificationsPlugin].
///
/// See the documentation for Mockito's code generation for more information.
class MockAndroidFlutterLocalNotificationsPlugin extends _i1.Mock
    implements _i12.AndroidFlutterLocalNotificationsPlugin {
  MockAndroidFlutterLocalNotificationsPlugin() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool?> initialize(
          _i13.AndroidInitializationSettings? initializationSettings,
          {_i6.SelectNotificationCallback? onSelectNotification}) =>
      (super.noSuchMethod(
          Invocation.method(#initialize, [initializationSettings],
              {#onSelectNotification: onSelectNotification}),
          returnValue: Future<bool?>.value(false)) as _i4.Future<bool?>);
  @override
  _i4.Future<void> schedule(
          int? id,
          String? title,
          String? body,
          DateTime? scheduledDate,
          _i14.AndroidNotificationDetails? notificationDetails,
          {String? payload,
          bool? androidAllowWhileIdle = false}) =>
      (super.noSuchMethod(
          Invocation.method(#schedule, [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails
          ], {
            #payload: payload,
            #androidAllowWhileIdle: androidAllowWhileIdle
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> zonedSchedule(
          int? id,
          String? title,
          String? body,
          _i8.TZDateTime? scheduledDate,
          _i14.AndroidNotificationDetails? notificationDetails,
          {bool? androidAllowWhileIdle,
          String? payload,
          _i10.DateTimeComponents? matchDateTimeComponents}) =>
      (super.noSuchMethod(
          Invocation.method(#zonedSchedule, [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails
          ], {
            #androidAllowWhileIdle: androidAllowWhileIdle,
            #payload: payload,
            #matchDateTimeComponents: matchDateTimeComponents
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showDailyAtTime(
          int? id,
          String? title,
          String? body,
          _i10.Time? notificationTime,
          _i14.AndroidNotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showDailyAtTime,
              [id, title, body, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showWeeklyAtDayAndTime(
          int? id,
          String? title,
          String? body,
          _i10.Day? day,
          _i10.Time? notificationTime,
          _i14.AndroidNotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showWeeklyAtDayAndTime,
              [id, title, body, day, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> show(int? id, String? title, String? body,
          {_i14.AndroidNotificationDetails? notificationDetails,
          String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(#show, [id, title, body],
              {#notificationDetails: notificationDetails, #payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> periodicallyShow(int? id, String? title, String? body,
          _i11.RepeatInterval? repeatInterval,
          {_i14.AndroidNotificationDetails? notificationDetails,
          String? payload,
          bool? androidAllowWhileIdle = false}) =>
      (super.noSuchMethod(
          Invocation.method(#periodicallyShow, [
            id,
            title,
            body,
            repeatInterval
          ], {
            #notificationDetails: notificationDetails,
            #payload: payload,
            #androidAllowWhileIdle: androidAllowWhileIdle
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> cancel(int? id, {String? tag}) =>
      (super.noSuchMethod(Invocation.method(#cancel, [id], {#tag: tag}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> createNotificationChannelGroup(
          _i15.AndroidNotificationChannelGroup? notificationChannelGroup) =>
      (super.noSuchMethod(
          Invocation.method(
              #createNotificationChannelGroup, [notificationChannelGroup]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteNotificationChannelGroup(String? groupId) =>
      (super.noSuchMethod(
          Invocation.method(#deleteNotificationChannelGroup, [groupId]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> createNotificationChannel(
          _i16.AndroidNotificationChannel? notificationChannel) =>
      (super.noSuchMethod(
          Invocation.method(#createNotificationChannel, [notificationChannel]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteNotificationChannel(String? channelId) => (super
      .noSuchMethod(Invocation.method(#deleteNotificationChannel, [channelId]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<List<_i17.ActiveNotification>?> getActiveNotifications() =>
      (super.noSuchMethod(Invocation.method(#getActiveNotifications, []),
              returnValue: Future<List<_i17.ActiveNotification>?>.value(
                  <_i17.ActiveNotification>[]))
          as _i4.Future<List<_i17.ActiveNotification>?>);
  @override
  _i4.Future<List<_i16.AndroidNotificationChannel>?>
      getNotificationChannels() => (super.noSuchMethod(
              Invocation.method(#getNotificationChannels, []),
              returnValue: Future<List<_i16.AndroidNotificationChannel>?>.value(
                  <_i16.AndroidNotificationChannel>[]))
          as _i4.Future<List<_i16.AndroidNotificationChannel>?>);
  @override
  _i4.Future<void> cancelAll() =>
      (super.noSuchMethod(Invocation.method(#cancelAll, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() => (super.noSuchMethod(
              Invocation.method(#getNotificationAppLaunchDetails, []),
              returnValue: Future<_i2.NotificationAppLaunchDetails?>.value(
                  _FakeNotificationAppLaunchDetails()))
          as _i4.Future<_i2.NotificationAppLaunchDetails?>);
  @override
  _i4.Future<List<_i11.PendingNotificationRequest>>
      pendingNotificationRequests() => (super.noSuchMethod(
              Invocation.method(#pendingNotificationRequests, []),
              returnValue: Future<List<_i11.PendingNotificationRequest>>.value(
                  <_i11.PendingNotificationRequest>[]))
          as _i4.Future<List<_i11.PendingNotificationRequest>>);
}

/// A class which mocks [IOSFlutterLocalNotificationsPlugin].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOSFlutterLocalNotificationsPlugin extends _i1.Mock
    implements _i12.IOSFlutterLocalNotificationsPlugin {
  MockIOSFlutterLocalNotificationsPlugin() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool?> initialize(
          _i18.IOSInitializationSettings? initializationSettings,
          {_i6.SelectNotificationCallback? onSelectNotification}) =>
      (super.noSuchMethod(
          Invocation.method(#initialize, [initializationSettings],
              {#onSelectNotification: onSelectNotification}),
          returnValue: Future<bool?>.value(false)) as _i4.Future<bool?>);
  @override
  _i4.Future<bool?> requestPermissions(
          {bool? sound = false, bool? alert = false, bool? badge = false}) =>
      (super.noSuchMethod(
          Invocation.method(#requestPermissions, [],
              {#sound: sound, #alert: alert, #badge: badge}),
          returnValue: Future<bool?>.value(false)) as _i4.Future<bool?>);
  @override
  _i4.Future<void> schedule(
          int? id,
          String? title,
          String? body,
          DateTime? scheduledDate,
          _i19.IOSNotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #schedule,
              [id, title, body, scheduledDate, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> zonedSchedule(
          int? id,
          String? title,
          String? body,
          _i8.TZDateTime? scheduledDate,
          _i19.IOSNotificationDetails? notificationDetails,
          {_i9.UILocalNotificationDateInterpretation?
              uiLocalNotificationDateInterpretation,
          String? payload,
          _i10.DateTimeComponents? matchDateTimeComponents}) =>
      (super.noSuchMethod(
          Invocation.method(#zonedSchedule, [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails
          ], {
            #uiLocalNotificationDateInterpretation:
                uiLocalNotificationDateInterpretation,
            #payload: payload,
            #matchDateTimeComponents: matchDateTimeComponents
          }),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showDailyAtTime(
          int? id,
          String? title,
          String? body,
          _i10.Time? notificationTime,
          _i19.IOSNotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showDailyAtTime,
              [id, title, body, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> showWeeklyAtDayAndTime(
          int? id,
          String? title,
          String? body,
          _i10.Day? day,
          _i10.Time? notificationTime,
          _i19.IOSNotificationDetails? notificationDetails,
          {String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #showWeeklyAtDayAndTime,
              [id, title, body, day, notificationTime, notificationDetails],
              {#payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> show(int? id, String? title, String? body,
          {_i19.IOSNotificationDetails? notificationDetails,
          String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(#show, [id, title, body],
              {#notificationDetails: notificationDetails, #payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> periodicallyShow(int? id, String? title, String? body,
          _i11.RepeatInterval? repeatInterval,
          {_i19.IOSNotificationDetails? notificationDetails,
          String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(
              #periodicallyShow,
              [id, title, body, repeatInterval],
              {#notificationDetails: notificationDetails, #payload: payload}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> cancel(int? id) =>
      (super.noSuchMethod(Invocation.method(#cancel, [id]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> cancelAll() =>
      (super.noSuchMethod(Invocation.method(#cancelAll, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() => (super.noSuchMethod(
              Invocation.method(#getNotificationAppLaunchDetails, []),
              returnValue: Future<_i2.NotificationAppLaunchDetails?>.value(
                  _FakeNotificationAppLaunchDetails()))
          as _i4.Future<_i2.NotificationAppLaunchDetails?>);
  @override
  _i4.Future<List<_i11.PendingNotificationRequest>>
      pendingNotificationRequests() => (super.noSuchMethod(
              Invocation.method(#pendingNotificationRequests, []),
              returnValue: Future<List<_i11.PendingNotificationRequest>>.value(
                  <_i11.PendingNotificationRequest>[]))
          as _i4.Future<List<_i11.PendingNotificationRequest>>);
}