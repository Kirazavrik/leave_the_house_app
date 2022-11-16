import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterNativeTimezone.getLocalTimezone(),
      ),
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void selectNotification(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      color: const Color(0xff2196f3),
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  tz.TZDateTime _selectDate(TimeOfDay timeOfDay) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, timeOfDay.hour, timeOfDay.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showScheduledLocalNotification(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required TimeOfDay timeOfDay}) async {
    DateTime timeFuture = DateTime(2022, DateTime.november, 15, 20, 22);
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.zonedSchedule(
        id,
        title,
        body,
        _selectDate(timeOfDay),
        platformChannelSpecifics,
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }
}
