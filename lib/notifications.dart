import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:school/days_of_the_week.dart';
import 'package:school/models/notification.dart';

class Notify extends StatefulWidget {
  Notify({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Noti> notifications = [];
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Noti(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: boxColor,
            ),
          );
        });
      },
      onLaunch: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Noti(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: boxColor,
            ),
          );
        });
      },
      onResume: (Map<String, dynamic> notification) async {
        setState(() {
          notifications.add(
            Noti(
              title: notification["notification"]["title"],
              body: notification["notification"]["body"],
              color: boxColor,
            ),
          );
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions();
    // _firebaseMessaging.getToken().then((token) {
    //   print(token);
    // }).catchError((e) {
    //   print(e);
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
          style: TextStyle(color: boxColor),),
      ),
      body: ListView(
        children: notifications.map(buildNoti).toList(),
      ),
    );
  }

  Widget buildNoti(Noti notification) {
    return ListTile(
      title: Text(
        notification.title,
        style: TextStyle(
          color: notification.color,
        ),
      ),
      subtitle: Text(notification.body),
    );
  }







}
