import 'package:hive/hive.dart';

part 'save_data.g.dart';

@HiveType(typeId: 0)
class SaveData extends HiveObject {
  @HiveField(0)
  String saveId;

  @HiveField(1)
  DateTime savedAt;

  @HiveField(2)
  String characterClass;

  @HiveField(3)
  int currentLevel;

  @HiveField(4)
  int currentFloor;

  @HiveField(5)
  int currentInfluence;

  @HiveField(6)
  int maxInfluence;

  @HiveField(7)
  int euros;

  @HiveField(8)
  List<String> deck;

  @HiveField(9)
  List<String> perks;

  @HiveField(10)
  String currentNodeId;

  @HiveField(11)
  List<String> visitedNodeIds;

  @HiveField(12)
  bool isBossDefeated;

  @HiveField(13)
  bool isGameOver;

  @HiveField(14)
  Map<String, dynamic> metadata;

  SaveData({
    required this.saveId,
    required this.savedAt,
    required this.characterClass,
    this.currentLevel = 0,
    this.currentFloor = 0,
    this.currentInfluence = 0,
    this.maxInfluence = 0,
    this.euros = 10000,
    this.deck = const [],
    this.perks = const [],
    this.currentNodeId = 'node_0',
    this.visitedNodeIds = const [],
    this.isBossDefeated = false,
    this.isGameOver = false,
    this.metadata = const {},
  });

  factory SaveData.fromGameState(dynamic gameState) {
    return SaveData(
      saveId: gameState.saveId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      savedAt: DateTime.now(),
      characterClass: gameState.character.name,
      currentLevel: gameState.currentLevel,
      currentFloor: gameState.currentFloor,
      currentInfluence: gameState.currentInfluence,
      maxInfluence: gameState.maxInfluence,
      euros: gameState.euros,
      deck: List<String>.from(gameState.deck),
      perks: List<String>.from(gameState.perks),
      currentNodeId: gameState.currentNodeId,
      visitedNodeIds: List<String>.from(gameState.visitedNodeIds),
      isBossDefeated: gameState.isBossDefeated,
      isGameOver: gameState.isGameOver,
      metadata: {
        'version': '1.0.0',
        'platform': 'mobile',
      },
    );
  }

  dynamic toGameState() {
    // Questo verrà implementato nel repository
    return this;
  }
}
