import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import 'chat_screen.dart';
import '../widgets/bottom_navigation.dart';

class CharacterSelectionScreen extends StatelessWidget {
  CharacterSelectionScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> availableCharacters = [
    {
      'name': '세종대왕',
      'quote': '백성을 사랑하는 마음이 곧 나라의 힘이다.',
      'image': 'assets/sejong.png',
    },
    {
      'name': '스티브 잡스',
      'quote': '혁신은 리더와 추종자를 구분짓는다.',
      'image': 'assets/jobs.png',
    },
    {
      'name': '간디',
      'quote': '당신이 세상에서 보고 싶은 변화가 되세요.',
      'image': 'assets/gandi.png',
    },
  ];

  final int totalCharacters = 10;

  void _onCharacterTap(BuildContext context, Map<String, String> character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(character: character),
      ),
    );
  }

  void _onLockedTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('준비 중입니다'),
        content: Text('해당 인물은 곧 만날 수 있습니다!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
              child: const Text(
                'Hi Great',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Title and Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    '인물 선택하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '당신이 가장 대화해 보고 싶은 위인은 누구인가요?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Character List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...availableCharacters.map(
                      (character) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CharacterCard(
                          name: character['name']!,
                          quote: character['quote']!,
                          imageUrl: character['image']!,
                          actionButtonText: character['name'] == '세종대왕' ? '상호 즐기기' :
                                           character['name'] == '스티브 잡스' ? 'Ideation 시작하기' :
                                           '대화 시작하기',
                          onActionButtonPressed: () => _onCharacterTap(context, character),
                        ),
                      ),
                    ),
                    // 더 많은 캐릭터를 추가할 수 있음
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation
            BottomNavigation(
              currentIndex: 0,
              onTap: (index) {
                // 탭 변경 로직 구현
                if (index != 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('준비 중인 기능입니다.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
