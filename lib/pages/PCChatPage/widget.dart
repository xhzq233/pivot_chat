import 'package:flutter/material.dart';

import '../PCHomePage/model.dart';

class PCChatPage extends StatefulWidget {
  final Contact contact;

  PCChatPage({required this.contact});
  @override
  State<PCChatPage> createState() => _PCChatPageState();
}

class _PCChatPageState extends State<PCChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contact.name)),
    );
  }
}
