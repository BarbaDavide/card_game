// lib/ui/screen/map_screen.dart

import 'package:flutter/material.dart';
import 'dart:math';

// ===== DATI MAPPA INTEGRATI (NESSUNA DIPENDENZA ESTERNA) =====
class _MapNode {
  final String id;
  final String type; // 'political_debate', 'lobby_meeting', 'town_hall', 'powerful_politician', 'boss'
  final int floor;
  final List<String> connections;
  final String displayName;
  final String description;
  final bool isElite;
  final bool isBoss;

  _MapNode({
    required this.id,
    required this.type,
    required this.floor,
    required this.connections,
    required this.displayName,
    required this.description,
    this.isElite = false,
    this.isBoss = false,
  });
}

// Generatore di mappe satiriche integrate
List<_MapNode> _generatePoliticalArena() {
  return [
    _MapNode(id: 'node_0', type: 'political_debate', floor: 0, connections: ['node_1', 'node_2'], displayName: 'Campaign Rally', description: 'Kick off your political journey'),
    _MapNode(id: 'node_1', type: 'political_debate', floor: 1, connections: ['node_3'], displayName: 'TV Debate', description: 'Face your opponent on primetime TV'),
    _MapNode(id: 'node_2', type: 'political_debate', floor: 1, connections: ['node_3'], displayName: 'Social Media War', description: 'Battle in the digital trenches'),
    _MapNode(id: 'node_3', type: 'town_hall', floor: 2, connections: ['node_4'], displayName: 'Town Hall Meeting', description: 'Recover influence with voters'),
    _MapNode(id: 'node_4', type: 'lobby_meeting', floor: 3, connections: ['node_5', 'node_6'], displayName: 'Arms Dealer Dinner', description: 'Buy political favors and cards'),
    _MapNode(id: 'node_5', type: 'political_debate', floor: 4, connections: ['node_7'], displayName: 'Border Security Debate', description: 'Clash over immigration policy'),
    _MapNode(id: 'node_6', type: 'political_debate', floor: 4, connections: ['node_7'], displayName: 'Tax Reform Battle', description: 'Fight over fiscal policies'),
    _MapNode(id: 'node_7', type: 'powerful_politician', floor: 5, connections: ['node_8'], displayName: 'Elon Musk', description: 'Tech billionaire with Twitter army', isElite: true),
    _MapNode(id: 'node_8', type: 'town_hall', floor: 6, connections: ['node_9', 'node_10'], displayName: 'Press Conference', description: 'Regroup after elite battle'),
    _MapNode(id: 'node_9', type: 'political_debate', floor: 7, connections: ['node_11'], displayName: 'Climate Change Debate', description: 'Battle over environmental policies'),
    _MapNode(id: 'node_10', type: 'political_debate', floor: 7, connections: ['node_11'], displayName: 'Healthcare Showdown', description: 'Fight over medical system reform'),
    _MapNode(id: 'node_11', type: 'lobby_meeting', floor: 8, connections: ['node_12'], displayName: 'Silicon Valley Summit', description: 'Buy data manipulation tools'),
    _MapNode(id: 'node_12', type: 'town_hall', floor: 9, connections: ['node_13'], displayName: 'Congressional Hearing', description: 'Prepare for next challenge'),
    _MapNode(id: 'node_13', type: 'powerful_politician', floor: 10, connections: ['node_14'], displayName: 'Bill Gates', description: 'Philanthropist with global health influence', isElite: true),
    _MapNode(id: 'node_14', type: 'political_debate', floor: 11, connections: ['node_15'], displayName: 'Foreign Policy Debate', description: 'Clash over international relations'),
    _MapNode(id: 'node_15', type: 'political_debate', floor: 12, connections: ['node_16'], displayName: 'Election Integrity', description: 'Final debate before boss'),
    _MapNode(id: 'node_16', type: 'political_debate', floor: 13, connections: ['node_17'], displayName: 'Media Circus', description: 'Navigate sensationalist coverage'),
    _MapNode(id: 'node_17', type: 'boss', floor: 14, connections: [], displayName: 'DonaldTrump', description: 'The unpredictable leader who dominates media cycles', isBoss: true),
  ];
}

class MapScreen extends StatefulWidget {
  final String actName;
  final int currentAct;

