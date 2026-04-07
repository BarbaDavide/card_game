// run_generator.dart

/// Generatore di run - zero dipendenze, zero errori
class RunGenerator {
  /// Genera una nuova run con stato iniziale completo
  static List<dynamic> generateRun({
    required String fighterType, // 'ironclad', 'silent', 'defect', 'watcher'
    required List<List<dynamic>> nodes, // Mappa generata da path_generator
    int seed = 0,
  }) {
    // 1. Imposta HP iniziale in base al personaggio
    int maxHp;
    switch (fighterType) {
      case 'ironclad':
        maxHp = 80;
        break;
      case 'silent':
        maxHp = 70;
        break;
      case 'defect':
        maxHp = 75;
        break;
      case 'watcher':
        maxHp = 72;
        break;
      default:
        maxHp = 75; // Default
    }
    
    // 2. Crea mazzo iniziale in base al personaggio
    final startingDeck = _getStartingDeck(fighterType);
    
    // 3. Inizializza percorso
    final pathInit = _initializePath(nodes);
    final currentNodeId = pathInit[0] as String;
    final visitedNodeIds = pathInit[1] as List<String>;
    
    // 4. Stato iniziale completo
    return [
      fighterType,          // [0] tipo personaggio
      maxHp,                // [1] HP massimi
      maxHp,                // [2] HP correnti
      3,                    // [3] mana massimo
      3,                    // [4] mana corrente
      99,                   // [5] oro iniziale
      1,                    // [6] piano corrente (floor)
      currentNodeId,        // [7] ID nodo corrente
      visitedNodeIds,       // [8] nodi visitati
      startingDeck,         // [9] mazzo iniziale (lista ID carte)
      <String>[],           // [10] reliquie
      'ongoing',            // [11] stato run ('ongoing', 'victory', 'defeat')
      seed,                 // [12] seed per determinismo
    ];
  }
  
  /// Ottiene il mazzo iniziale per un personaggio
  static List<String> _getStartingDeck(String fighterType) {
    switch (fighterType) {
      case 'ironclad':
        return [
          'strike', 'strike', 'strike', 'strike', 'strike',
          'defend', 'defend', 'defend', 'defend',
          'bash'
        ];
      case 'silent':
        return [
          'strike', 'strike', 'strike', 'strike', 'strike',
          'defend', 'defend', 'defend', 'defend', 'defend',
          'neutralize'
        ];
      case 'defect':
        return [
          'strike', 'strike', 'strike', 'strike',
          'defend', 'defend', 'defend', 'defend',
          'zap'
        ];
      case 'watcher':
        return [
          'strike', 'strike', 'strike', 'strike',
          'defend', 'defend', 'defend', 'defend',
          'vigilance'
        ];
      default:
        return [
          'strike', 'strike', 'strike', 'strike', 'strike',
          'defend', 'defend', 'defend', 'defend',
          'bash'
        ];
    }
  }
  
  /// Inizializza il percorso (nodo primo piano)
  static List<dynamic> _initializePath(List<List<dynamic>> nodes) {
    // Trova primo nodo con piano = 0 (posizione 2)
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 2 && node[2] is int && node[2] == 0 && node[0] is String) {
        return [node[0] as String, <String>[]];
      }
    }
    
    // Fallback: primo nodo della lista
    if (nodes.isNotEmpty && nodes[0].length > 0 && nodes[0][0] is String) {
      return [nodes[0][0] as String, <String>[]];
    }
    
    return ['start_node', <String>[]];
  }
  
  /// Verifica se la run è completata (boss sconfitto)
  static bool isRunCompleted(List<dynamic> runState) {
    final nodes = runState[13] as List<List<dynamic>>? ?? []; // Nota: nodes non incluso nello stato sopra
    
    // Estrai nodi visitati (posizione 8)
    final visitedNodeIds = runState[8] as List<String>;
    
    // Cerca nodo boss nei nodi visitati
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 1 && node[1] == 'boss' && node[0] is String) {
        if (visitedNodeIds.contains(node[0] as String)) {
          return true;
        }
      }
    }
    return false;
  }
  
  /// Ottiene il tipo di nodo corrente
  static String getCurrentNodeType(List<dynamic> runState, List<List<dynamic>> nodes) {
    final currentNodeId = runState[7] as String;
    
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 1 && node[0] == currentNodeId) {
        return node[1] as String;
      }
    }
    return 'empty';
  }
}