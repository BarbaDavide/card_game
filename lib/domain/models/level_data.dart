import 'node.dart';

enum LevelTheme {
  city,
  forest,
  caves,
  spire,
  voids,
}

class LevelData {
  final String id; // Es. "act1", "act2", "act3"
  final String name;
  final String description;
  final LevelTheme theme;
  final int maxFloors;
  final List<Node> nodes; // Template iniziale (tutti i nodi con visited = false)
  final String bossId; // ID del nodo boss (deve esistere in nodes)

  LevelData({
    required this.id,
    required this.name,
    required this.description,
    required this.theme,
    required this.maxFloors,
    required this.nodes,
    required this.bossId,
  }) {
    // Validazione runtime (non in costruttore const)
    if (!nodes.any((node) => node.id == bossId && node.type == NodeType.boss)) {
      throw ArgumentError('Boss node with ID "$bossId" must exist in nodes and be of type NodeType.boss');
    }
  }

  // Verifica che la struttura del grafo sia valida (tutti i connectedTo puntano a nodi esistenti)
  bool get isValid {
    for (final node in nodes) {
      for (final connectedId in node.connectedTo) {
        if (!nodes.any((n) => n.id == connectedId)) {
          return false;
        }
      }
    }
    return nodes.any((node) => node.id == bossId && node.type == NodeType.boss);
  }

  // Ottiene tutti i nodi di un certo tipo (es. tutti i combattimenti)
  List<Node> getNodesByType(NodeType type) {
    return nodes.where((node) => node.type == type).toList();
  }

  // Crea una copia con nodi resettati a stato iniziale (visited = false)
  LevelData resetVisited() {
    return LevelData(
      id: id,
      name: name,
      description: description,
      theme: theme,
      maxFloors: maxFloors,
      nodes: nodes.map((node) => node.copyWith(visited: false)).toList(growable: false),
      bossId: bossId,
    );
  }

  // Crea una copia con campi modificati (pattern immutabile)
  LevelData copyWith({
    String? id,
    String? name,
    String? description,
    LevelTheme? theme,
    int? maxFloors,
    List<Node>? nodes,
    String? bossId,
  }) {
    return LevelData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      theme: theme ?? this.theme,
      maxFloors: maxFloors ?? this.maxFloors,
      nodes: nodes ?? this.nodes,
      bossId: bossId ?? this.bossId,
    );
  }
}