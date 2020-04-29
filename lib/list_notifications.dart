import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';


class Notification {

  String title;
  String body;
  bool isActive = true;
  bool isChecked = false;

  Notification({this.title, this.body, this.isActive, this.isChecked});
}



class NotificationsListWidget extends StatefulWidget {
  NotificationsListWidget({Key key}) : super(key: key);

  @override
  _NotificationsListWidgetState createState() => _NotificationsListWidgetState();
}

class _NotificationsListWidgetState extends State<NotificationsListWidget> {
  List notifications = <List<Notification>>[];

  List<Notification> _generateRandomNotifications(int total) {
    List notifications = new List<Notification>.generate(
      total, (i) {
        var n = Notification(
          title: randomString(10),
          body: randomString(20),
          isChecked: false,
          isActive: true
        );

        return n;
      }
    );

    return notifications;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      List randomNotifications = this._generateRandomNotifications(10);
      this.notifications = randomNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My notifications')
      ),
      body: Container(
        child: ListView.builder(
          itemCount: this.notifications.length,
          itemBuilder: (context, index) {
            final item = this.notifications[index];
            final key = '${item.title}';
            return Dismissible(
              key: Key(key),
              onDismissed: (direction) {
                setState(() {
                  this.notifications.removeAt(index);
                  this.notifications.remove(item);
                });

                Scaffold.of(context)
                    .showSnackBar(SnackBar(
                      content: Text("Notificação removida", style: TextStyle(fontSize: 15),),
                      backgroundColor: Colors.blueAccent,
                    ));
              },
              background: DismissBackground(),
              child: NotificationCardWidget(notification: item),
            );
          },
        ),
      ),
    );
  }
}


class NotificationCardWidget extends StatefulWidget {
  final Notification notification;

  NotificationCardWidget({Key key, this.notification}) : super(key: key);

  @override
  _NotificationCardWidgetState createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(widget.notification.title),
        subtitle: Text(widget.notification.body),
        onTap: () {
        },
      ),
    );
  }
}

class DismissBackground extends StatelessWidget {
  const DismissBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Text(
        'Removendo notificação',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      )),
      color: Colors.redAccent,
    );
  }
}