import 'node.dart';

class PathRules {
  final String id;
  final int totalFloors;
  final int maxChoicesPerNode;
  
  // Pesi relativi per la distribuzione casuale dei tipi di nodo
  // (valori più alti = maggiore probabilità di apparizione)
  final int combatWeight;
  final int eliteWeight;
  final int merchantWeight;
  final int restSiteWeight;
  final int treasureWeight;
  final int eventWeight;

  const PathRules({
    required this.id,
    required this.totalFloors,
    this.maxChoicesPerNode = 3,
    this.combatWeight = 70,
    this.eliteWeight = 10,
    this.merchantWeight = 5,
    this.restSiteWeight = 10,
    this.treasureWeight = 3,
    this.eventWeight = 2,
  });

  // Preset predefiniti per gli atti standard
  static const act1 = PathRules(
    id: 'act1',
    totalFloors: 15,
    maxChoicesPerNode: 3,
    combatWeight: 70,
    eliteWeight: 8,
    merchantWeight: 5,
    restSiteWeight: 12,
    treasureWeight: 3,
    eventWeight: 2,
  );

  static const act2 = PathRules(
    id: 'act2',
    totalFloors: 16,
    maxChoicesPerNode: 3,
    combatWeight: 65,
    eliteWeight: 12,
    merchantWeight: 4,
    restSiteWeight: 10,
    treasureWeight: 5,
    eventWeight: 4,
  );

  static const act3 = PathRules(
    id: 'act3',
    totalFloors: 17,
    maxChoicesPerNode: 3,
    combatWeight: 60,
    eliteWeight: 15,
    merchantWeight: 3,
    restSiteWeight: 8,
    treasureWeight: 6,
    eventWeight: 8,
  );

  // Calcola il peso totale per calcoli probabilistici
  int get totalWeight => 
      combatWeight + 
      eliteWeight + 
      merchantWeight + 
      restSiteWeight + 
      treasureWeight + 
      eventWeight;

  // Ottiene il peso per un tipo di nodo specifico
  int weightForType(NodeType type) {
    switch (type) {
      case NodeType.combat: return combatWeight;
      case NodeType.elite: return eliteWeight;
      case NodeType.merchant: return merchantWeight;
      case NodeType.restSite: return restSiteWeight;
      case NodeType.treasure: return treasureWeight;
      case NodeType.event: return eventWeight;
      case NodeType.boss:
      case NodeType.bossChest:
      case NodeType.empty:
        return 0; // Questi tipi sono posizionati manualmente, non casualmente
    }
  }
}