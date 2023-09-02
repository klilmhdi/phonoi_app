import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DownloadNotification {
  static Future init(FlutterLocalNotificationsPlugin plugin) async {
    var androidInit = const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettings = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(android: androidInit, iOS: initializationSettings);
    await plugin.initialize(initSettings);
  }

  Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin plugin}) async {
    AndroidNotificationDetails details = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentSound: false);
    var not = NotificationDetails(
      android: details,
      iOS: darwinNotificationDetails,
    );
    await plugin.show(0, title, body, not);
  }
}
