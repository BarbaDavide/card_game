// lib/ui/screen/run_map_screen.dart

import 'package:flutter/material.dart';
import 'merchant_screen.dart'; // ← AGGIUNGI QUESTA RIGA
import 'battle_screen.dart';   // ← E QUESTA SE NON C'È GIÀ

class RunMapScreen extends StatefulWidget {
  final String fighterName;
  final int currentFloor;
  final String currentNodeId;
  final List<String> visitedNodeIds;
  final String region; // 'america', 'russia', 'europe', 'final'

  const RunMapScreen({
    Key? key,
    required this.fighterName,
    required this.currentFloor,
    required this.currentNodeId,
    required this.visitedNodeIds,
    this.region = 'america',
  }) : super(key: key);

  @override
  State<RunMapScreen> createState() => _RunMapScreenState();
}

class _RunMapScreenState extends State<RunMapScreen> {
  late List<Map<String, dynamic>> _nodes;
  late Map<String, List<String>> _connections;
  late String _regionTitle;
  late Color _regionColor;
  
  // STATO INTERNO GESTITO DAL WIDGET (NON DIPENDE DAI PARAMETRI ESTERNI)
  String _currentNodeId = '';
  List<String> _visitedNodeIds = [];
  int _currentFloor = 0;

  @override
  void initState() {
    super.initState();
    _currentNodeId = widget.currentNodeId;
    _visitedNodeIds = List.from(widget.visitedNodeIds);
    _currentFloor = widget.currentFloor;
    _initializeRegion();
  }

  void _initializeRegion() {
    switch (widget.region) {
      case 'america':
        _nodes = _generateAmericaMap();
        _connections = _generateAmericaConnections();
        _regionTitle = 'THE AMERICAN ARENA';
        _regionColor = Colors.blue;
        break;
      case 'russia':
        _nodes = _generateRussiaMap();
        _connections = _generateRussiaConnections();
        _regionTitle = 'THE KREMLIN MAZE';
        _regionColor = Colors.red;
        break;
      case 'europe':
        _nodes = _generateEuropeMap();
        _connections = _generateEuropeConnections();
        _regionTitle = 'EUROPEAN UNION';
        _regionColor = Colors.yellow;
        break;
      case 'final':
        _nodes = _generateFinalStageMap();
        _connections = _generateFinalStageConnections();
        _regionTitle = 'THE SHADOW COUNCIL';
        _regionColor = Colors.purple;
        break;
      default:
        _nodes = _generateAmericaMap();
        _connections = _generateAmericaConnections();
        _regionTitle = 'THE AMERICAN ARENA';
        _regionColor = Colors.blue;
    }
  }

