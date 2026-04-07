import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'save_data.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  Box<SaveData>? _saveBox;
  Box<dynamic>? _settingsBox;
  Box<dynamic>? _achievementsBox;

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final appDocumentDir = await getApplicationDocumentsDirectory();
    
    await Hive.initFlutter(appDocumentDir.path);

    // Registra gli adapter
    Hive.registerAdapter(SaveDataAdapter());

    // Apri i box
    _saveBox = await Hive.openBox<SaveData>('saves');
    _settingsBox = await Hive.openBox('settings');
    _achievementsBox = await Hive.openBox('achievements');

    _isInitialized = true;
  }

  // SAVE MANAGEMENT
  Future<void> saveGame(SaveData saveData) async {
    await _ensureInitialized();
    await _saveBox!.put(saveData.saveId, saveData);
    
    // Imposta come save corrente
    await _settingsBox!.put('currentSaveId', saveData.saveId);
  }

  Future<SaveData?> loadGame(String saveId) async {
    await _ensureInitialized();
    return _saveBox!.get(saveId);
  }

  Future<List<SaveData>> getAllSaves() async {
    await _ensureInitialized();
    return _saveBox!.values.toList();
  }

  Future<void> deleteSave(String saveId) async {
    await _ensureInitialized();
    await _saveBox!.delete(saveId);
    
    // Se era il save corrente, pulisci il riferimento
    if (_settingsBox!.get('currentSaveId') == saveId) {
      await _settingsBox!.delete('currentSaveId');
    }
  }

  String? getCurrentSaveId() {
    return _settingsBox?.get('currentSaveId');
  }

  // SETTINGS MANAGEMENT
  Future<void> setSetting(String key, dynamic value) async {
    await _ensureInitialized();
    await _settingsBox!.put(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox?.get(key, defaultValue: defaultValue) as T?;
  }

  // HIGH SCORES
  Future<void> saveHighScore(String category, int score) async {
    await _ensureInitialized();
    final currentBest = getSetting<int>('highscore_$category', defaultValue: 0);
    if (score > currentBest!) {
      await setSetting('highscore_$category', score);
      await setSetting('highscore_${category}_date', DateTime.now().toIso8601String());
    }
  }

  int getHighScore(String category, {int defaultValue = 0}) {
    return getSetting<int>('highscore_$category', defaultValue: defaultValue)!;
  }

  // UTILITY
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  Future<void> clearAllData() async {
    await _ensureInitialized();
    await _saveBox?.clear();
    await _settingsBox?.clear();
  }

  Future<void> close() async {
    await _saveBox?.close();
    await _settingsBox?.close();
    _isInitialized = false;
  }
}

  // ACHIEVEMENTS MANAGEMENT
  Future<void> saveAchievements(Map<String, dynamic> data) async {
    await _ensureInitialized();
    await _achievementsBox!.put('player_achievements', data);
  }
  
  Map<String, dynamic>? getAchievements() {
    return _achievementsBox?.get('player_achievements') as Map<String, dynamic>?;
  }
  
  // STATISTICS MANAGEMENT
  Future<void> saveStatistics(Map<String, dynamic> data) async {
    await _ensureInitialized();
    await _achievementsBox!.put('statistics', data);
  }
  
  Map<String, dynamic>? getStatistics() {
    return _achievementsBox?.get('statistics') as Map<String, dynamic>?;
  }
  
  void incrementStat(String statId, int amount) {
    final stats = getStatistics() ?? {};
    stats[statId] = (stats[statId] ?? 0) + amount;
    saveStatistics(stats);
  }
  
  int getStat(String statId, {int defaultValue = 0}) {
    final stats = getStatistics() ?? {};
    return stats[statId] as int? ?? defaultValue;
  }
