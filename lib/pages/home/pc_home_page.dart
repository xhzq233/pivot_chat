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
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.bHkgQ4WJ2zMc1aSED9ya_gHaHa?pid=ImgDet&rs=1',
              ),
              radius: 18,
            ),
            SizedBox(width: 8),
            // Adjust the width of the SizedBox for the desired spacing
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'ID: 1234',
                style: TextStyle(fontSize: 12, color: Colors.purple[80]),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Add your logic to handle creating a group chat
              print('Creating group chat');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  '创建群聊',
                  style: TextStyle(fontSize: 16, color: Colors.purple[80]),
                ),
              ),
            ),
          ),
        ],
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.avatarUrl),
                      radius: 30,
                    ),
                    title: Text("${contact.name}" + "${index+1}"),
                    subtitle: Text("这是啥"),
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