  // ===== MAPPA AMERICA (15 piani) =====
  List<Map<String, dynamic>> _generateAmericaMap() {
    return [
      {'id': 'am_0', 'type': 'political_debate', 'floor': 0, 'name': 'Campaign Rally', 'desc': 'Kick off your American political journey'},
      {'id': 'am_1a', 'type': 'political_debate', 'floor': 1, 'name': 'Fox News Debate', 'desc': 'Face opponents on primetime TV'},
      {'id': 'am_1b', 'type': 'political_debate', 'floor': 1, 'name': 'Twitter War', 'desc': 'Battle in the digital trenches'},
      {'id': 'am_2', 'type': 'town_hall', 'floor': 2, 'name': 'Iowa Caucus', 'desc': 'Recover influence with voters'},
      {'id': 'am_3', 'type': 'lobby_meeting', 'floor': 3, 'name': 'Wall Street Dinner', 'desc': 'Buy political favors from bankers'},
      {'id': 'am_4a', 'type': 'political_debate', 'floor': 4, 'name': 'Border Wall Debate', 'desc': 'Clash over immigration policy'},
      {'id': 'am_4b', 'type': 'political_debate', 'floor': 4, 'name': 'Tax Cuts Battle', 'desc': 'Fight over fiscal policies'},
      {'id': 'am_5', 'type': 'powerful_politician', 'floor': 5, 'name': 'Elon Musk', 'desc': 'Tech billionaire with Twitter army and flamethrowers', 'elite_name': 'Elon Musk'},
      {'id': 'am_6', 'type': 'town_hall', 'floor': 6, 'name': 'Press Conference', 'desc': 'Regroup after elite battle'},
      {'id': 'am_7a', 'type': 'political_debate', 'floor': 7, 'name': 'Climate Debate', 'desc': 'Battle over environmental policies'},
      {'id': 'am_7b', 'type': 'political_debate', 'floor': 7, 'name': 'Healthcare Showdown', 'desc': 'Fight over medical reform'},
      {'id': 'am_8', 'type': 'lobby_meeting', 'floor': 8, 'name': 'Silicon Valley Summit', 'desc': 'Buy data manipulation tools'},
      {'id': 'am_9', 'type': 'town_hall', 'floor': 9, 'name': 'Congressional Hearing', 'desc': 'Prepare for next challenge'},
      {'id': 'am_10', 'type': 'powerful_politician', 'floor': 10, 'name': 'Bill Gates', 'desc': 'Philanthropist with global health influence', 'elite_name': 'Bill Gates'},
      {'id': 'am_11', 'type': 'political_debate', 'floor': 11, 'name': 'Foreign Policy', 'desc': 'Clash over international relations'},
      {'id': 'am_12', 'type': 'political_debate', 'floor': 12, 'name': 'Election Integrity', 'desc': 'Final debate before boss'},
      {'id': 'am_13', 'type': 'political_debate', 'floor': 13, 'name': 'Media Circus', 'desc': 'Navigate sensationalist coverage'},
      {'id': 'am_14', 'type': 'boss', 'floor': 14, 'name': 'DonaldTrump', 'desc': 'The unpredictable leader who dominates media cycles', 'boss_name': 'DonaldTrump'},
    ];
  }

  Map<String, List<String>> _generateAmericaConnections() {
    return {
      'am_0': ['am_1a', 'am_1b'],
      'am_1a': ['am_2'],
      'am_1b': ['am_2'],
      'am_2': ['am_3'],
      'am_3': ['am_4a', 'am_4b'],
      'am_4a': ['am_5'],
      'am_4b': ['am_5'],
      'am_5': ['am_6'],
      'am_6': ['am_7a', 'am_7b'],
      'am_7a': ['am_8'],
      'am_7b': ['am_8'],
      'am_8': ['am_9'],
      'am_9': ['am_10'],
      'am_10': ['am_11'],
      'am_11': ['am_12'],
      'am_12': ['am_13'],
      'am_13': ['am_14'],
    };
  }

