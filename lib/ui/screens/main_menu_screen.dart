// lib/ui/screens/main_menu_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'character_selection_screen.dart';
import 'load_game_screen.dart';
import 'achievement_screen.dart';
import 'statistics_screen.dart';
import 'settings_screen.dart';
import '../../presentation/providers/game_state_provider.dart';
import '../../presentation/providers/settings_provider.dart';
import '../widgets/accessible_button.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({super.key});

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {

  @override
  Widget build(BuildContext context) {
    final gameStatus = ref.watch(gameStatusProvider);
    final hasActiveGame = gameStatus == GameStatus.playing || gameStatus == GameStatus.paused;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: SafeArea(
        child: Semantics(
          explicitChildNodes: true,
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Semantics(
                      heading: true,
                      label: 'Rogue Card Game Title',
                      child: const Text(
                        'ROGUE CARD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
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
                _buildAccessibleMenuButton(
                  'CONTINUE',
                  Colors.green,
                  () => _resumeGame(context, ref),
                  'Resume current game',
                ),
                const SizedBox(height: 16),
              ],
              
              // Menu buttons
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAccessibleMenuButton(
                        'NEW RUN',
                        Colors.green,
                        () => _navigateToCharacterSelection(context),
                        'Start a new game run',
                      ),
                      const SizedBox(height: 16),
                      _buildAccessibleMenuButton(
                        'LOAD GAME',
                        Colors.blue,
                        () => _navigateToLoadGame(context),
                        'Load a saved game',
                      ),
                      const SizedBox(height: 16),
                      _buildAccessibleMenuButton(
                        'COLLECTION',
                        Colors.purple,
                        () => _navigateToCollection(context),
                        'View your card collection',
                      ),
                      const SizedBox(height: 16),
                      _buildAccessibleMenuButton(
                        'ACHIEVEMENTS',
                        const Color(0xFFFFD700),
                        () => _navigateToAchievements(context),
                        'View unlocked achievements',
                      ),
                      const SizedBox(height: 16),
                      _buildAccessibleMenuButton(
                        'STATISTICS',
                        const Color(0xFF00D9FF),
                        () => _navigateToStatistics(context),
                        'View game statistics',
                      ),
                      const SizedBox(height: 16),
                      _buildAccessibleMenuButton(
                        'SETTINGS',
                        Colors.grey,
                        () => _navigateToSettings(context),
                        'Open game settings',
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
              child: Semantics(
                label: 'Version 1.0.0 Satirical Political Roguelike',
                child: const Text(
                  'v1.0.0 • Satirical Political Roguelike',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibleMenuButton(
    String label,
    Color color,
    VoidCallback onPressed,
    String semanticLabel,
  ) {
    return AccessibleButton(
      onTap: onPressed,
      label: label,
      semanticLabel: semanticLabel,
      backgroundColor: const Color(0xFF1A1A2A),
      minWidth: 280,
      minHeight: 60,
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

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
      case 'ACHIEVEMENTS':
        return Icons.emoji_events;
      case 'STATISTICS':
        return Icons.bar_chart;
      case 'SETTINGS': 
        return Icons.settings;
      default: 
        return Icons.help;
    }
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

  void _navigateToCollection(BuildContext context) {
    // Placeholder - da implementare con schermata collezione reale
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Card Collection - Coming Soon')),
    );
  }
}
