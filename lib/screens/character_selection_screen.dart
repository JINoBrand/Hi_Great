import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../widgets/locked_character_card.dart';
import 'chat_screen.dart';

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
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the max card size that fits 3:4 aspect ratio
          double maxWidth = constraints.maxWidth * 0.65 * 0.9;
          double maxHeight = constraints.maxHeight * 0.6;
          double cardWidth = maxWidth;
          double cardHeight = cardWidth / 3 * 4;
          if (cardHeight > maxHeight) {
            cardHeight = maxHeight;
            cardWidth = cardHeight / 4 * 3;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 128,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    children: [
                      ...availableCharacters.map(
                        (character) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () => _onCharacterTap(context, character),
                            child: CharacterCard(
                              name: character['name']!,
                              quote: character['quote']!,
                              imageUrl: character['image']!,
                              width: cardWidth,
                              height: cardHeight,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        totalCharacters - availableCharacters.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () => _onLockedTap(context),
                            child: LockedCharacterCard(
                              width: cardWidth,
                              height: cardHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
