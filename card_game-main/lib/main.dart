// lib/main.dart

import 'package:flutter/material.dart';
import 'ui/screens/main_menu_screen.dart';

void main() {
  runApp(const RogueCardApp());
}

class RogueCardApp extends StatelessWidget {
  const RogueCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rogue Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A12),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF121225),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainMenuScreen(), // ← Usa il menu principale
    );
  }
}