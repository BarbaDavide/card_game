// lib/widgets/path_sector_widget.dart

import 'package:flutter/material.dart';

class PathSectorWidget extends StatelessWidget {
  final int sectorNumber;
  final List<Map<String, dynamic>> nodes;
  final String currentNodeId;
  final List<String> visitedNodeIds;
  final bool isBossSector;
  final bool isCurrentSector;
  final ValueChanged<String>? onNodeTap;

  const PathSectorWidget({
    Key? key,
    required this.sectorNumber,
    required this.nodes,
    required this.currentNodeId,
    required this.visitedNodeIds,
    this.isBossSector = false,
    this.isCurrentSector = false,
    this.onNodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Etichetta settore
        _buildSectorLabel(),
        
        const SizedBox(height: 16),
        
        // Nodi del settore
        _buildNodeRow(),
        
        // Linee di connessione (solo se non è l'ultimo settore)
        if (!isBossSector) ...[
          const SizedBox(height: 16),
          _buildConnectionLines(),
        ],
      ],
    );
  }

  Widget _buildSectorLabel() {
    if (isBossSector) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF4444), Color(0xFFFFAA00)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Text(
          'BOSS SECTOR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
      );
    }
    
    return Text(
      'Sector ${sectorNumber + 1}',
      style: TextStyle(
        color: isCurrentSector ? Colors.blueAccent : Colors.white70,
        fontSize: 16,
        fontWeight: isCurrentSector ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildNodeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(nodes.length, (index) {
        final node = nodes[index];
        final nodeId = node['id'] as String;
        final nodeType = node['type'] as String;
        final isCurrent = nodeId == currentNodeId;
        final isVisited = visitedNodeIds.contains(nodeId);
        final isAvailable = isCurrent || (isVisited && _hasAvailablePaths(nodeId));
        
        return _buildSectorNode(
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

  Widget _buildSectorNode({
    required String nodeId,
    required String nodeType,
    required bool isCurrent,
    required bool isVisited,
    required bool isAvailable,
    required VoidCallback onTap,
  }) {
    final color = _getNodeTypeColor(nodeType);
    final emoji = _getNodeTypeEmoji(nodeType);
    final size = isCurrent ? 64.0 : 52.0;
    
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isVisited
              ? (isCurrent ? color.withOpacity(0.95) : const Color(0xFF282840))
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
                    color: Colors.yellow.withOpacity(0.8),
                    blurRadius: 18,
                    spreadRadius: 3,
                  ),
                ]
              : isAvailable
                  ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.6),
                        blurRadius: 12,
                        spreadRadius: 2,
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
                fontSize: isCurrent ? 32 : 26,
                shadows: isCurrent
                    ? [
                        Shadow(
                          color: Colors.yellow.withOpacity(0.95),
                          blurRadius: 12,
                          offset: Offset.zero,
                        ),
                      ]
                    : null,
              ),
            ),
            if (isVisited && !isCurrent)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 16,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionLines() {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (nodes.length == 1) _buildSingleConnection(),
          if (nodes.length == 2) _buildDoubleConnections(),
          if (nodes.length >= 3) _buildTripleConnections(),
        ],
      ),
    );
  }

  Widget _buildSingleConnection() {
    return Container(
      width: 4,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF555588),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildDoubleConnections() {
    return Row(
      children: [
        Transform.rotate(
          angle: -0.3,
          child: Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF555588),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Transform.rotate(
          angle: 0.3,
          child: Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF555588),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTripleConnections() {
    return Row(
      children: [
        Transform.rotate(
          angle: -0.25,
          child: Container(
            width: 3,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF555588),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 3,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF555588),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 16),
        Transform.rotate(
          angle: 0.25,
          child: Container(
            width: 3,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF555588),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  bool _hasAvailablePaths(String nodeId) {
    // In una vera app, qui controlleresti le connessioni reali
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