import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSoundManager {
  static final AppSoundManager _instance = AppSoundManager._internal();
  factory AppSoundManager() => _instance;
  AppSoundManager._internal();

  bool _isInitialized = false;
  double _musicVolume = 0.7;
  double _sfxVolume = 0.8;
  bool _isMuted = false;

  // Placeholder per i player audio
  // Nella implementazione reale, qui ci sarebbero le istanze di AudioPlayer
  void initialize() {
    if (_isInitialized) return;
    
    // Configura audio session
    _setAudioSession();
    _isInitialized = true;
  }

  Future<void> _setAudioSession() async {
    // Configura l'audio session per iOS/Android
    // Questo è un placeholder - nella implementazione reale si usa audioplayers
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } catch (e) {
      debugPrint('Error setting audio session: $e');
    }
  }

  // MUSIC CONTROL
  Future<void> playMusic(String musicPath) async {
    if (_isMuted) return;
    
    // Implementazione reale con AudioPlayer
    debugPrint('Playing music: $musicPath (volume: $_musicVolume)');
  }

  Future<void> stopMusic() async {
    debugPrint('Stopping music');
  }

  Future<void> pauseMusic() async {
    debugPrint('Pausing music');
  }

  Future<void> resumeMusic() async {
    if (!_isMuted) {
      debugPrint('Resuming music');
    }
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    debugPrint('Music volume set to: $_musicVolume');
  }

  // SFX CONTROL
  Future<void> playSFX(String sfxPath) async {
    if (_isMuted) return;
    
    // Implementazione reale con AudioPlayer
    debugPrint('Playing SFX: $sfxPath (volume: $_sfxVolume)');
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
    debugPrint('SFX volume set to: $_sfxVolume');
  }

  // MUTE CONTROL
  void toggleMute() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      stopMusic();
    } else {
      resumeMusic();
    }
    debugPrint('Mute toggled: $_isMuted');
  }

  bool get isMuted => _isMuted;
  bool get isInitialized => _isInitialized;

  // Preload common SFX
  Future<void> preloadSFX(List<String> paths) async {
    debugPrint('Preloading ${paths.length} sound effects');
    // Implementazione reale con cache
  }

  // Dispose
  Future<void> dispose() async {
    await stopMusic();
    _isInitialized = false;
    debugPrint('Sound manager disposed');
  }
}

// Sound Effects Catalog
class SFX {
  // UI Sounds
  static const String buttonClick = 'assets/audio/sfx/button_click.wav';
  static const String buttonHover = 'assets/audio/sfx/button_hover.wav';
  static const String cardDraw = 'assets/audio/sfx/card_draw.wav';
  static const String cardPlay = 'assets/audio/sfx/card_play.wav';
  
  // Battle Sounds
  static const String attack = 'assets/audio/sfx/attack.wav';
  static const String block = 'assets/audio/sfx/block.wav';
  static const String damage = 'assets/audio/sfx/damage.wav';
  static const String heal = 'assets/audio/sfx/heal.wav';
  static const String death = 'assets/audio/sfx/death.wav';
  static const String victory = 'assets/audio/sfx/victory.wav';
  static const String defeat = 'assets/audio/sfx/defeat.wav';
  
  // Game Events
  static const String levelUp = 'assets/audio/sfx/level_up.wav';
  static const String obtainItem = 'assets/audio/sfx/obtain_item.wav';
  static const String obtainCard = 'assets/audio/sfx/obtain_card.wav';
  static const String obtainPerk = 'assets/audio/sfx/obtain_perk.wav';
  static const String saveGame = 'assets/audio/sfx/save_game.wav';
  static const String loadGame = 'assets/audio/sfx/load_game.wav';
  
  // Character Specific
  static const String corruptLaugh = 'assets/audio/sfx/corrupt_laugh.wav';
  static const String journalistTyping = 'assets/audio/sfx/journalist_typing.wav';
  static const String activistChant = 'assets/audio/sfx/activist_chant.wav';
  static const String bureaucratStamp = 'assets/audio/sfx/bureaucrat_stamp.wav';
}

// Music Tracks Catalog
class Music {
  static const String mainMenu = 'assets/audio/music/main_menu.mp3';
  static const String battle = 'assets/audio/music/battle.mp3';
  static const String map = 'assets/audio/music/map.mp3';
  static const String merchant = 'assets/audio/music/merchant.mp3';
  static const String bossBattle = 'assets/audio/music/boss_battle.mp3';
  static const String victory = 'assets/audio/music/victory.mp3';
  static const String gameOver = 'assets/audio/music/game_over.mp3';
  static const String characterSelect = 'assets/audio/music/character_select.mp3';
}
