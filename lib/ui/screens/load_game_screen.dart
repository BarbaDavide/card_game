// lib/ui/screens/load_game_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../presentation/providers/game_state_provider.dart';
import '../../data/local/save_data.dart';

class LoadGameScreen extends ConsumerWidget {
  const LoadGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedGamesAsync = ref.watch(savedGamesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: const Text('Continue Game'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: savedGamesAsync.when(
        data: (savedGames) {
          if (savedGames.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildSaveList(context, ref, savedGames);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error loading saves: $error'),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.save_alt, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Saved Games',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Start a new game to create a save',
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
    );
  }

  Widget _buildSaveList(BuildContext context, WidgetRef ref, List<SaveData> saves) {
    // Ordina per data decrescente
    saves.sort((a, b) => b.savedAt.compareTo(a.savedAt));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: saves.length,
      itemBuilder: (context, index) {
        final save = saves[index];
        return _buildSaveCard(context, ref, save);
      },
    );
  }

  Widget _buildSaveCard(BuildContext context, WidgetRef ref, SaveData save) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    
    return Card(
      color: const Color(0xFF1A1A2A),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: save.isGameOver ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: save.isGameOver ? null : () => _loadGame(context, ref, save),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildCharacterIcon(save.characterClass),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getCharacterName(save.characterClass),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Level ${save.currentLevel + 1} • Floor ${save.currentFloor + 1}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (save.isGameOver)
                    const Chip(
                      label: Text('GAME OVER', style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.red,
                    )
                  else if (save.isBossDefeated)
                    const Chip(
                      label: Text('BOSS DEFEATED', style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.orange,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatChip(Icons.favorite, '${save.currentInfluence}/${save.maxInfluence}', 'Influence'),
                  const SizedBox(width: 8),
                  _buildStatChip(Icons.euro, '€${save.euros ~/ 1000}k', 'Euros'),
                  const SizedBox(width: 8),
                  _buildStatChip(Icons.collections_bookmark, '${save.deck.length}', 'Cards'),
                  const SizedBox(width: 8),
                  _buildStatChip(Icons.workspace_premium, '${save.perks.length}', 'Perks'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saved: ${dateFormat.format(save.savedAt)}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      if (!save.isGameOver) ...[
                        IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.green),
                          onPressed: () => _loadGame(context, ref, save),
                          tooltip: 'Load Game',
                        ),
                        const SizedBox(width: 8),
                      ],
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(context, ref, save),
                        tooltip: 'Delete Save',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterIcon(String characterClass) {
    IconData icon;
    Color color;

    switch (characterClass) {
      case 'corruptPolitician':
        icon = Icons.gavel;
        color = Colors.red;
        break;
      case 'journalist':
        icon = Icons.newspaper;
        color = Colors.blue;
        break;
      case 'activist':
        icon = Icons.people;
        color = Colors.green;
        break;
      case 'bureaucrat':
        icon = Icons.description;
        color = Colors.purple;
        break;
      default:
        icon = Icons.person;
        color = Colors.grey;
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }

  Widget _buildStatChip(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[400]),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getCharacterName(String characterClass) {
    switch (characterClass) {
      case 'corruptPolitician':
        return 'Corrupt Politician';
      case 'journalist':
        return 'Journalist';
      case 'activist':
        return 'Activist';
      case 'bureaucrat':
        return 'Bureaucrat';
      default:
        return characterClass;
    }
  }

  void _loadGame(BuildContext context, WidgetRef ref, SaveData save) async {
    await ref.read(gameStateProvider.notifier).loadGame(save.saveId);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, SaveData save) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('Delete Save'),
        content: Text(
          'Are you sure you want to delete this save?\n\n'
          '${_getCharacterName(save.characterClass)} - Level ${save.currentLevel + 1}\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(gameStateProvider.notifier).deleteSave(save.saveId);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }
}
