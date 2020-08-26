import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildSubtitle(BuildContext context) => Text(sender);

  @override
  Widget buildTitle(BuildContext context) => Text(body);
}