  // ===== MAPPA RUSSIA (17 piani) =====
  List<Map<String, dynamic>> _generateRussiaMap() {
    return [
      {'id': 'ru_0', 'type': 'political_debate', 'floor': 0, 'name': 'Red Square Rally', 'desc': 'Begin your ascent in the Kremlin hierarchy'},
      {'id': 'ru_1', 'type': 'town_hall', 'floor': 1, 'name': 'Duma Session', 'desc': 'Recover influence in parliament'},
      {'id': 'ru_2', 'type': 'lobby_meeting', 'floor': 2, 'name': 'Oligarch Dinner', 'desc': 'Buy favors from oil magnates'},
      {'id': 'ru_3a', 'type': 'political_debate', 'floor': 3, 'name': 'Propaganda Broadcast', 'desc': 'Clash over state media narrative'},
      {'id': 'ru_3b', 'type': 'political_debate', 'floor': 3, 'name': 'Sanctions Debate', 'desc': 'Fight against Western economic pressure'},
      {'id': 'ru_4', 'type': 'powerful_politician', 'floor': 4, 'name': 'Roman Abramovich', 'desc': 'Billionaire with private army and football clubs', 'elite_name': 'Oligarch'},
      {'id': 'ru_5', 'type': 'town_hall', 'floor': 5, 'name': 'KGB Briefing', 'desc': 'Regroup with intelligence services'},
      {'id': 'ru_6', 'type': 'political_debate', 'floor': 6, 'name': 'Cyber Warfare', 'desc': 'Battle in digital domain'},
      {'id': 'ru_7', 'type': 'lobby_meeting', 'floor': 7, 'name': 'Arms Dealer Summit', 'desc': 'Purchase military hardware'},
      {'id': 'ru_8', 'type': 'town_hall', 'floor': 8, 'name': 'Security Council', 'desc': 'Strategic planning session'},
      {'id': 'ru_9', 'type': 'powerful_politician', 'floor': 9, 'name': 'General Shoigu', 'desc': 'Defense minister with nuclear codes', 'elite_name': 'General'},
      {'id': 'ru_10a', 'type': 'political_debate', 'floor': 10, 'name': 'Ukraine Crisis', 'desc': 'Geopolitical confrontation'},
      {'id': 'ru_10b', 'type': 'political_debate', 'floor': 10, 'name': 'Energy Blackmail', 'desc': 'Leverage gas supplies for political gain'},
      {'id': 'ru_11', 'type': 'lobby_meeting', 'floor': 11, 'name': 'FSB Meeting', 'desc': 'Covert intelligence operations'},
      {'id': 'ru_12', 'type': 'town_hall', 'floor': 12, 'name': 'Sochi Summit', 'desc': 'Diplomatic recovery'},
      {'id': 'ru_13', 'type': 'powerful_politician', 'floor': 13, 'name': 'SVR Director', 'desc': 'Master of espionage and false flags', 'elite_name': 'Spymaster'},
      {'id': 'ru_14', 'type': 'political_debate', 'floor': 14, 'name': 'Nuclear Posture', 'desc': 'Ultimate strategic threat'},
      {'id': 'ru_15', 'type': 'political_debate', 'floor': 15, 'name': 'Bear Hug Diplomacy', 'desc': 'Final confrontation before boss'},
      {'id': 'ru_16', 'type': 'boss', 'floor': 16, 'name': 'VladimirPutin', 'desc': 'The calculating strategist who plays the long game', 'boss_name': 'Vladimir Putin'},
    ];
  }

  Map<String, List<String>> _generateRussiaConnections() {
    return {
      'ru_0': ['ru_1'],
      'ru_1': ['ru_2'],
      'ru_2': ['ru_3a', 'ru_3b'],
      'ru_3a': ['ru_4'],
      'ru_3b': ['ru_4'],
      'ru_4': ['ru_5'],
      'ru_5': ['ru_6'],
      'ru_6': ['ru_7'],
      'ru_7': ['ru_8'],
      'ru_8': ['ru_9'],
      'ru_9': ['ru_10a', 'ru_10b'],
      'ru_10a': ['ru_11'],
      'ru_10b': ['ru_11'],
      'ru_11': ['ru_12'],
      'ru_12': ['ru_13'],
      'ru_13': ['ru_14'],
      'ru_14': ['ru_15'],
      'ru_15': ['ru_16'],
    };
  }

