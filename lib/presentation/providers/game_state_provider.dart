import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/save_data.dart';
import '../data/local/local_storage_service.dart';
import '../data/game_state.dart';

enum GameStatus { menu, playing, paused, gameOver, victory }

class GameStateNotifier extends StateNotifier<GameState?> {
  final LocalStorageService _storageService;
  
  GameStatus _status = GameStatus.menu;
  GameStatus get status => _status;

  GameStateNotifier(this._storageService) : super(null);

  Future<void> initialize() async {
    await _storageService.initialize();
    
    // Prova a caricare l'ultimo save
    final currentSaveId = _storageService.getCurrentSaveId();
    if (currentSaveId != null) {
      final saveData = await _storageService.loadGame(currentSaveId);
      if (saveData != null && !saveData.isGameOver) {
        state = _convertSaveToGameState(saveData);
        _status = GameStatus.playing;
      }
    }
  }

  void startNewGame(PoliticalClass character) {
    final newGameState = GameState.newCampaign(character);
    state = newGameState;
    _status = GameStatus.playing;
  }

  Future<void> saveGame() async {
    if (state == null) return;
    
    final saveData = SaveData.fromGameState(state!);
    await _storageService.saveGame(saveData);
  }

  Future<void> loadGame(String saveId) async {
    final saveData = await _storageService.loadGame(saveId);
    if (saveData != null) {
      state = _convertSaveToGameState(saveData);
      _status = GameStatus.playing;
    }
  }

  GameState _convertSaveToGameState(SaveData saveData) {
    return GameState(
      character: PoliticalClass.values.firstWhere(
        (e) => e.name == saveData.characterClass,
        orElse: () => PoliticalClass.corruptPolitician,
      ),
      currentLevel: saveData.currentLevel,
      currentFloor: saveData.currentFloor,
      currentInfluence: saveData.currentInfluence,
      maxInfluence: saveData.maxInfluence,
      euros: saveData.euros,
      deck: saveData.deck,
      perks: saveData.perks,
      currentNodeId: saveData.currentNodeId,
      visitedNodeIds: saveData.visitedNodeIds,
      isBossDefeated: saveData.isBossDefeated,
      isGameOver: saveData.isGameOver,
    );
  }

  void updateInfluence(int amount) {
    if (state == null) return;
    
    final newInfluence = (state!.currentInfluence + amount).clamp(0, state!.maxInfluence);
    state = state!.copyWith(currentInfluence: newInfluence);
    
    if (newInfluence <= 0) {
      _status = GameStatus.gameOver;
    }
  }

  void addEuros(int amount) {
    if (state == null) return;
    state = state!.copyWith(euros: state!.euros + amount);
  }

  void addCardToDeck(String cardId) {
    if (state == null) return;
    final newDeck = List<String>.from(state!.deck)..add(cardId);
    state = state!.copyWith(deck: newDeck);
  }

  void removeCardFromDeck(String cardId) {
    if (state == null) return;
    final newDeck = List<String>.from(state!.deck)..remove(cardId);
    state = state!.copyWith(deck: newDeck);
  }

  void addPerk(String perkId) {
    if (state == null) return;
    final newPerks = List<String>.from(state!.perks)..add(perkId);
    state = state!.copyWith(perks: newPerks);
  }

  void moveToNode(String nodeId) {
    if (state == null) return;
    final visited = List<String>.from(state!.visitedNodeIds)..add(state!.currentNodeId);
    state = state!.copyWith(
      currentNodeId: nodeId,
      visitedNodeIds: visited,
    );
  }

  void advanceLevel() {
    if (state == null) return;
    state = state!.copyWith(
      currentLevel: state!.currentLevel + 1,
      currentFloor: 0,
    );
  }

  void advanceFloor() {
    if (state == null) return;
    state = state!.copyWith(
      currentFloor: state!.currentFloor + 1,
    );
  }

  void defeatBoss() {
    if (state == null) return;
    state = state!.copyWith(isBossDefeated: true);
    
    if (state!.currentLevel >= 2) {
      _status = GameStatus.victory;
    }
  }

  void setGameOver() {
    _status = GameStatus.gameOver;
    if (state != null) {
      state = state!.copyWith(isGameOver: true);
    }
  }

  void pause() {
    if (_status == GameStatus.playing) {
      _status = GameStatus.paused;
    }
  }

  void resume() {
    if (_status == GameStatus.paused) {
      _status = GameStatus.playing;
    }
  }

  void returnToMenu() {
    state = null;
    _status = GameStatus.menu;
  }

  Future<List<SaveData>> getSavedGames() async {
    return await _storageService.getAllSaves();
  }

  Future<void> deleteSave(String saveId) async {
    await _storageService.deleteSave(saveId);
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState?>((ref) {
  return GameStateNotifier(LocalStorageService());
});

final gameStatusProvider = Provider<GameStatus>((ref) {
  return ref.read(gameStateProvider.notifier).status;
});

final savedGamesProvider = FutureProvider<List<SaveData>>((ref) async {
  return await ref.read(gameStateProvider.notifier).getSavedGames();
});
