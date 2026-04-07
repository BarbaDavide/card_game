// path_node.dart

class PathNode {
  final String nodeId; // Riferimento all'ID del Node statico (da node.dart)
  final bool isVisited;
  final bool isCurrent;
  final bool isCleared;

  PathNode({
    required this.nodeId,
    this.isVisited = false,
    this.isCurrent = false,
    this.isCleared = false,
  });

  // Crea una copia con campi modificati (pattern immutabile)
  PathNode copyWith({
    bool? isVisited,
    bool? isCurrent,
    bool? isCleared,
  }) {
    return PathNode(
      nodeId: nodeId,
      isVisited: isVisited ?? this.isVisited,
      isCurrent: isCurrent ?? this.isCurrent,
      isCleared: isCleared ?? this.isCleared,
    );
  }

  @override
  String toString() => 'PathNode[$nodeId] ${isCurrent ? "(current)" : ""} ${isCleared ? "(cleared)" : ""}';
}