  // ===== MAPPA EUROPA (16 piani) =====
  List<Map<String, dynamic>> _generateEuropeMap() {
    return [
      {'id': 'eu_0', 'type': 'political_debate', 'floor': 0, 'name': 'Brussels Summit', 'desc': 'Enter the heart of European bureaucracy'},
      {'id': 'eu_1', 'type': 'lobby_meeting', 'floor': 1, 'name': 'EU Lobbyists', 'desc': 'Navigate complex regulatory landscape'},
      {'id': 'eu_2a', 'type': 'political_debate', 'floor': 2, 'name': 'Eurozone Crisis', 'desc': 'Clash over monetary policy'},
      {'id': 'eu_2b', 'type': 'political_debate', 'floor': 2, 'name': 'Migration Debate', 'desc': 'Fight over Schengen agreement'},
      {'id': 'eu_3', 'type': 'town_hall', 'floor': 3, 'name': 'European Parliament', 'desc': 'Recover influence with MEPs'},
      {'id': 'eu_4', 'type': 'powerful_politician', 'floor': 4, 'name': 'Angela Merkel', 'desc': 'Chancellor with austerity policies and moral authority', 'elite_name': 'Angela Merkel'},
      {'id': 'eu_5', 'type': 'lobby_meeting', 'floor': 5, 'name': 'Pharma Lobby', 'desc': 'Buy influence on health regulations'},
      {'id': 'eu_6', 'type': 'political_debate', 'floor': 6, 'name': 'Brexit Negotiations', 'desc': 'Complex divorce proceedings'},
      {'id': 'eu_7', 'type': 'town_hall', 'floor': 7, 'name': 'ECB Meeting', 'desc': 'Monetary policy recovery'},
      {'id': 'eu_8', 'type': 'powerful_politician', 'floor': 8, 'name': 'Emmanuel Macron', 'desc': 'President with neoliberal reforms and yellow vests', 'elite_name': 'Emmanuel Macron'},
      {'id': 'eu_9', 'type': 'lobby_meeting', 'floor': 9, 'name': 'Green Lobby', 'desc': 'Buy climate policy influence'},
      {'id': 'eu_10a', 'type': 'political_debate', 'floor': 10, 'name': 'Rule of Law', 'desc': 'Clash over democratic backsliding'},
      {'id': 'eu_10b', 'type': 'political_debate', 'floor': 10, 'name': 'Digital Tax', 'desc': 'Fight over tech giant regulations'},
      {'id': 'eu_11', 'type': 'town_hall', 'floor': 11, 'name': 'Schengen Agreement', 'desc': 'Border-free recovery'},
      {'id': 'eu_12', 'type': 'powerful_politician', 'floor': 12, 'name': 'Ursula von der Leyen', 'desc': 'Commission President with Green Deal agenda', 'elite_name': 'EU President'},
      {'id': 'eu_13', 'type': 'political_debate', 'floor': 13, 'name': 'EU Army Debate', 'desc': 'Strategic autonomy discussion'},
      {'id': 'eu_14', 'type': 'political_debate', 'floor': 14, 'name': 'Federal Europe', 'desc': 'Final debate before boss'},
      {'id': 'eu_15', 'type': 'boss', 'floor': 15, 'name': 'ECB', 'desc': 'The unelected institution controlling European destiny', 'boss_name': 'ECB President'},
    ];
  }

  Map<String, List<String>> _generateEuropeConnections() {
    return {
      'eu_0': ['eu_1'],
      'eu_1': ['eu_2a', 'eu_2b'],
      'eu_2a': ['eu_3'],
      'eu_2b': ['eu_3'],
      'eu_3': ['eu_4'],
      'eu_4': ['eu_5'],
      'eu_5': ['eu_6'],
      'eu_6': ['eu_7'],
      'eu_7': ['eu_8'],
      'eu_8': ['eu_9'],
      'eu_9': ['eu_10a', 'eu_10b'],
      'eu_10a': ['eu_11'],
      'eu_10b': ['eu_11'],
      'eu_11': ['eu_12'],
      'eu_12': ['eu_13'],
      'eu_13': ['eu_14'],
      'eu_14': ['eu_15'],
    };
  }

