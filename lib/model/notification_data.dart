class NotificationData {
  final String title;
  final String body;

  NotificationData(this.title, this.body);

  NotificationData.fromJson(Map<String, dynamic> json)
      : title = json['notification']['title'],
        body = json['notification']['body'];
}