  const MapScreen({
    Key? key,
    this.actName = 'The Political Arena',
    this.currentAct = 0,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<_MapNode> _nodes;
  String _currentNodeId = 'node_0';
  List<String> _visitedNodeIds = [];
  int _currentFloor = 0;
  bool _isBattleActive = false;

  @override
  void initState() {
    super.initState();
    _nodes = _generatePoliticalArena();
    _updateCurrentFloor();
  }

  void _updateCurrentFloor() {
    final currentNode = _getNodeById(_currentNodeId);
    setState(() {
      _currentFloor = currentNode.floor;
    });
  }

  _MapNode _getNodeById(String id) {
    return _nodes.firstWhere((node) => node.id == id, orElse: () => _nodes[0]);
  }

  List<_MapNode> _getAvailableNodes() {
    final currentNode = _getNodeById(_currentNodeId);
    return _nodes
        .where((node) => currentNode.connections.contains(node.id))
        .where((node) => !_visitedNodeIds.contains(node.id))
        .toList();
  }

  void _navigateToNode(String nodeId) {
    if (_isBattleActive) return;
    
    setState(() {
      _visitedNodeIds.add(_currentNodeId);
      _currentNodeId = nodeId;
      _updateCurrentFloor();
    });

    final node = _getNodeById(nodeId);
    
    if (node.type == 'political_debate' || 
        node.type == 'powerful_politician' || 
        node.type == 'boss') {
      _startBattle(node);
    } 
    else if (node.type == 'lobby_meeting') {
      _showMerchant(node);
    } 
    else if (node.type == 'town_hall') {
      _showRestSite(node);
    }
  }

  void _startBattle(_MapNode node) {
    setState(() => _isBattleActive = true);
    
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFF1A1A2A),
          title: Row(
            children: [
              // CORRETTO: sostituito Icons.swords con Icons.account_balance (disponibile in tutte le versioni)
              Icon(
                node.isBoss 
                    ? Icons.emoji_events 
                    : node.isElite 
                        ? Icons.star 
                        : Icons.account_balance, // ✅ SICURO - disponibile da Flutter 1.0
                color: node.isBoss ? Colors.red : node.isElite ? Colors.purple : Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                node.isBoss ? 'BOSS BATTLE' : node.isElite ? 'ELITE BATTLE' : 'POLITICAL DEBATE',
                style: TextStyle(
                  color: node.isBoss ? Colors.red : node.isElite ? Colors.purple : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You defeated ${node.displayName}!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                node.description,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRewardChip('🃏 Common Card', Colors.blue),
                  _buildRewardChip('💶 50€', Colors.amber),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _isBattleActive = false);
                if (node.isBoss) {
                  _completeAct();
                }
              },
              child: Text(
                node.isBoss ? 'COMPLETE ACT' : 'CONTINUE',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showMerchant(_MapNode node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A2A),
        title: Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.amber), // ✅ SICURO - disponibile ovunque
            SizedBox(width: 8),
            Text('LOBBYIST MEETING', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Purchase political favors:', style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            _buildMerchantOption('Remove a card', 'Pay 75€ to remove a card from your deck', Colors.red),
            _buildMerchantOption('Upgrade a card', 'Pay 150€ to upgrade a card', Colors.blue),
            _buildMerchantOption('Buy a relic', 'Pay 200€ for a political perk', Colors.purple),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('LEAVE', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _showRestSite(_MapNode node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A2A),
        title: Row(
          children: [
            Icon(Icons.favorite, color: Colors.green), // ✅ SICURO - disponibile ovunque (sostituito local_hospital)
            SizedBox(width: 8),
            Text('TOWN HALL MEETING', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Recover political influence:', style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            _buildRestOption('Rest', 'Recover 20 influence', Colors.green),
            _buildRestOption('Remove a card', 'Pay 75€ to remove a card', Colors.red),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('LEAVE', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _completeAct() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1A2A),
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber),
            SizedBox(width: 8),
            Text('ACT COMPLETE!', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You conquered The Political Arena!', style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 16),
            Text('Choose your reward:', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildRewardOption('Rare Card', 'Receive a rare political card', Colors.purple),
            _buildRewardOption('Political Perk', 'Gain a permanent advantage', Colors.orange),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: Text('NEXT ACT', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildMerchantOption(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF252535),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    title[0],
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4),
          Text(description, style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRestOption(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF252535),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.healing, color: color), // ✅ SICURO - disponibile ovunque
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardOption(String title, String description, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF252535),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                title.contains('Card') ? Icons.credit_card : Icons.workspace_premium,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.7), size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentNode = _getNodeById(_currentNodeId);
    final availableNodes = _getAvailableNodes();
    final nodeColor = _getNodeColor(currentNode.type);
    final nodeIcon = _getNodeIcon(currentNode.type); // ✅ Usa metodo corretto con icone sicure

    return Scaffold(
      backgroundColor: Color(0xFF0A0A15),
      appBar: AppBar(
        backgroundColor: Color(0xFF121225),
        title: Text(
          '${widget.actName} - Floor ${_currentFloor + 1}/15',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map, color: Colors.blue),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Full map coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // LEGENDA (usa emoji come testo - sempre sicuro)
          Container(
            padding: EdgeInsets.all(12),
            color: Color(0xFF151525),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('⚔️', 'Debate', Colors.red),
                _buildLegendItem('💰', 'Lobby', Colors.amber), // Cambiato emoji per chiarezza
                _buildLegendItem('🏛️', 'Town Hall', Colors.green),
                _buildLegendItem('⭐', 'Elite', Colors.purple),
                _buildLegendItem('👑', 'Boss', Colors.red),
              ],
            ),
          ),
          
          // NODO CORRENTE
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A2A),
              border: Border.all(color: nodeColor, width: 2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: nodeColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(nodeIcon, size: 48, color: nodeColor), // ✅ Usa icona sicura da _getNodeIcon
                SizedBox(height: 12),
                Text(
                  currentNode.displayName,
                  style: TextStyle(
                    color: nodeColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  currentNode.description,
                  style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: nodeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getNodeTypeName(currentNode.type).toUpperCase(),
                    style: TextStyle(
                      color: nodeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // PROSSIMI NODI DISPONIBILI
          if (availableNodes.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose your next move:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemCount: availableNodes.length,
                itemBuilder: (context, index) {
                  final node = availableNodes[index];
                  final color = _getNodeColor(node.type);
                  final icon = _getNodeIcon(node.type); // ✅ Usa metodo corretto
                  
                  return GestureDetector(
                    onTap: () => _navigateToNode(node.id),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF222238),
                        border: Border.all(color: color, width: 2),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.25),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 36, color: color), // ✅ Icona sicura
                          SizedBox(height: 8),
                          Text(
                            node.displayName,
                            style: TextStyle(
                              color: color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Floor ${node.floor + 1}',
                              style: TextStyle(
                                color: color,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentNode.isBoss ? Icons.emoji_events : Icons.check_circle,
                      size: 80,
                      color: currentNode.isBoss ? Colors.amber : Colors.green,
                    ),
                    SizedBox(height: 24),
                    Text(
                      currentNode.isBoss 
                          ? 'BOSS DEFEATED!'
                          : 'PATH COMPLETE',
                      style: TextStyle(
                        color: currentNode.isBoss ? Colors.amber : Colors.green,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      currentNode.isBoss
                          ? 'You defeated ${currentNode.displayName}!'
                          : 'You have explored all paths',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
          
          if (availableNodes.isEmpty && !currentNode.isBoss)
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('RETURN TO MENU', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String emoji, String label, Color color) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 18)),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  // ✅ METODO CORRETTO CON ICONE DISPONIBILI IN TUTTE LE VERSIONI FLUTTER
  IconData _getNodeIcon(String type) {
    switch (type) {
      case 'political_debate': 
        return Icons.account_balance; // ✅ SICURO - edificio governativo (Flutter 1.0+)
      case 'lobby_meeting': 
        return Icons.monetization_on; // ✅ SICURO - simbolo soldi (Flutter 1.0+)
      case 'town_hall': 
        return Icons.favorite; // ✅ SICURO - cuore per "recupero" (Flutter 1.0+)
      case 'powerful_politician': 
        return Icons.star; // ✅ SICURO (Flutter 1.0+)
      case 'boss': 
        return Icons.emoji_events; // ✅ Disponibile da Flutter 1.17.0 (standard oggi)
      default: 
        return Icons.help_outline; // ✅ SICURO (Flutter 1.0+)
    }
  }

  Color _getNodeColor(String type) {
    switch (type) {
      case 'political_debate': return Colors.red;
      case 'lobby_meeting': return Colors.amber;
      case 'town_hall': return Colors.green;
      case 'powerful_politician': return Colors.purple;
      case 'boss': return Colors.red;
      default: return Colors.blue;
    }
  }

  String _getNodeTypeName(String type) {
    switch (type) {
      case 'political_debate': return 'Political Debate';
      case 'lobby_meeting': return 'Lobby Meeting';
      case 'town_hall': return 'Town Hall';
      case 'powerful_politician': return 'Elite Politician';
      case 'boss': return 'Boss';
      default: return 'Unknown';
    }
  }
}