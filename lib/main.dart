import 'package:flutter/material.dart';
import 'screens/character_selection_screen.dart';

void main() {
  runApp(HiGreatApp());
}

class HiGreatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hi_Great',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0C0D0D),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CharacterSelectionScreen(),
    );
  }
}
