// lib/widgets/path_map_widget.dart

import 'package:flutter/material.dart';

class PathMapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> nodes;
  final String currentNodeId;
  final List<String> visitedNodeIds;
  final ValueChanged<String>? onNodeTap;

  const PathMapWidget({
    Key? key,
    required this.nodes,
    required this.currentNodeId,
    required this.visitedNodeIds,
    this.onNodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Raggruppa nodi per piano (floor)
    final floors = <int, List<Map<String, dynamic>>>{};
    for (final node in nodes) {
      final floor = node['floor'] as int;
      floors[floor] = floors[floor] ?? [];
      floors[floor]!.add(node);
    }

    // Ordina i piani in ordine crescente
    final sortedFloors = floors.keys.toList()..sort();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333355), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con progresso
          _buildHeader(sortedFloors.length),
          
          // Legenda tipi nodo
          _buildLegend(),
          
          // Mappa percorso
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: sortedFloors.length,
              itemBuilder: (context, index) {
                final floorNum = sortedFloors[index];
                final floorNodes = floors[floorNum]!;
                final isLastFloor = index == sortedFloors.length - 1;
                return _buildFloorSection(
                  floorNum: floorNum,
                  nodes: floorNodes,
                  isLastFloor: isLastFloor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int totalFloors) {
    final currentFloor = _getCurrentFloor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF181828),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Icon(Icons.route, color: Colors.blueAccent, size: 24),
          const SizedBox(width: 12),
          Text(
            'Current Path',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D44),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.blueAccent, width: 1.5),
            ),
            child: Text(
              '${currentFloor + 1}/$totalFloors',
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF151525),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          _buildLegendItem('⚔️', 'Combat', Colors.red),
          _buildLegendItem('💀', 'Elite', Colors.purple),
          _buildLegendItem('🏪', 'Merchant', Colors.amber),
          _buildLegendItem('🔥', 'Rest Site', Colors.green),
          _buildLegendItem('🏆', 'Boss', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String emoji, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 14)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildFloorSection({
    required int floorNum,
    required List<Map<String, dynamic>> nodes,
    required bool isLastFloor,
  }) {
    final isBossFloor = floorNum == 14; // Ultimo piano = boss
    
    return Column(
      children: [
        // Etichetta piano
        if (isBossFloor)
          _buildBossBadge()
        else
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'Floor ${floorNum + 1}',
              style: TextStyle(
                color: floorNum == _getCurrentFloor() 
                    ? Colors.blueAccent 
                    : Colors.white70,
                fontSize: 15,
                fontWeight: floorNum == _getCurrentFloor() 
                    ? FontWeight.bold 
                    : FontWeight.normal,
              ),
            ),
          ),
        
        const SizedBox(height: 12),
        
        // Nodi del piano
        _buildNodeRow(floorNum, nodes),
        
        // Linee di connessione al piano successivo (solo se non è l'ultimo)
        if (!isLastFloor) ...[
          const SizedBox(height: 16),
          _buildConnectionLines(nodes.length),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildBossBadge() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: const Text(
        'BOSS FLOOR',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildNodeRow(int floorNum, List<Map<String, dynamic>> nodes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(nodes.length, (index) {
        final node = nodes[index];
        final nodeId = node['id'] as String;
        final nodeType = node['type'] as String;
        final isCurrent = nodeId == currentNodeId;
        final isVisited = visitedNodeIds.contains(nodeId);
        final isAvailable = isCurrent || (isVisited && _hasAvailablePaths(nodeId));
        
        return _buildPathNode(
          nodeId: nodeId,
          nodeType: nodeType,
          isCurrent: isCurrent,
          isVisited: isVisited,
          isAvailable: isAvailable,
          onTap: () => onNodeTap?.call(nodeId),
        );
      }),
    );
  }

  Widget _buildPathNode({
    required String nodeId,
    required String nodeType,
    required bool isCurrent,
    required bool isVisited,
    required bool isAvailable,
    required VoidCallback onTap,
  }) {
    final color = _getNodeTypeColor(nodeType);
    final emoji = _getNodeTypeEmoji(nodeType);
    final size = isCurrent ? 60.0 : 50.0;
    
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isVisited
              ? (isCurrent ? color.withOpacity(0.95) : const Color(0xFF25253D))
              : const Color(0xFF1A1A2E),
          border: Border.all(
            color: isCurrent
                ? Colors.yellow
                : isAvailable
                    ? Colors.blueAccent
                    : isVisited
                        ? Colors.grey
                        : color.withOpacity(0.4),
            width: isCurrent ? 3 : isAvailable ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.7),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : isAvailable
                  ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: isCurrent ? 30 : 24,
                shadows: isCurrent
                    ? [
                        Shadow(
                          color: Colors.yellow.withOpacity(0.9),
                          blurRadius: 10,
                          offset: Offset.zero,
                        ),
                      ]
                    : null,
              ),
            ),
            if (isVisited && !isCurrent)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 14,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionLines(int nodeCount) {
    return SizedBox(
      height: 40,
      child: CustomPaint(
        painter: _PathConnectionPainter(nodeCount: nodeCount),
      ),
    );
  }

  int _getCurrentFloor() {
    final currentNode = nodes.firstWhere(
      (node) => node['id'] == currentNodeId,
      orElse: () => nodes.isNotEmpty ? nodes.first : {'floor': 0},
    );
    return currentNode['floor'] as int;
  }

  bool _hasAvailablePaths(String nodeId) {
    // In una vera app, qui controlleresti le connessioni reali
    // Per ora simuliamo che i nodi visitati abbiano sempre percorsi successivi
    return visitedNodeIds.contains(nodeId);
  }

  Color _getNodeTypeColor(String type) {
    switch (type) {
      case 'combat': return Colors.red;
      case 'elite': return Colors.purple;
      case 'merchant': return Colors.amber;
      case 'rest': return Colors.green;
      case 'boss': return Colors.orange;
      default: return Colors.grey;
    }
  }

  String _getNodeTypeEmoji(String type) {
    switch (type) {
      case 'combat': return '⚔️';
      case 'elite': return '💀';
      case 'merchant': return '🏪';
      case 'rest': return '🔥';
      case 'boss': return '🏆';
      default: return '❓';
    }
  }
}

