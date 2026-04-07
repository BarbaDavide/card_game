import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsNotifier extends StateNotifier<Map<String, dynamic>> {
  final _stats = <String, dynamic>{
    'totalRuns': 0,
    'wins': 0,
    'losses': 0,
    'totalBattles': 0,
    'cardsCollected': 0,
    'totalGoldEarned': 0,
    'highestFloor': 0,
    'achievementsUnlocked': 0,
    'playTimeSeconds': 0,
    'cardsPlayed': 0,
    'enemiesDefeated': 0,
    'bossesDefeated': 0,
  };

  StatisticsNotifier() : super(Map.from(_stats));

  void increment(String statId, [int amount = 1]) {
    if (!state.containsKey(statId)) return;
    
    final currentValue = state[statId] as int? ?? 0;
    state = Map.from(state)..[statId] = currentValue + amount;
  }

  void setStat(String statId, dynamic value) {
    if (!state.containsKey(statId)) return;
    state = Map.from(state)..[statId] = value;
  }

  int getStat(String statId, {int defaultValue = 0}) {
    return state[statId] as int? ?? defaultValue;
  }

  double getWinRate() {
    final totalGames = getStat('wins') + getStat('losses');
    if (totalGames == 0) return 0.0;
    return getStat('wins') / totalGames * 100;
  }

  Map<String, dynamic> toJson() => Map.from(state);

  void loadFromJson(Map<String, dynamic> json) {
    state = Map.from(_stats);
    for (final key in json.keys) {
      if (state.containsKey(key)) {
        state[key] = json[key];
      }
    }
  }

  void reset() {
    state = Map.from(_stats);
  }
}

final statisticsProvider = StateNotifierProvider<StatisticsNotifier, Map<String, dynamic>>((ref) {
  return StatisticsNotifier();
});
