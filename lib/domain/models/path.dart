import 'node.dart';

class Path {
  final String id;
  final List<Node> nodes;
  final String startNodeId;
  final String? currentNodeId;
  final Set<String> visitedNodeIds;

  const Path({
    required this.id,
    required this.nodes,
    required this.startNodeId,
    this.currentNodeId,
    this.visitedNodeIds = const {},
  });

  // Ottiene il nodo corrente (null se non iniziato o non trovato)
  Node? get currentNode {
    if (currentNodeId == null) return null;
    for (final node in nodes) {
      if (node.id == currentNodeId) return node;
    }
    return null;
  }

  // Restituisce i nodi adiacenti disponibili dal nodo corrente
  List<Node> getAvailableNextNodes() {
    // Se non si è ancora iniziato, restituisci solo il nodo di partenza (se non visitato)
    if (currentNodeId == null) {
      final startNode = getNodeById(startNodeId);
      if (startNode != null && !visitedNodeIds.contains(startNodeId)) {
        return [startNode];
      }
      return [];
    }

    // currentNodeId è garantito non null qui grazie al check sopra
    final currentNode = getNodeById(currentNodeId!);
    if (currentNode == null) return [];

    final available = <Node>[];
    for (final nodeId in currentNode.connectedTo) {
      final nextNode = getNodeById(nodeId);
      if (nextNode != null && !visitedNodeIds.contains(nodeId)) {
        available.add(nextNode);
      }
    }
    return available;
  }

  // Verifica se il giocatore può muoversi verso un nodo specifico
  bool canMoveTo(String nodeId) {
    return getAvailableNextNodes().any((node) => node.id == nodeId);
  }

  // Sposta il giocatore verso un nodo (restituisce una nuova istanza immutabile)
  Path moveTo(String nodeId) {
    if (!canMoveTo(nodeId)) {
      throw ArgumentError('Cannot move to node $nodeId from current position');
    }

    // Crea una nuova lista di nodi con il nodo target marcato come visitato
    final updatedNodes = nodes.map((node) {
      if (node.id == nodeId) {
        return node.copyWith(visited: true);
      }
      return node;
    }).toList(growable: false);

    return Path(
      id: id,
      nodes: updatedNodes,
      startNodeId: startNodeId,
      currentNodeId: nodeId,
      visitedNodeIds: {...visitedNodeIds, nodeId},
    );
  }

  // Ottiene un nodo per ID (null se non trovato)
  Node? getNodeById(String id) {
    for (final node in nodes) {
      if (node.id == id) return node;
    }
    return null;
  }

  // Verifica se il percorso è completato (raggiunto e sconfitto il boss)
  bool get isCompleted {
    for (final node in nodes) {
      if (node.type == NodeType.boss && visitedNodeIds.contains(node.id)) {
        return true;
      }
    }
    return false;
  }

  // Crea una copia con campi modificati
  Path copyWith({
    String? id,
    List<Node>? nodes,
    String? startNodeId,
    String? currentNodeId,
    Set<String>? visitedNodeIds,
  }) {
    return Path(
      id: id ?? this.id,
      nodes: nodes ?? this.nodes,
      startNodeId: startNodeId ?? this.startNodeId,
      currentNodeId: currentNodeId ?? this.currentNodeId,
      visitedNodeIds: visitedNodeIds ?? this.visitedNodeIds,
    );
  }
}