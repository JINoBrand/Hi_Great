import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/bottom_navigation.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, String> character;
  const ChatScreen({Key? key, required this.character}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'content': text});
      // AI 응답은 임시로 고정 메시지
      _messages.add({
        'role': 'ai',
        'content': '${widget.character['name']} 스타일의 답변입니다.',
      });
      _controller.clear();
    });
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF2F2F53), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              widget.character['name']!,
              style: TextStyle(color: Color(0xFF2F2F53), fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              '채팅 중',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Color(0xFF2F2F53)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('추가 옵션은 준비 중입니다')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 채팅 리스트
          Expanded(
            child: Container(
              color: Color(0xFFFAFAFA),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                itemCount: _messages.length,
                itemBuilder: (context, idx) {
                  final msg = _messages[idx];
                  final isUser = msg['role'] == 'user';
                  // 첫 메시지이거나 전 메시지와 다른 화자일 경우 발신자 이름 표시
                  final showName = !isUser && (idx == 0 || _messages[idx - 1]['role'] != 'ai');
                  
                  return ChatBubble(
                    text: msg['content']!,
                    isUser: isUser,
                    avatarUrl: isUser ? null : widget.character['image'],
                    senderName: showName ? widget.character['name'] : null,
                    timestamp: DateTime.now(),
                  );
                },
              ),
            ),
          ),
          
          // 입력 영역
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Color(0xFF9B9B9B)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('준비 중인 기능입니다')),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        hintStyle: TextStyle(color: Color(0xFF9B9B9B), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      minLines: 1,
                      maxLines: 4,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_rounded, color: Color(0xFF5250C5)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          
          // 하단 네비게이션
          BottomNavigation(
            currentIndex: 0,
            onTap: (index) {
              if (index != 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('준비 중인 기능입니다'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
