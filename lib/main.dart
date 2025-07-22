import 'package:flutter/material.dart';
import 'screens/character_selection_screen.dart';

void main() {
  runApp(IfAndTryApp());
}

class IfAndTryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IF AND TRY',
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
