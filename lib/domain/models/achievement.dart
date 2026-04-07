// lib/domain/models/achievement.dart

import '../../data/local/save_data.dart';

enum AchievementCategory {
  gameplay,
  combat,
  collection,
  story,
  challenge,
}

class Achievement {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final AchievementCategory category;
  final int progressGoal;
  final List<String> prerequisiteIds;
  final IconData icon;
  
  const Achievement({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.category,
    this.progressGoal = 1,
    this.prerequisiteIds = const [],
    required this.icon,
  });
  
  bool isCompleted(PlayerProgress progress) {
    return progress.getAchievementProgress(id) >= progressGoal;
  }
}

class PlayerAchievements {
  final Map<String, int> _progress;
  final Set<String> _completed;
  final DateTime? _lastUnlockDate;
  
  PlayerAchievements({
    Map<String, int>? progress,
    Set<String>? completed,
    DateTime? lastUnlockDate,
  })  : _progress = progress ?? {},
        _completed = completed ?? {},
        _lastUnlockDate = lastUnlockDate;
  
  int getProgress(String achievementId) => _progress[achievementId] ?? 0;
  
  bool isCompleted(String achievementId) => _completed.contains(achievementId);
  
  Set<String> get completedIds => Set.unmodifiable(_completed);
  
  Map<String, int> get allProgress => Map.unmodifiable(_progress);
  
  DateTime? get lastUnlockDate => _lastUnlockDate;
  
  void updateProgress(String achievementId, int amount) {
    if (_completed.contains(achievementId)) return;
    
    _progress[achievementId] = (_progress[achievementId] ?? 0) + amount;
  }
  
  void setProgress(String achievementId, int value) {
    if (_completed.contains(achievementId)) return;
    _progress[achievementId] = value;
  }
  
  void complete(String achievementId) {
    _completed.add(achievementId);
  }
  
  double getCompletionPercentage(List<Achievement> allAchievements) {
    if (allAchievements.isEmpty) return 0.0;
    return _completed.length / allAchievements.length * 100;
  }
  
  PlayerAchievements copyWith({
    Map<String, int>? progress,
    Set<String>? completed,
    DateTime? lastUnlockDate,
  }) {
    return PlayerAchievements(
      progress: progress ?? Map.from(_progress),
      completed: completed ?? Set.from(_completed),
      lastUnlockDate: lastUnlockDate ?? _lastUnlockDate,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'progress': _progress,
      'completed': _completed.toList(),
      'lastUnlockDate': _lastUnlockDate?.toIso8601String(),
    };
  }
  
  factory PlayerAchievements.fromJson(Map<String, dynamic> json) {
    return PlayerAchievements(
      progress: Map<String, int>.from(json['progress'] ?? {}),
      completed: Set<String>.from(json['completed'] ?? []),
      lastUnlockDate: json['lastUnlockDate'] != null 
          ? DateTime.parse(json['lastUnlockDate']) 
          : null,
    );
  }
}
