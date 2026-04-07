// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/local/local_storage_service.dart';
import 'presentation/providers/game_state_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'ui/screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializza storage locale
  final storageService = LocalStorageService();
  await storageService.initialize();
  
  runApp(
    const ProviderScope(
      child: RogueCardApp(),
    ),
  );
}

class RogueCardApp extends ConsumerWidget {
  const RogueCardApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Inizializza settings
    ref.read(settingsProvider.notifier).initialize();
    
    return MaterialApp(
      title: 'Rogue Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A12),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121225),
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00D9FF),
          surface: Color(0xFF1A1A2E),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}
