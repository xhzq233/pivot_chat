import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../home/pc_home_page_model.dart';
import 'pc_chat_page_bloc.dart';
import 'pc_chat_page_model.dart';

class PCChatPage extends StatefulWidget {
  final Contact contact;

  PCChatPage({required this.contact});

  @override
  _PCChatPageState createState() => _PCChatPageState();
}

class _PCChatPageState extends State<PCChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ChatBloc _bloc = ChatBloc();

  @override
  void initState() {
    super.initState();
    _bloc.loadMessages(widget.contact.name);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void _addMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _bloc.addMessage(text, widget.contact.name);
        _controller.clear();
      });
    }
  }

  void _deleteMessage(int index) {
    setState(() {
      _bloc.deleteMessage(index, widget.contact.name);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('删除消息'),
          content: const Text('你确认要删除这条消息吗?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(index);
                Navigator.pop(context);
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact.name,
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<ChatMessage>>(
            stream: _bloc.messages,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return GestureDetector(
                      onLongPress: () => _showDeleteDialog(index),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Bubble(
                            margin: const BubbleEdges.all(10.0),
                            color: Colors.grey[400],
                            nip: BubbleNip.rightCenter,
                            alignment: Alignment.centerRight,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width *
                                    0.7, // 设置文本的最大宽度
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Text(
                                  message.message,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 23,
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 150,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          hintText: '输入消息...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _addMessage(_controller.text);
                      },
                      label: const Text(
                        "发送",
                        style: TextStyle(
                          color: Color(0xff393a3f),
                        ),
                      ),
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xff393a3f),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
