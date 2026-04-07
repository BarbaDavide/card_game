import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement.dart';
import '../../data/achievements_database.dart';
import '../../presentation/providers/achievement_provider.dart';
import '../../l10n/l10n.dart';

class AchievementScreen extends ConsumerWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final achievements = ref.watch(achievementProvider);
    final completion = ref.watch(achievementCompletionProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        title: Text(l10n.achievementsTitle),
        backgroundColor: const Color(0xFF121225),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '${completion.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00D9FF),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCompletionBar(context, completion),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.check_circle), text: 'Completed'),
                      Tab(icon: Icon(Icons.pending), text: 'In Progress'),
                    ],
                    indicatorColor: Color(0xFF6C63FF),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildAchievementList(
                          context,
                          ref,
                          ref.watch(completedAchievementsProvider),
                          achievements,
                        ),
                        _buildAchievementList(
                          context,
                          ref,
                          ref.watch(inProgressAchievementsProvider),
                          achievements,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCompletionBar(BuildContext context, double percentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1A2E).withOpacity(0.8),
            const Color(0xFF16213E).withOpacity(0.8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).totalCompletion,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF6C63FF),
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAchievementList(
    BuildContext context,
    WidgetRef ref,
    List<Achievement> achievementList,
    PlayerAchievements playerAchievements,
  ) {
    if (achievementList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).noAchievements,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: achievementList.length,
      itemBuilder: (context, index) {
        final achievement = achievementList[index];
        final isCompleted = playerAchievements.isCompleted(achievement.id);
        final progress = playerAchievements.getProgress(achievement.id);
        
        return _buildAchievementCard(
          context,
          achievement,
          progress,
          isCompleted,
        );
      },
    );
  }
  
  Widget _buildAchievementCard(
    BuildContext context,
    Achievement achievement,
    int progress,
    bool isCompleted,
  ) {
    final l10n = AppLocalizations.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: isCompleted
          ? const Color(0xFF1A1A2E).withOpacity(0.8)
          : const Color(0xFF121225).withOpacity(0.6),
      elevation: isCompleted ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isCompleted ? const Color(0xFF00D9FF) : Colors.grey[800]!,
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xFF6C63FF).withOpacity(0.3)
                    : Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                achievement.icon,
                size: 32,
                color: isCompleted ? const Color(0xFF00D9FF) : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLocalizedTitle(l10n, achievement.titleKey),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCompleted ? Colors.white : Colors.grey[400],
                          ),
                        ),
                      ),
                      if (isCompleted)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF00D9FF),
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getLocalizedDescription(l10n, achievement.descriptionKey),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isCompleted && achievement.progressGoal > 1) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress / achievement.progressGoal,
                        backgroundColor: Colors.grey[800],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF6C63FF),
                        ),
                        minHeight: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$progress / ${achievement.progressGoal}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getLocalizedTitle(AppLocalizations l10n, String key) {
    // Mappatura hardcoded per demo - da sostituire con lookup dinamico
    switch (key) {
      case 'achievement_first_run_title':
        return 'First Run';
      case 'achievement_win_first_game_title':
        return 'Victory!';
      case 'achievement_complete_10_runs_title':
        return 'Veteran';
      default:
        return key;
    }
  }
  
  String _getLocalizedDescription(AppLocalizations l10n, String key) {
    switch (key) {
      case 'achievement_first_run_desc':
        return 'Complete your first run';
      case 'achievement_win_first_game_desc':
        return 'Win your first game';
      case 'achievement_complete_10_runs_desc':
        return 'Complete 10 runs';
      default:
        return key;
    }
  }
}