  // ===== MAPPA FINALE SEGRETA (10 piani) =====
  List<Map<String, dynamic>> _generateFinalStageMap() {
    return [
      {'id': 'fi_0', 'type': 'political_debate', 'floor': 0, 'name': 'Hidden Entrance', 'desc': 'You discover a secret passage to the inner sanctum'},
      {'id': 'fi_1', 'type': 'political_debate', 'floor': 1, 'name': 'Shadow Corridor', 'desc': 'Navigate through dimly lit halls of power'},
      {'id': 'fi_2', 'type': 'town_hall', 'floor': 2, 'name': 'Ancient Archives', 'desc': 'Discover forgotten secrets of global governance'},
      {'id': 'fi_3', 'type': 'powerful_politician', 'floor': 3, 'name': 'CUSTOM_ELITE_1', 'desc': 'CUSTOMIZE: Add your own elite enemy here', 'elite_name': 'CUSTOM ELITE'},
      {'id': 'fi_4', 'type': 'lobby_meeting', 'floor': 4, 'name': 'Black Market', 'desc': 'Trade forbidden knowledge and artifacts'},
      {'id': 'fi_5', 'type': 'political_debate', 'floor': 5, 'name': 'Vault Entrance', 'desc': 'Battle through reinforced defenses'},
      {'id': 'fi_6', 'type': 'town_hall', 'floor': 6, 'name': 'Control Room', 'desc': 'Access surveillance systems of the global elite'},
      {'id': 'fi_7', 'type': 'powerful_politician', 'floor': 7, 'name': 'CUSTOM_ELITE_2', 'desc': 'CUSTOMIZE: Add your second custom elite enemy here', 'elite_name': 'CUSTOM ELITE'},
      {'id': 'fi_8', 'type': 'political_debate', 'floor': 8, 'name': 'Inner Sanctum', 'desc': 'Final approach to the ultimate power'},
      {'id': 'fi_9', 'type': 'boss', 'floor': 9, 'name': 'CUSTOM_BOSS', 'desc': 'CUSTOMIZE: Create your ultimate secret boss', 'boss_name': 'THE MASTER'},
    ];
  }

  Map<String, List<String>> _generateFinalStageConnections() {
    return {
      'fi_0': ['fi_1'],
      'fi_1': ['fi_2'],
      'fi_2': ['fi_3'],
      'fi_3': ['fi_4'],
      'fi_4': ['fi_5'],
      'fi_5': ['fi_6'],
      'fi_6': ['fi_7'],
      'fi_7': ['fi_8'],
      'fi_8': ['fi_9'],
    };
  }

  List<String> _getAvailableNodes() {
    final connections = _connections[_currentNodeId];
    if (connections == null) return [];
    return connections.where((id) => !_visitedNodeIds.contains(id)).toList();
  }

