import 'package:chat_ai/chat_m.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/service/api_service.dart';
import 'package:intl/intl.dart';

//chatScreen부분
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _messages = [];
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDEEFF), Color(0xffCFD5FF), Color(0xffc5c7ff)],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -26),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'AI에게 물어보세요',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                          prefixIcon: null, // 돋보기 모양의 아이콘을 제거
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: 45 * (3.14159265 / -260),
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          _sendMessage();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    String message = _textEditingController.text;
    if (message.isNotEmpty) {
      _textEditingController.clear();

      String getResponseTime() {
        DateTime now = DateTime.now();
        String formattedTime = DateFormat('HH:mm').format(now);
        return formattedTime;
      }

      String sentTime =
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';

      setState(() {
        _messages.add(ChatMessage(
          message: message,
          isUserMessage: true,
          sentTime: sentTime,
        ));
      });

      String response = await _apiService.getServerResponse(message);
      String serverSentTime = getResponseTime();

      setState(() {
        _messages.add(ChatMessage(
          message: response,
          isUserMessage: false,
          sentTime: serverSentTime,
        ));
      });
    }
  }
}

//custom 한 AppBar
class ChatBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.account_circle),
          SizedBox(width: 8),
          Text(
            'User Name',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFC6CDFE),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: Colors.black87,
          onPressed: () {
            // 즐겨찾기 버튼을 눌렀을 때 실행할 코드
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
