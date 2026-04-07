// run_state.dart

class RunState {
  final String id; // ID univoco della run (es. timestamp o UUID)
  final String fighterId; // "ironclad", "silent", ecc.
  final int currentHp;
  final int maxHp;
  final int gold;
  final int floor;
  final String currentPathNodeId; // ID del nodo corrente nella mappa
  final List<String> visitedNodeIds; // Nodi già visitati
  final List<String> relicIds; // ID delle reliquie raccolte
  final List<String> cardIds; // ID delle carte nel mazzo
  final String gameState; // "ongoing", "victory", "defeat"

  RunState({
    required this.id,
    required this.fighterId,
    required this.currentHp,
    required this.maxHp,
    required this.gold,
    required this.floor,
    required this.currentPathNodeId,
    required this.visitedNodeIds,
    required this.relicIds,
    required this.cardIds,
    required this.gameState,
  });

  // Crea una copia con campi modificati (pattern immutabile)
  RunState copyWith({
    String? id,
    String? fighterId,
    int? currentHp,
    int? maxHp,
    int? gold,
    int? floor,
    String? currentPathNodeId,
    List<String>? visitedNodeIds,
    List<String>? relicIds,
    List<String>? cardIds,
    String? gameState,
  }) {
    return RunState(
      id: id ?? this.id,
      fighterId: fighterId ?? this.fighterId,
      currentHp: currentHp ?? this.currentHp,
      maxHp: maxHp ?? this.maxHp,
      gold: gold ?? this.gold,
      floor: floor ?? this.floor,
      currentPathNodeId: currentPathNodeId ?? this.currentPathNodeId,
      visitedNodeIds: visitedNodeIds ?? this.visitedNodeIds,
      relicIds: relicIds ?? this.relicIds,
      cardIds: cardIds ?? this.cardIds,
      gameState: gameState ?? this.gameState,
    );
  }

  bool get isVictory => gameState == 'victory';
  bool get isDefeat => gameState == 'defeat';
  bool get isOngoing => gameState == 'ongoing';

  @override
  String toString() => 'Run[$id] $fighterId HP:$currentHp/$maxHp Gold:$gold Floor:$floor';
}