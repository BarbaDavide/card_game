enum NodeType {
  combat,
  elite,
  merchant,
  restSite,
  treasure,
  boss,
  event,
  bossChest,
  empty,
}

class Node {
  final String id;
  final NodeType type;
  final int row;
  final int column;
  final bool visited;
  final List<String> connectedTo;
  final String? encounterId;
  final Map<String, dynamic>? metadata;

  const Node({
    required this.id,
    required this.type,
    required this.row,
    required this.column,
    this.visited = false,
    this.connectedTo = const [],
    this.encounterId,
    this.metadata,
  });

  bool get isCleared => visited && type != NodeType.boss && type != NodeType.bossChest;
  bool get isBoss => type == NodeType.boss;
  bool get isRestSite => type == NodeType.restSite;
  bool get isMerchant => type == NodeType.merchant;

  @override
  String toString() => 'Node[$type] @ ($row,$column) ${visited ? "(visited)" : ""}';

  Node copyWith({
    bool? visited,
    List<String>? connectedTo,
    Map<String, dynamic>? metadata,
  }) {
    return Node(
      id: id,
      type: type,
      row: row,
      column: column,
      visited: visited ?? this.visited,
      connectedTo: connectedTo ?? this.connectedTo,
      encounterId: encounterId,
      metadata: metadata ?? this.metadata,
    );
  }
}

// CORREZIONE FONDAMENTALE: uso di ${} per delimitare le variabili nell'interpolazione
String generateNodeId(int row, int column) => 'node_${row}_${column}';