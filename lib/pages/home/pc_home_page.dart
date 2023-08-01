import 'package:flutter/material.dart';

import '../chat/pc_chat_page.dart';
import 'pc_home_page_model.dart';

class PCHomePage extends StatefulWidget {
  @override
  _PCHomePageState createState() => _PCHomePageState();
}

class _PCHomePageState extends State<PCHomePage> {
  @override
  Widget build(BuildContext context) {
    // 在这里定义聊天窗口页面的布局和逻辑
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        ),
      body: Center(
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PCChatPage(contact: contact),
                  ),
                );
              },
              child: SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.avatarUrl),
                      radius: 60,
                    ),
                    title: Text(contact.name),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
