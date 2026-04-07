// path_manager.dart

/// Gestore del percorso - zero dipendenze, zero warning
class PathManager {
  /// Ottiene i nodi disponibili per il prossimo movimento
  static List<String> getAvailableMoves({
    required String currentNodeId,
    required List<String> visitedNodeIds,
    required List<List<dynamic>> nodes,
  }) {
    // Cerca il nodo corrente
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 0 && node[0] == currentNodeId) {
        // Estrai connessioni (posizione 3)
        if (node.length > 3 && node[3] is List) {
          final connections = node[3] as List;
          final available = <String>[];
          for (var j = 0; j < connections.length; j++) {
            final conn = connections[j];
            if (conn is String && !visitedNodeIds.contains(conn)) {
              available.add(conn);
            }
          }
          return available;
        }
        return [];
      }
    }
    return [];
  }

  /// Muove il giocatore verso un nodo adiacente
  static List<dynamic> moveToNode({
    required String currentNodeId,
    required List<String> visitedNodeIds,
    required List<List<dynamic>> nodes,
    required String targetNodeId,
  }) {
    final available = getAvailableMoves(
      currentNodeId: currentNodeId,
      visitedNodeIds: visitedNodeIds,
      nodes: nodes,
    );
    
    if (!available.contains(targetNodeId)) {
      return [currentNodeId, visitedNodeIds, false];
    }
    
    // Crea nuova lista visitati
    final newVisited = List<String>.from(visitedNodeIds);
    newVisited.add(targetNodeId);
    
    return [targetNodeId, newVisited, true];
  }

  /// Verifica se il nodo corrente è il boss
  static bool isBossNode({
    required String nodeId,
    required List<List<dynamic>> nodes,
  }) {
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 1 && node[0] == nodeId && node[1] == 'boss') {
        return true;
      }
    }
    return false;
  }

  /// Verifica se il livello è completato (boss visitato)
  static bool isLevelCompleted({
    required List<String> visitedNodeIds,
    required List<List<dynamic>> nodes,
  }) {
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

  /// Inizializza un nuovo percorso (nodo primo piano)
  static List<dynamic> initializePath({
    required List<List<dynamic>> nodes,
  }) {
    // Trova primo nodo con piano = 0 (posizione 2)
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.length > 2 && node[2] is int && node[2] == 0 && node[0] is String) {
        return [node[0] as String, <String>[], true];
      }
    }
    
    // Fallback: primo nodo della lista
    if (nodes.isNotEmpty && nodes[0].length > 0 && nodes[0][0] is String) {
      return [nodes[0][0] as String, <String>[], true];
    }
    
    return ['', <String>[], false];
  }
}