import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification {
  BuildContext context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notification(this.context) {
    var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS =
      IOSInitializationSettings();
    
    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
    
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onSelectNotification: this._onSelectNotification);
  }

  Future showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.Max, priority: Priority.High);
    
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    
    await flutterLocalNotificationsPlugin.show(
      0, title, body,
      platformChannelSpecifics, payload: 'Default_sound');
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: this.context,
      builder: (_) => AlertDialog(
        title: const Text("Here is your payload"),
        content: Text("Payload: $payload"),
      )
    );
  }
}
