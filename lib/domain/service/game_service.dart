// lib/domain/services/game_service.dart

// IMPORTAZIONI CORRETTE (percorsi relativi dalla posizione del file)
import '../../data/game_state.dart';
import '../../data/path_generator.dart';

class GameService {
  GameState _state = GameState.newCampaign(PoliticalClass.corruptPolitician);
  List<Map<String, dynamic>> _currentMapNodes = [];

  // Singleton
  static final GameService _instance = GameService._internal();
  factory GameService() => _instance;
  GameService._internal() {
    _generateCurrentLevelMap();
  }

  // GETTERS
  GameState get currentState => _state;
  List<Map<String, dynamic>> get currentMap => _currentMapNodes;
  int get totalLevels => 3; // Camera, Senato, Governo

  // Inizia una nuova campagna
  void startNewCampaign(PoliticalClass character) {
    _state = GameState.newCampaign(character);
    _generateCurrentLevelMap();
  }

  // Genera la mappa per il livello corrente (istituzione politica)
  void _generateCurrentLevelMap() {
    switch (_state.currentLevel) {
      case 0:
        _currentMapNodes = PathGenerator.generateCameraDeiDeputati(seed: _state.currentLevel);
        break;
      case 1:
        _currentMapNodes = PathGenerator.generateSenato(seed: _state.currentLevel);
        break;
      case 2:
        _currentMapNodes = PathGenerator.generateGoverno(seed: _state.currentLevel);
        break;
      default:
        _currentMapNodes = PathGenerator.generateCameraDeiDeputati(seed: 0);
    }
  }

  // Muovi al nodo successivo (istituzione/luogo politico)
  bool moveToNode(String nodeId) {
    final availableNodes = PathGenerator.getAvailableNodes(
      _state.currentNodeId,
      _state.visitedNodeIds,
      _currentMapNodes,
    );
    
    final targetNode = availableNodes.firstWhere(
      (node) => node['id'] == nodeId,
      orElse: () => <String, dynamic>{},
    );
    
    if (targetNode.isEmpty) return false;
    
    final newNodeId = targetNode['id'] as String;
    final newFloor = targetNode['floor'] as int;
    final nodeType = targetNode['type'] as String;
    
    _state = _state.copyWith(
      currentNodeId: newNodeId,
      currentFloor: newFloor,
      visitedNodeIds: List<String>.from(_state.visitedNodeIds)..add(_state.currentNodeId),
    );
    
    // Verifica se è un nodo boss (ministro/presidente)
    if (nodeType == 'boss') {
      _state = _state.copyWith(isBossDefeated: false);
    }
    
    return true;
  }

  // Segna il boss come sconfitto e avanza al livello successivo
  void defeatBoss() {
    _state = _state.copyWith(
      isBossDefeated: true,
      euros: _state.euros + 50000, // Ricompensa boss: 50.000€
    );
  }

  // Avanza al livello successivo (da Camera a Senato a Governo)
  bool advanceToNextLevel() {
    if (_state.currentLevel >= totalLevels - 1 || !_state.isBossDefeated) {
      return false;
    }
    
    _state = _state.copyWith(
      currentLevel: _state.currentLevel + 1,
      currentFloor: 0,
      currentNodeId: 'node_0',
      visitedNodeIds: const [],
      isBossDefeated: false,
    );
    
    _generateCurrentLevelMap();
    return true;
  }

  // Perde influenza (invece di HP)
  void loseInfluence(int damage) {
    final newInfluence = (_state.currentInfluence - damage).clamp(0, _state.maxInfluence) as int;
    _state = _state.copyWith(currentInfluence: newInfluence);
    
    if (newInfluence <= 0) {
      _state = _state.copyWith(isGameOver: true);
    }
  }

  // Guadagna influenza
  void gainInfluence(int amount) {
    final newInfluence = (_state.currentInfluence + amount).clamp(0, _state.maxInfluence) as int;
    _state = _state.copyWith(currentInfluence: newInfluence);
  }

  // Guadagna euro (soldi)
  void addEuros(int amount) {
    _state = _state.copyWith(euros: _state.euros + amount);
  }

  // Aggiungi carta al mazzo (dopo combattimento)
  void addCardToDeck(String cardId) {
    _state = _state.copyWith(deck: List<String>.from(_state.deck)..add(cardId));
  }

  // Aggiungi perk (privilegio politico)
  void addPerk(String perkId) {
    _state = _state.copyWith(perks: List<String>.from(_state.perks)..add(perkId));
  }

  // Ottieni il tipo di nodo corrente
  String getCurrentNodeType() {
    final node = _currentMapNodes.firstWhere(
      (n) => n['id'] == _state.currentNodeId,
      orElse: () => {'type': 'unknown'},
    );
    return node['type'] as String;
  }

  // Reset dello stato (per debugging)
  void reset() {
    _state = GameState.newCampaign(PoliticalClass.corruptPolitician);
    _generateCurrentLevelMap();
  }
}