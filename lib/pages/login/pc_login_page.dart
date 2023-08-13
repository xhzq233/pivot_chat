import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pivot_chat/pages/login/pc_login_bloc.dart';

class LogingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pivot Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 账号输入框
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 16),
            // 密码输入框
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 24),
            // 登录按钮
            ElevatedButton(
              onPressed: () => context.go("/home"),
              child: Text("loging"),
            ),
          ],
        ),
      ),
    );
  }
}
