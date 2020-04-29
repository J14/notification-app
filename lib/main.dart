import 'package:flutter/material.dart';

import 'package:notification_app/client_mqtt.dart';
import 'package:notification_app/list_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    runMqttServerClient(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MQTT notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationsListWidget(),
    );
  }
}