  // ===== METODO CORRETTO CON GESTIONE STATO INTERNO =====
  void _moveToNode(String nodeId) {
    final node = _nodes.firstWhere((n) => n['id'] == nodeId, orElse: () => {});
    final nodeType = node['type'] as String?;
    
    // Calcola HP in base al tipo di nodo
    int enemyHp;
    if (node.containsKey('boss_name')) {
      enemyHp = 300;
    } else if (node.containsKey('elite_name')) {
      enemyHp = 120;
    } else {
      enemyHp = 50;
    }
    
    // Aggiorna lo stato interno PRIMA di navigare
    setState(() {
      _visitedNodeIds.add(_currentNodeId);
      _currentNodeId = nodeId;
      _currentFloor = node['floor'] as int;
    });
    
    // Import CORRETTO per la struttura lib/ui/screen/
    // NOTA: BattleScreen e MerchantScreen devono essere nella STESSA cartella
    
    // Apri battle screen per nodi di combattimento
    if (nodeType == 'political_debate' || 
        nodeType == 'powerful_politician' || 
        nodeType == 'boss') {
      
      // Import dinamico per evitare errori di ciclo
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BattleScreen(
            enemyId: nodeId,
            enemyName: node['name'] as String,
            enemyDescription: node['desc'] as String,
            enemyMaxHp: enemyHp,
            isElite: node.containsKey('elite_name'),
            isBoss: node.containsKey('boss_name'),
          ),
        ),
      ).then((victory) {
        // Dopo il combattimento, aggiorna ulteriormente lo stato se necessario
        if (mounted && victory == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Victory! Continuing your political journey...'),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
    // Per mercanti, apri lo screen mercante
    else if (nodeType == 'lobby_meeting') {
      // Import dinamico per evitare errori di ciclo
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MerchantScreen(
            merchantType: _getMerchantTypeForNode(nodeId),
            playerEuros: 10000,
            deck: ['strike', 'strike', 'strike', 'defend', 'bash'],
            perks: [],
          ),
        ),
      ).then((result) {
        if (mounted && result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction completed!')),
          );
        }
      });
    }
    // Per town hall, mostra semplice messaggio
    else if (nodeType == 'town_hall') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recovered influence at ${node['name']}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _getMerchantTypeForNode(String nodeId) {
    if (nodeId.contains('am_')) return 'wall_street';
    if (nodeId.contains('ru_')) return 'oligarch';
    if (nodeId.contains('eu_')) return 'eu_lobby';
    if (nodeId.contains('fi_')) return 'black_market';
    return 'wall_street';
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF151525),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem('🗣️', 'Debate', Colors.red),
          _buildLegendItem('⭐', 'Elite', Colors.purple),
          _buildLegendItem('💼', 'Lobby', Colors.amber),
          _buildLegendItem('🏛️', 'Town Hall', Colors.green),
          _buildLegendItem('👑', 'Boss', _regionColor),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String emoji, String label, Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentNodeHeader(Map<String, dynamic> node) {
    final type = node['type'] as String;
    final color = _getNodeTypeColor(type);
    final emoji = _getNodeTypeEmoji(type);
    final name = node['name'] as String;
    final desc = node['desc'] as String;
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: Color.alphaBlend(
        color.withOpacity(0.15),
        const Color(0xFF1A1A2A),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMap(List<String> availableNodes) {
    // Raggruppa nodi per piano
    final floors = <int, List<Map<String, dynamic>>>{};
    for (final node in _nodes) {
      final floor = node['floor'] as int;
      floors[floor] = floors[floor] ?? [];
      floors[floor]!.add(node);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: floors.length,
      itemBuilder: (context, index) {
        final floorNodes = floors[index]!;
        return _buildFloorRow(index, floorNodes, availableNodes);
      },
    );
  }

  Widget _buildFloorRow(int floor, List<Map<String, dynamic>> nodes, List<String> availableNodes) {
    final isBossFloor = floor == _nodes.last['floor'];
    final isCurrentFloor = floor == _currentFloor;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          // Etichetta piano con stile regionale
          if (isBossFloor)
            _buildBossFloorBadge(floor)
          else
            _buildFloorLabel(floor, isCurrentFloor),
          
          const SizedBox(height: 14),
          
          // Nodi del piano
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(nodes.length, (index) {
              final node = nodes[index];
              final nodeId = node['id'] as String;
              final isCurrent = nodeId == _currentNodeId;
              final isVisited = _visitedNodeIds.contains(nodeId);
              final isAvailable = availableNodes.contains(nodeId);
              
              return _buildNodeWidget(
                node: node,
                isCurrent: isCurrent,
                isVisited: isVisited,
                isAvailable: isAvailable,
                onTap: isAvailable ? () => _moveToNode(nodeId) : null,
              );
            }),
          ),
          
          // Linee di connessione (solo se non è l'ultimo piano)
          if (floor < _nodes.last['floor']) ...[
            const SizedBox(height: 10),
            _buildConnectionLines(nodes.length),
          ],
        ],
      ),
    );
  }

  Widget _buildFloorLabel(int floor, bool isCurrent) {
    return Text(
      'FLOOR ${floor + 1}',
      style: TextStyle(
        color: isCurrent ? _regionColor : Colors.white70,
        fontSize: 15,
        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildBossFloorBadge(int floor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _regionColor.withOpacity(0.9),
            _regionColor.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _regionColor.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        widget.region == 'america' ? 'PRESIDENTIAL DEBATE' :
        widget.region == 'russia' ? 'KREMLIN SHOWDOWN' :
        widget.region == 'europe' ? 'EU SUMMIT' :
        'FINAL CONFRONTATION',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNodeWidget({
    required Map<String, dynamic> node,
    required bool isCurrent,
    required bool isVisited,
    required bool isAvailable,
    required VoidCallback? onTap,
  }) {
    final type = node['type'] as String;
    final name = node['name'] as String;
    final color = _getNodeTypeColor(type);
    final emoji = _getNodeTypeEmoji(type);
    final size = isCurrent ? 72.0 : 60.0;
    final showEliteBadge = node.containsKey('elite_name');
    final showBossBadge = node.containsKey('boss_name');
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            // Nodo principale
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: isVisited 
                    ? const Color(0xFF25253D)
                    : isCurrent
                        ? color.withOpacity(0.95)
                        : const Color(0xFF1A1A2E),
                border: Border.all(
                  color: isCurrent
                      ? Colors.yellow
                      : isAvailable
                          ? Colors.blueAccent
                          : isVisited
                              ? Colors.grey
                              : color.withOpacity(0.7),
                  width: isCurrent ? 3 : isAvailable ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(size / 2),
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.8),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ]
                    : isAvailable
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
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
                                color: Colors.yellow.withOpacity(0.9),
                                blurRadius: 12,
                                offset: Offset.zero,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  if (isVisited && !isCurrent) ...[
                    const SizedBox(height: 2),
                    Container(
                      width: 14,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Nome del nodo (solo per elite/boss)
            if (showEliteBadge || showBossBadge) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: showBossBadge 
                      ? _regionColor.withOpacity(0.25) 
                      : Colors.purple.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: showBossBadge ? _regionColor : Colors.purple,
                    width: 1,
                  ),
                ),
                child: Text(
                  showBossBadge ? node['boss_name']! : node['elite_name']!,
                  style: TextStyle(
                    color: showBossBadge ? _regionColor : Colors.purple,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            
            // Etichetta piano
            if (!showEliteBadge && !showBossBadge) ...[
              const SizedBox(height: 2),
              Text(
                name.split(' ').first,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                ),
                maxLines: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionLines(int nodeCount) {
    return SizedBox(
      height: 24,
      child: CustomPaint(
        painter: _ConnectionPainter(nodeCount: nodeCount),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF121225),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_getAvailableNodes().isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Select a path to advance your political career!'),
                  backgroundColor: Color(0xFF1A1A2A),
                ),
              );
            } else {
              _showActCompleteDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _regionColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: const Text(
            'CHOOSE PATH',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  void _showActCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2A),
        title: Text(
          '${_regionTitle} CONQUERED!',
          style: TextStyle(
            color: _regionColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        content: const Text(
          'You have defeated the regional power structure!\nChoose your reward:',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Torna al menu
            },
            child: const Text(
              'NEXT REGION',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Color _getNodeTypeColor(String type) {
    switch (type) {
      case 'political_debate': return Colors.red;
      case 'powerful_politician': return Colors.purple;
      case 'lobby_meeting': return Colors.amber;
      case 'town_hall': return Colors.green;
      case 'boss': return _regionColor;
      default: return Colors.grey;
    }
  }

  String _getNodeTypeEmoji(String type) {
    switch (type) {
      case 'political_debate': return '🗣️';
      case 'powerful_politician': return '⭐';
      case 'lobby_meeting': return '💼';
      case 'town_hall': return '🏛️';
      case 'boss': return '👑';
      default: return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableNodes = _getAvailableNodes();
    final currentNode = _nodes.firstWhere((n) => n['id'] == _currentNodeId, orElse: () => _nodes[0]);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A15),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: Text(
          '${widget.fighterName} - ${_regionTitle}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '10,000€',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Legenda regionale
          _buildLegend(),
          
          // Titolo del nodo corrente
          _buildCurrentNodeHeader(currentNode),
          
          // Mappa dei nodi
          Expanded(
            child: _buildMap(availableNodes),
          ),
          
          // Pulsante "Choose Path"
          _buildContinueButton(),
        ],
      ),
    );
  }
}
class _ConnectionPainter extends CustomPainter {
  final int nodeCount;

  _ConnectionPainter({required this.nodeCount});

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
      canvas.drawLine(Offset(centerX, startY), Offset(centerX, endY), paint);
    } else if (nodeCount == 2) {
      final spacing = size.width * 0.35;
      canvas.drawLine(Offset(centerX, startY), Offset(centerX - spacing, endY), paint);
      canvas.drawLine(Offset(centerX, startY), Offset(centerX + spacing, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}