import 'package:flutter/material.dart';
import 'package:pivot_chat/widgets/button/_PCHomePageButton.dart';

class PCHomePage extends StatelessWidget {
  const PCHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text('Pivot chat'),
        actions: [
          IconButton(
            icon: Icon(ItyingFont.icon1,
              color: Colors.amber,
            ),
            onPressed: () {
              // 在这里处理搜索功能
            },
          ),
        ],
      ),
      body: ChatList(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: '联系人',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
        onTap: (index) {
          // 在这里处理底部导航栏的点击切换
        },
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在这里处理显示聊天内容的逻辑
    return ListView.builder(
      itemCount: 10, // 假设有10个聊天记录
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            // 聊天头像
            child: Text('A'),
          ),
          title: Text('用户A'), // 聊天用户名
          subtitle: Text('最近的一条消息'), // 最近的聊天消息
          trailing: Text('12:34'), // 最近消息的时间戳
          onTap: () {
            // 在这里处理点击聊天项的逻辑，打开聊天详情页等
          },
        );
      },
    );
  }
}