// CustomPainter per le linee di connessione tra piani
class _PathConnectionPainter extends CustomPainter {
  final int nodeCount;

  _PathConnectionPainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF555588)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final centerX = size.width / 2;
    final startY = 0.0;
    final endY = size.height;
    
    if (nodeCount == 1) {
      // Singolo nodo: linea verticale centrale
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX, endY),
        paint,
      );
    } else if (nodeCount == 2) {
      // Due nodi: linee a V
      final spacing = size.width * 0.3;
      canvas.drawLine(
        Offset(centerX - spacing / 2, startY),
        Offset(centerX - spacing, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX + spacing / 2, startY),
        Offset(centerX + spacing, endY),
        paint,
      );
    } else if (nodeCount >= 3) {
      // Tre nodi: linea centrale + due diagonali
      final spacing = size.width * 0.25;
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX - spacing, startY),
        Offset(centerX - spacing * 1.5, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX + spacing, startY),
        Offset(centerX + spacing * 1.5, endY),
        paint,
      );
    }
    
    // Aggiungi frecce direzionali
    _drawArrowheads(canvas, size, paint);
  }

  void _drawArrowheads(Canvas canvas, Size size, Paint paint) {
    final centerX = size.width / 2;
    final arrowSize = 8.0;
    final arrowY = size.height * 0.7;
    
    // Frecce singole o multiple a seconda del numero di nodi
    if (nodeCount == 1) {
      _drawArrow(canvas, centerX, arrowY, arrowSize, paint);
    } else if (nodeCount == 2) {
      final spacing = size.width * 0.25;
      _drawArrow(canvas, centerX - spacing, arrowY, arrowSize, paint);
      _drawArrow(canvas, centerX + spacing, arrowY, arrowSize, paint);
    } else {
      final spacing = size.width * 0.2;
      _drawArrow(canvas, centerX - spacing, arrowY, arrowSize, paint);
      _drawArrow(canvas, centerX, arrowY, arrowSize, paint);
      _drawArrow(canvas, centerX + spacing, arrowY, arrowSize, paint);
    }
  }

  void _drawArrow(Canvas canvas, double x, double y, double size, Paint paint) {
    final path = Path();
    path.moveTo(x, y - size);
    path.lineTo(x - size * 0.6, y + size * 0.5);
    path.lineTo(x + size * 0.6, y + size * 0.5);
    path.close();
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}