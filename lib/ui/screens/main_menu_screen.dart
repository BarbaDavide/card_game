// lib/ui/screens/main_menu_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'character_selection_screen.dart';
import 'load_game_screen.dart';
import 'achievement_screen.dart';
import 'statistics_screen.dart';
import '../../presentation/providers/game_state_provider.dart';
import '../../presentation/providers/settings_provider.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStatus = ref.watch(gameStatusProvider);
    final hasActiveGame = gameStatus == GameStatus.playing || gameStatus == GameStatus.paused;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'ROGUE CARD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Political Satire Deckbuilder',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            // Continue button (se c'è una partita attiva)
            if (hasActiveGame) ...[
              _buildMenuButton(
                context,
                'CONTINUE',
                Colors.green,
                () => _resumeGame(context, ref),
              ),
              const SizedBox(height: 16),
            ],
            
            // Menu buttons
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMenuButton(
                      context,
                      'NEW RUN',
                      Colors.green,
                      () => _navigateToCharacterSelection(context),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      'LOAD GAME',
                      Colors.blue,
                      () => _navigateToLoadGame(context),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      'COLLECTION',
                      Colors.purple,
                      () => _navigateToCollection(context),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      'ACHIEVEMENTS',
                      const Color(0xFFFFD700),
                      () => _navigateToAchievements(context),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      'STATISTICS',
                      const Color(0xFF00D9FF),
                      () => _navigateToStatistics(context),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      'SETTINGS',
                      Colors.grey,
                      () => _showSettings(context, ref),
                    ),
                  ],
                ),
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF12121A),
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
                ),
              ),
              child: const Text(
                'v1.0.0 • Satirical Political Roguelike',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 280,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A2A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withOpacity(0.5), width: 1.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconForLabel(label),
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'NEW RUN': 
      case 'CONTINUE':
        return Icons.play_arrow;
      case 'LOAD GAME': 
        return Icons.folder_open;
      case 'COLLECTION': 
        return Icons.collections_bookmark;
      case 'SETTINGS': 
        return Icons.settings;
      default: 
        return Icons.help;
    }
  }

  void _resumeGame(BuildContext context, WidgetRef ref) {
    ref.read(gameStateProvider.notifier).resume();
    // Naviga alla schermata di gioco
    Navigator.pop(context);
  }

  void _navigateToLoadGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadGameScreen(),
      ),
    );
  }

  
  void _navigateToAchievements(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AchievementScreen()),
    );
  }

  void _navigateToStatistics(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StatisticsScreen()),
    );
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSettingRow(
              'Music Volume', 
              '${(settings['musicVolume'] * 100).toInt()}%',
              Icons.music_note,
            ),
            _buildSettingRow(
              'SFX Volume', 
              '${(settings['sfxVolume'] * 100).toInt()}%',
              Icons.volume_up,
            ),
            _buildSettingRow(
              'Language', 
              settings['language'].toString().toUpperCase(),
              Icons.language,
            ),
            _buildSettingRow(
              'Tutorial', 
              settings['showTutorial'] ? 'ON' : 'OFF',
              Icons.school,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
          TextButton(
            onPressed: () {
              // Qui si aprirà la schermata settings completa
              Navigator.pop(context);
            },
            child: const Text('OPEN FULL SETTINGS'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Screen collezione come widget separato
class _CollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: const Text('📚 Collection'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.collections_bookmark, size: 50, color: Colors.purple),
            ),
            const SizedBox(height: 24),
            const Text(
              'Card Collection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your political cards will appear here',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('BACK TO MENU'),
            ),
          ],
        ),
      ),
    );
  }
}