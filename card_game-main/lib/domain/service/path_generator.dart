// path_generator.dart

/// Generatore di percorsi procedurali - zero dipendenze, solo tipi base Dart
class PathGenerator {
  /// Genera una mappa con regole simili a Slay the Spire
  /// Restituisce una lista di definizioni di nodi: [id, tipo, piano, colonna, [id_connessioni]]
  static List<List<dynamic>> generate({
    int totalFloors = 15,
    int seed = 42,
  }) {
    // RNG semplice e deterministico (Linear Congruential Generator)
    int rngState = seed;
    int nextInt(int max) {
      rngState = (rngState * 1103515245 + 12345) & 0x7fffffff;
      return rngState % max;
    }

    final nodes = <List<dynamic>>[];

    // Genera nodi per ogni piano
    for (var floor = 0; floor < totalFloors; floor++) {
      List<String> nodeTypes;

      if (floor == 0) {
        // Piano iniziale: sempre 1 nodo combat
        nodeTypes = ['combat'];
      } else if (floor == totalFloors - 1) {
        // Piano boss: sempre 1 nodo boss
        nodeTypes = ['boss'];
      } else if (floor == 3 || floor == 8) {
        // Piani mercante/riposo (alternati)
        nodeTypes = nextInt(2) == 0 ? ['merchant', 'rest'] : ['rest', 'merchant'];
      } else if (floor == 5 || floor == 10) {
        // Piani elite garantiti (con nodi combat aggiuntivi)
        nodeTypes = ['elite', 'combat', 'combat'];
      } else if (floor == 2 || floor == 6 || floor == 9) {
        // Piani riposo extra
        nodeTypes = ['rest', 'combat'];
      } else {
        // Piani normali: 2-3 nodi combat
        final count = nextInt(2) + 2; // 2 o 3
        nodeTypes = List.filled(count, 'combat');
      }

      // Crea i nodi per questo piano
      for (var col = 0; col < nodeTypes.length; col++) {
        nodes.add([
          'node_${floor}_$col', // id
          nodeTypes[col],       // tipo
          floor,                // piano
          col,                  // colonna
          <String>[]            // connessioni (riempite dopo)
        ]);
      }
    }

    // Collega i nodi tra piani adiacenti
    for (var floor = 0; floor < totalFloors - 1; floor++) {
      final currentNodes = nodes.where((n) => n[2] == floor).toList();
      final nextNodes = nodes.where((n) => n[2] == floor + 1).toList();

      for (var currentNode in currentNodes) {
        final connections = currentNode[4] as List<String>;
        final maxConnections = nextNodes.length > 1 ? 2 : 1;
        final connectionCount = nextInt(maxConnections) + 1;

        // Scegli nodi casuali dal piano successivo
        final availableIndices = List<int>.generate(nextNodes.length, (i) => i);
        for (var c = 0; c < connectionCount && availableIndices.isNotEmpty; c++) {
          final targetIndex = nextInt(availableIndices.length);
          final targetNode = nextNodes[availableIndices[targetIndex]];
          connections.add(targetNode[0] as String); // Aggiungi ID del nodo target
          availableIndices.removeAt(targetIndex);
        }
      }
    }

    return nodes;
  }

  /// Verifica che esista almeno un percorso valido dallo start al boss
  static bool hasValidPath(List<List<dynamic>> nodes) {
    if (nodes.isEmpty) return false;

    final startNode = nodes.firstWhere((n) => n[2] == 0); // Primo piano
    final bossNode = nodes.lastWhere((n) => n[1] == 'boss'); // Nodo boss

    // BFS semplice per verificare raggiungibilità
    final visited = <String>{};
    final queue = <String>[startNode[0] as String];

    while (queue.isNotEmpty) {
      final currentId = queue.removeAt(0);
      if (visited.contains(currentId)) continue;
      visited.add(currentId);

      if (currentId == bossNode[0]) return true;

      final currentNode = nodes.firstWhere((n) => n[0] == currentId);
      final connections = currentNode[4] as List<String>;
      for (final connId in connections) {
        if (!visited.contains(connId)) {
          queue.add(connId);
        }
      }
    }

    return false;
  }
}