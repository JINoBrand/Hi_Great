import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final String? avatarUrl;
  final String? senderName;
  final DateTime? timestamp;

  const ChatBubble({
    Key? key,
    required this.text,
    required this.isUser,
    this.avatarUrl,
    this.senderName,
    this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UI 컬러 설정
    final userBubbleColor = Color(0xFFE1E1FE);
    final aiBubbleColor = Colors.white;
    final userTextColor = Color(0xFF2F2F53);
    final aiTextColor = Color(0xFF2F2F53);
    
    final radius = isUser
        ? BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          );
            
    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 50.0 : 10.0,
        right: isUser ? 10.0 : 50.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // 타임스탬프 및 발신자 정보
          if (!isUser && senderName != null)
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
              child: Text(
                senderName!,
                style: TextStyle(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w500),
              ),
            ),
          
          // 메시지 버블
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // AI 아바타 (AI 메시지일 때만 표시)
              if (!isUser && avatarUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: avatarUrl!.startsWith('assets/')
                        ? Image.asset(
                            avatarUrl!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            avatarUrl!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.account_circle, size: 30, color: Colors.grey[400]),
                          ),
                    ),
                  ),
                ),
              
              // 메시지 내용
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? userBubbleColor : aiBubbleColor,
                    borderRadius: radius,
                    border: !isUser ? Border.all(color: Colors.grey[200]!) : null,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      color: isUser ? userTextColor : aiTextColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // 타임스탬프 (옵션)
          if (timestamp != null)
            Padding(
              padding: EdgeInsets.only(top: 4.0, left: isUser ? 0 : 10.0, right: isUser ? 10.0 : 0),
              child: Text(
                _formatTime(timestamp!),
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ),
        ],
      ),
    );
  }
  
  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
