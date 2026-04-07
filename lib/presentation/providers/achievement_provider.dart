import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement.dart';
import '../../data/achievements_database.dart';
import '../../data/local/local_storage_service.dart';

class AchievementNotifier extends StateNotifier<PlayerAchievements> {
  final LocalStorageService _storageService;
  
  AchievementNotifier(this._storageService) : super(PlayerAchievements());
  
  Future<void> initialize() async {
    await _storageService.initialize();
    final saved = _storageService.getAchievements();
    if (saved != null) {
      state = PlayerAchievements.fromJson(saved);
    }
  }
  
  void trackProgress(String achievementId, int amount) {
    if (state.isCompleted(achievementId)) return;
    
    state.updateProgress(achievementId, amount);
    
    final achievement = AchievementsDatabase.all.firstWhere(
      (a) => a.id == achievementId,
      orElse: () => throw Exception('Achievement $achievementId not found'),
    );
    
    if (state.getProgress(achievementId) >= achievement.progressGoal) {
      _unlockAchievement(achievementId);
    }
    
    _save();
  }
  
  void setProgress(String achievementId, int value) {
    if (state.isCompleted(achievementId)) return;
    
    state.setProgress(achievementId, value);
    
    final achievement = AchievementsDatabase.all.firstWhere(
      (a) => a.id == achievementId,
      orElse: () => throw Exception('Achievement $achievementId not found'),
    );
    
    if (value >= achievement.progressGoal) {
      _unlockAchievement(achievementId);
    }
    
    _save();
  }
  
  void _unlockAchievement(String achievementId) {
    if (state.isCompleted(achievementId)) return;
    
    state.complete(achievementId);
    
    // Check prerequisites for chained achievements
    for (final achievement in AchievementsDatabase.all) {
      if (achievement.prerequisiteIds.contains(achievementId)) {
        // Unlock notification could be triggered here
      }
    }
  }
  
  void _save() {
    _storageService.saveAchievements(state.toJson());
  }
  
  double getCompletionPercentage() {
    return state.getCompletionPercentage(AchievementsDatabase.all);
  }
  
  List<Achievement> getCompletedAchievements() {
    return AchievementsDatabase.all
        .where((a) => state.isCompleted(a.id))
        .toList();
  }
  
  List<Achievement> getInProgressAchievements() {
    return AchievementsDatabase.all
        .where((a) => !state.isCompleted(a.id))
        .toList();
  }
  
  AchievementProgress getProgressForAchievement(String achievementId) {
    final achievement = AchievementsDatabase.all.firstWhere(
      (a) => a.id == achievementId,
      orElse: () => throw Exception('Achievement $achievementId not found'),
    );
    
    return AchievementProgress(
      achievement: achievement,
      current: state.getProgress(achievementId),
      goal: achievement.progressGoal,
      isCompleted: state.isCompleted(achievementId),
    );
  }
  
  void reset() {
    state = PlayerAchievements();
    _save();
  }
}

class AchievementProgress {
  final Achievement achievement;
  final int current;
  final int goal;
  final bool isCompleted;
  
  const AchievementProgress({
    required this.achievement,
    required this.current,
    required this.goal,
    required this.isCompleted,
  });
  
  double get percentage => goal > 0 ? current / goal : 0.0;
}

final achievementProvider = StateNotifierProvider<AchievementNotifier, PlayerAchievements>((ref) {
  return AchievementNotifier(LocalStorageService());
});

final achievementCompletionProvider = Provider<double>((ref) {
  return ref.read(achievementProvider.notifier).getCompletionPercentage();
});

final completedAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getCompletedAchievements();
});

final inProgressAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(achievementProvider.notifier).getInProgressAchievements();
});
