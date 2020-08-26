import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'model/message_item.dart';
import 'model/notification_data.dart';
import 'package:http/http.dart' as http;

void main() => runApp(PushSampleApp());

class PushSampleApp extends StatefulWidget {
  @override
  State createState() => _PushSampleAppState();
}

class _PushSampleAppState extends State<PushSampleApp> {
  var items = new List<ListItem>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        var notificationData = NotificationData.fromJson(message);
        print("onMessage: $message");
        //
        var newItem =
            new MessageItem(notificationData.title, notificationData.body);
        notifyNewItemInsert(newItem);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      print("token $token");
      sendTokenToServer(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Flutter Push Notification Sample';
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Received messages:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _createList(items)
                ])));
  }

  Widget _createList(List<ListItem> data) {
    return Expanded(
        child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    ));
  }

  void notifyNewItemInsert(ListItem newItem) {
    setState(() {
      items.insert(0, newItem);
    });
  }

  Future<void> sendTokenToServer(String token) async {
    var url = 'http://localhost:5000/send-token';
    var uuid = UniqueKey().toString();
    var response = await http
        .post(url, body: {'uuid': uuid, 'token': token, 'platform': 'android'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
