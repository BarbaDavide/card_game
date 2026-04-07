import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<Map<String, dynamic>> {
  SettingsNotifier() : super({});

  void initialize() {
    state = {
      'musicVolume': 0.7,
      'sfxVolume': 0.8,
      'language': 'it',
      'showTutorial': true,
      'difficulty': 'normal',
      'autoSave': true,
    };
  }

  void setMusicVolume(double volume) {
    state = {...state, 'musicVolume': volume.clamp(0.0, 1.0)};
  }

  void setSfxVolume(double volume) {
    state = {...state, 'sfxVolume': volume.clamp(0.0, 1.0)};
  }

  void setLanguage(String language) {
    state = {...state, 'language': language};
  }

  void setShowTutorial(bool show) {
    state = {...state, 'showTutorial': show};
  }

  void setDifficulty(String difficulty) {
    state = {...state, 'difficulty': difficulty};
  }

  void setAutoSave(bool enabled) {
    state = {...state, 'autoSave': enabled};
  }

  T get<T>(String key, T defaultValue) {
    return state[key] as T? ?? defaultValue;
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Map<String, dynamic>>((ref) {
  return SettingsNotifier();
});
