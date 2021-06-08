import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sil_fcm/src/helpers.dart';

import 'helpers_test.mocks.dart';

@GenerateMocks(<Type>[
  FlutterLocalNotificationsPlugin,
  AndroidFlutterLocalNotificationsPlugin,
  IOSFlutterLocalNotificationsPlugin
])
void main() {
  test('should create android channel', () async {
    final MockFlutterLocalNotificationsPlugin plugin =
        MockFlutterLocalNotificationsPlugin();

    final MockAndroidFlutterLocalNotificationsPlugin androidPlugin =
        MockAndroidFlutterLocalNotificationsPlugin();

    when(plugin.resolvePlatformSpecificImplementation())
        .thenReturn(androidPlugin);

    when(androidPlugin.createNotificationChannel(androidChannel))
        .thenAnswer((Invocation realInvocation) => Future<void>.value());

    final AndroidNotificationChannel channel =
        await createAndroidHighImportanceChannel(
            localNotificationsPlugin: plugin);

    expect(channel, isNotNull);
  });

  test('should request permission of iOS', () async {
    final MockFlutterLocalNotificationsPlugin plugin =
        MockFlutterLocalNotificationsPlugin();

    final MockIOSFlutterLocalNotificationsPlugin iosPlugin =
        MockIOSFlutterLocalNotificationsPlugin();

    when(plugin.resolvePlatformSpecificImplementation()).thenReturn(iosPlugin);

    when(iosPlugin.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    )).thenAnswer((Invocation realInvocation) => Future<bool>.value(true));

    final bool? res = await requestIOSLocalNotificationsPermissions(
        localNotificationsPlugin: plugin);

    expect(res, isNotNull);
    expect(res, true);
  });
}
