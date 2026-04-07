// lib/widgets/node_map_widget.dart

import 'package:flutter/material.dart';

class NodeMapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> nodes;
  final String currentNodeId;
  final List<String> visitedNodeIds;
  final ValueChanged<String>? onNodeTap;

  const NodeMapWidget({
    Key? key,
    required this.nodes,
    required this.currentNodeId,
    required this.visitedNodeIds,
    this.onNodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Raggruppa nodi per piano
    final floors = <int, List<Map<String, dynamic>>>{};
    for (final node in nodes) {
      final floor = node['floor'] as int;
      floors[floor] = floors[floor] ?? [];
      floors[floor]!.add(node);
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A5A), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.map, color: Colors.purple, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Map Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_getCurrentFloor() + 1}/15',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Mappa dei nodi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: floors.length,
              itemBuilder: (context, index) {
                final floorNodes = floors[index]!;
                return _buildFloorRow(index, floorNodes);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorRow(int floor, List<Map<String, dynamic>> nodes) {
    final isCurrentFloor = floor == _getCurrentFloor();
    final isBossFloor = floor == 14;
    
    return Column(
      children: [
        // Etichetta piano
        if (isBossFloor)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.25),
              border: Border.all(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'BOSS',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          )
        else
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Floor ${floor + 1}',
              style: TextStyle(
                color: isCurrentFloor ? Colors.amber : Colors.white70,
                fontSize: 14,
                fontWeight: isCurrentFloor ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        
        // Nodi del piano
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(nodes.length, (index) {
            final node = nodes[index];
            final nodeId = node['id'] as String;
            final nodeType = node['type'] as String;
            final isCurrent = nodeId == currentNodeId;
            final isVisited = visitedNodeIds.contains(nodeId);
            final isAvailable = isCurrent || (isVisited && _hasAvailableChildren(nodeId));
            
            return _buildNode(
              nodeId: nodeId,
              nodeType: nodeType,
              isCurrent: isCurrent,
              isVisited: isVisited,
              isAvailable: isAvailable,
              onTap: () => onNodeTap?.call(nodeId),
            );
          }),
        ),
        
        // Linee di connessione al piano successivo
        if (floor < 14) ...[
          const SizedBox(height: 16),
          _buildConnectionLine(nodeCount: nodes.length),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildNode({
    required String nodeId,
    required String nodeType,
    required bool isCurrent,
    required bool isVisited,
    required bool isAvailable,
    required VoidCallback onTap,
  }) {
    final color = _getNodeTypeColor(nodeType);
    final emoji = _getNodeTypeEmoji(nodeType);
    final size = isCurrent ? 56.0 : 48.0;
    
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isVisited 
              ? (isCurrent ? color.withOpacity(0.9) : Colors.grey[800]!) 
              : const Color(0xFF252540),
          border: Border.all(
            color: isCurrent
                ? Colors.yellow
                : isAvailable
                    ? Colors.blue
                    : isVisited
                        ? Colors.grey
                        : color.withOpacity(0.5),
            width: isCurrent ? 3 : isAvailable ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : isAvailable
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 8,
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
                fontSize: isCurrent ? 28 : 24,
                shadows: isCurrent
                    ? [
                        Shadow(
                          color: Colors.yellow.withOpacity(0.8),
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ]
                    : null,
              ),
            ),
            if (isVisited && !isCurrent) ...[
              const SizedBox(height: 2),
              Container(
                width: 10,
                height: 2,
                color: Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionLine({required int nodeCount}) {
    return SizedBox(
      height: 30,
      child: CustomPaint(
        painter: _ConnectionPainter(nodeCount: nodeCount),
      ),
    );
  }

  int _getCurrentFloor() {
    final currentNode = nodes.firstWhere(
      (node) => node['id'] == currentNodeId,
      orElse: () => nodes.first,
    );
    return currentNode['floor'] as int;
  }

  bool _hasAvailableChildren(String nodeId) {
    // In una vera app, qui controlleresti le connessioni
    // Per ora simuliamo che i nodi visitati abbiano sempre figli disponibili
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

// Painter per le linee di connessione
class _ConnectionPainter extends CustomPainter {
  final int nodeCount;

  _ConnectionPainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A4A6A)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final centerX = size.width / 2;
    final startY = 0.0;
    final endY = size.height;
    
    if (nodeCount == 1) {
      // Linea singola centrale
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX, endY),
        paint,
      );
    } else if (nodeCount == 2) {
      // Due linee a V
      final spacing = size.width * 0.25;
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX - spacing, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX + spacing, endY),
        paint,
      );
    } else if (nodeCount >= 3) {
      // Tre linee (centrale + due laterali)
      final spacing = size.width * 0.2;
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX - spacing, endY),
        paint,
      );
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX + spacing, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}