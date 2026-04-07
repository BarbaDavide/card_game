// lib/data/path_generator.dart

/// Generates satirical global political maps featuring world leaders and power brokers
class PathGenerator {
  // ===== ACT 1: THE POLITICAL ARENA (15 floors) =====
  static List<Map<String, dynamic>> generatePoliticalArena({int seed = 0}) {
    return [
      // Floor 0: Campaign Rally (start)
      {'id': 'node_0', 'type': 'political_debate', 'floor': 0, 'connections': ['node_1', 'node_2']},
      
      // Floor 1: Two political debates
      {'id': 'node_1', 'type': 'political_debate', 'floor': 1, 'connections': ['node_3']},
      {'id': 'node_2', 'type': 'political_debate', 'floor': 1, 'connections': ['node_3']},
      
      // Floor 2: Town Hall Meeting (rest)
      {'id': 'node_3', 'type': 'town_hall', 'floor': 2, 'connections': ['node_4']},
      
      // Floor 3: Lobbyist Dinner (merchant)
      {'id': 'node_4', 'type': 'lobby_meeting', 'floor': 3, 'connections': ['node_5', 'node_6']},
      
      // Floor 4: Two debates
      {'id': 'node_5', 'type': 'political_debate', 'floor': 4, 'connections': ['node_7']},
      {'id': 'node_6', 'type': 'political_debate', 'floor': 4, 'connections': ['node_7']},
      
      // Floor 5: ELITE - Senator with Dark Money
      {'id': 'node_7', 'type': 'powerful_politician', 'floor': 5, 'connections': ['node_8']},
      
      // Floor 6: Press Conference (rest)
      {'id': 'node_8', 'type': 'town_hall', 'floor': 6, 'connections': ['node_9', 'node_10']},
      
      // Floor 7: Two debates
      {'id': 'node_9', 'type': 'political_debate', 'floor': 7, 'connections': ['node_11']},
      {'id': 'node_10', 'type': 'political_debate', 'floor': 7, 'connections': ['node_11']},
      
      // Floor 8: Arms Dealer Meeting (merchant)
      {'id': 'node_11', 'type': 'lobby_meeting', 'floor': 8, 'connections': ['node_12']},
      
      // Floor 9: Congressional Hearing (rest)
      {'id': 'node_12', 'type': 'town_hall', 'floor': 9, 'connections': ['node_13']},
      
      // Floor 10: ELITE - Media Mogul
      {'id': 'node_13', 'type': 'powerful_politician', 'floor': 10, 'connections': ['node_14']},
      
      // Floors 11-13: Debates leading to boss
      {'id': 'node_14', 'type': 'political_debate', 'floor': 11, 'connections': ['node_15']},
      {'id': 'node_15', 'type': 'political_debate', 'floor': 12, 'connections': ['node_16']},
      {'id': 'node_16', 'type': 'political_debate', 'floor': 13, 'connections': ['node_17']},
      
      // Floor 14: BOSS - "The Orange Menace" (Trump parody)
      {'id': 'node_17', 'type': 'boss', 'floor': 14, 'connections': []},
    ];
  }

  // ===== ACT 2: THE GLOBAL STAGE (17 floors) =====
  static List<Map<String, dynamic>> generateGlobalStage({int seed = 0}) {
    return [
      // Floor 0: UN General Assembly (start)
      {'id': 'node_0', 'type': 'political_debate', 'floor': 0, 'connections': ['node_1', 'node_2']},
      
      // Floor 1: Diplomatic Summit (rest)
      {'id': 'node_1', 'type': 'town_hall', 'floor': 1, 'connections': ['node_3']},
      {'id': 'node_2', 'type': 'political_debate', 'floor': 1, 'connections': ['node_3']},
      
      // Floor 2: Oil Baron Meeting (merchant)
      {'id': 'node_3', 'type': 'lobby_meeting', 'floor': 2, 'connections': ['node_4', 'node_5']},
      
      // Floor 3: Two geopolitical debates
      {'id': 'node_4', 'type': 'political_debate', 'floor': 3, 'connections': ['node_6']},
      {'id': 'node_5', 'type': 'political_debate', 'floor': 3, 'connections': ['node_6']},
      
      // Floor 4: ELITE - Oligarch with Private Army
      {'id': 'node_6', 'type': 'powerful_politician', 'floor': 4, 'connections': ['node_7']},
      
      // Floor 5: G20 Summit (rest)
      {'id': 'node_7', 'type': 'town_hall', 'floor': 5, 'connections': ['node_8']},
      
      // Floor 6: Debate
      {'id': 'node_8', 'type': 'political_debate', 'floor': 6, 'connections': ['node_9', 'node_10']},
      
      // Floor 7: Tech Billionaire Meeting (merchant)
      {'id': 'node_9', 'type': 'lobby_meeting', 'floor': 7, 'connections': ['node_11']},
      {'id': 'node_10', 'type': 'political_debate', 'floor': 7, 'connections': ['node_11']},
      
      // Floor 8: Climate Conference (rest)
      {'id': 'node_11', 'type': 'town_hall', 'floor': 8, 'connections': ['node_12']},
      
      // Floor 9: ELITE - General with Nuclear Codes
      {'id': 'node_12', 'type': 'powerful_politician', 'floor': 9, 'connections': ['node_13']},
      
      // Floor 10: Debate
      {'id': 'node_13', 'type': 'political_debate', 'floor': 10, 'connections': ['node_14', 'node_15']},
      
      // Floor 11: Arms Dealer Consortium (merchant)
      {'id': 'node_14', 'type': 'lobby_meeting', 'floor': 11, 'connections': ['node_16']},
      {'id': 'node_15', 'type': 'political_debate', 'floor': 11, 'connections': ['node_16']},
      
      // Floor 12: Security Council (rest)
      {'id': 'node_16', 'type': 'town_hall', 'floor': 12, 'connections': ['node_17']},
      
      // Floor 13: ELITE - Spymaster
      {'id': 'node_17', 'type': 'powerful_politician', 'floor': 13, 'connections': ['node_18']},
      
      // Floors 14-15: Debates leading to boss
      {'id': 'node_18', 'type': 'political_debate', 'floor': 14, 'connections': ['node_19']},
      {'id': 'node_19', 'type': 'political_debate', 'floor': 15, 'connections': ['node_20']},
      
      // Floor 16: BOSS - "The Kremlin Master" (Putin parody)
      {'id': 'node_20', 'type': 'boss', 'floor': 16, 'connections': []},
    ];
  }

  // ===== ACT 3: THE SHADOW COUNCIL (19 floors) =====
  static List<Map<String, dynamic>> generateShadowCouncil({int seed = 0}) {
    return [
      // Floor 0: Secret Bunker Entrance (start)
      {'id': 'node_0', 'type': 'political_debate', 'floor': 0, 'connections': ['node_1', 'node_2']},
      
      // Floor 1: Bilderberg Meeting (merchant)
      {'id': 'node_1', 'type': 'lobby_meeting', 'floor': 1, 'connections': ['node_3']},
      {'id': 'node_2', 'type': 'political_debate', 'floor': 1, 'connections': ['node_3']},
      
      // Floor 2: Intelligence Briefing (rest)
      {'id': 'node_3', 'type': 'town_hall', 'floor': 2, 'connections': ['node_4', 'node_5']},
      
      // Floor 3: ELITE - "The Desert Fox" (Bibi Netanyahu parody)
      {'id': 'node_4', 'type': 'powerful_politician', 'floor': 3, 'connections': ['node_6']},
      {'id': 'node_5', 'type': 'political_debate', 'floor': 3, 'connections': ['node_6']},
      
      // Floor 4: Blackrock Executive Meeting (merchant)
      {'id': 'node_6', 'type': 'lobby_meeting', 'floor': 4, 'connections': ['node_7']},
      
      // Floor 5: Deep State Briefing (rest)
      {'id': 'node_7', 'type': 'town_hall', 'floor': 5, 'connections': ['node_8', 'node_9']},
      
      // Floor 6: ELITE - Central Bank Chairman
      {'id': 'node_8', 'type': 'powerful_politician', 'floor': 6, 'connections': ['node_10']},
      {'id': 'node_9', 'type': 'political_debate', 'floor': 6, 'connections': ['node_10']},
      
      // Floor 7: Debate
      {'id': 'node_10', 'type': 'political_debate', 'floor': 7, 'connections': ['node_11']},
      
      // Floor 8: Vatican Diplomacy (rest)
      {'id': 'node_11', 'type': 'town_hall', 'floor': 8, 'connections': ['node_12', 'node_13']},
      
      // Floor 9: ELITE - Media Empire Owner
      {'id': 'node_12', 'type': 'powerful_politician', 'floor': 9, 'connections': ['node_14']},
      {'id': 'node_13', 'type': 'political_debate', 'floor': 9, 'connections': ['node_14']},
      
      // Floor 10: World Economic Forum (merchant)
      {'id': 'node_14', 'type': 'lobby_meeting', 'floor': 10, 'connections': ['node_15']},
      
      // Floor 11: Intelligence Oversight (rest)
      {'id': 'node_15', 'type': 'town_hall', 'floor': 11, 'connections': ['node_16', 'node_17']},
      
      // Floor 12: ELITE - Shadow CIA Director
      {'id': 'node_16', 'type': 'powerful_politician', 'floor': 12, 'connections': ['node_18']},
      {'id': 'node_17', 'type': 'political_debate', 'floor': 12, 'connections': ['node_18']},
      
      // Floor 13: Debate
      {'id': 'node_18', 'type': 'political_debate', 'floor': 13, 'connections': ['node_19']},
      
      // Floor 14: Federal Reserve Meeting (rest)
      {'id': 'node_19', 'type': 'town_hall', 'floor': 14, 'connections': ['node_20']},
      
      // Floor 15: ELITE - Tech Surveillance Baron
      {'id': 'node_20', 'type': 'powerful_politician', 'floor': 15, 'connections': ['node_21']},
      
      // Floors 16-17: Debates leading to final boss
      {'id': 'node_21', 'type': 'political_debate', 'floor': 16, 'connections': ['node_22']},
      {'id': 'node_22', 'type': 'political_debate', 'floor': 17, 'connections': ['node_23']},
      
      // Floor 18: FINAL BOSS - "The Puppet Master" (Shadowy global elite)
      {'id': 'node_23', 'type': 'boss', 'floor': 18, 'connections': []},
    ];
  }

  /// Get available nodes from current position
  static List<Map<String, dynamic>> getAvailableNodes(
    String currentNodeId,
    List<String> visitedNodeIds,
    List<Map<String, dynamic>> allNodes,
  ) {
    final currentNode = allNodes.firstWhere(
      (node) => node['id'] == currentNodeId,
      orElse: () => {'connections': const []},
    );
    
    final connectionIds = List<String>.from(currentNode['connections'] ?? const []);
    
    return allNodes.where((node) {
      final id = node['id'] as String;
      return connectionIds.contains(id) && !visitedNodeIds.contains(id);
    }).toList();
  }

  /// Get current node details
  static Map<String, dynamic> getCurrentNode(
    String currentNodeId,
    List<Map<String, dynamic>> allNodes,
  ) {
    return allNodes.firstWhere(
      (node) => node['id'] == currentNodeId,
      orElse: () => {
        'id': 'unknown',
        'type': 'unknown',
        'floor': -1,
        'name': 'Unknown Location',
        'description': 'You are lost in the political wilderness',
      },
    );
  }

  /// Node type helpers
  static bool isBossNode(String nodeId, List<Map<String, dynamic>> allNodes) =>
      _getNodeType(nodeId, allNodes) == 'boss';

  static bool isEliteNode(String nodeId, List<Map<String, dynamic>> allNodes) =>
      _getNodeType(nodeId, allNodes) == 'powerful_politician';

  static bool isMerchantNode(String nodeId, List<Map<String, dynamic>> allNodes) =>
      _getNodeType(nodeId, allNodes) == 'lobby_meeting';

  static bool isRestNode(String nodeId, List<Map<String, dynamic>> allNodes) =>
      _getNodeType(nodeId, allNodes) == 'town_hall';

  static String _getNodeType(String nodeId, List<Map<String, dynamic>> allNodes) {
    final node = allNodes.firstWhere(
      (n) => n['id'] == nodeId,
      orElse: () => {'type': 'unknown'},
    );
    return node['type'] as String;
  }

  /// Get node display name based on type and floor
  static String getNodeName(String nodeId, List<Map<String, dynamic>> allNodes) {
    final node = getCurrentNode(nodeId, allNodes);
    final type = node['type'] as String;
    final floor = node['floor'] as int;
    
    switch (type) {
      case 'political_debate':
        return _getDebateName(floor);
      case 'town_hall':
        return _getTownHallName(floor);
      case 'lobby_meeting':
        return _getLobbyName(floor);
      case 'powerful_politician':
        return _getEliteName(floor);
      case 'boss':
        return _getBossName(floor);
      default:
        return 'Unknown Location';
    }
  }

  static String getNodeDescription(String nodeId, List<Map<String, dynamic>> allNodes) {
    final node = getCurrentNode(nodeId, allNodes);
    final type = node['type'] as String;
    final floor = node['floor'] as int;
    
    switch (type) {
      case 'political_debate':
        return _getDebateDescription(floor);
      case 'town_hall':
        return _getTownHallDescription(floor);
      case 'lobby_meeting':
        return _getLobbyDescription(floor);
      case 'powerful_politician':
        return _getEliteDescription(floor);
      case 'boss':
        return _getBossDescription(floor);
      default:
        return 'A mysterious location in the global power structure';
    }
  }

  // Helper methods for node names/descriptions
  static String _getDebateName(int floor) {
    final debates = [
      'Campaign Rally', 'TV Debate', 'Town Square Argument', 'Press Conference Brawl',
      'Social Media War', 'Parliamentary Shouting Match', 'Diplomatic Incident',
      'UN Podium Showdown', 'Border Dispute', 'Trade War Negotiations',
      'Sanctions Standoff', 'Cyber Warfare Accusations', 'Election Interference Claims',
      'Propaganda Offensive', 'Information Warfare'
    ];
    return debates[floor % debates.length];
  }

  static String _getDebateDescription(int floor) {
    return 'A heated political confrontation. Defeat your opponent to advance your agenda.';
  }

  static String _getTownHallName(int floor) {
    return 'Town Hall Meeting';
  }

  static String _getTownHallDescription(int floor) {
    return 'Recover your political influence and prepare for the next battle.';
  }

  static String _getLobbyName(int floor) {
    final lobbies = [
      'Arms Dealer', 'Oil Baron', 'Tech Billionaire', 'Pharma CEO',
      'Wall Street Banker', 'Media Mogul', 'Dark Money Operative',
      'Intelligence Contractor', 'Private Military CEO', 'Cryptocurrency Baron'
    ];
    return '${lobbies[floor % lobbies.length]} Meeting';
  }

  static String _getLobbyDescription(int floor) {
    return 'Purchase powerful cards and political favors to strengthen your position.';
  }

  static String _getEliteName(int floor) {
    final elites = [
      'Senator with Dark Money', 'Oligarch with Private Army', 'General with Nuclear Codes',
      'The Desert Fox', 'Central Bank Chairman', 'Spymaster', 'Media Empire Owner',
      'Shadow CIA Director', 'Tech Surveillance Baron', 'Deep State Operative'
    ];
    return elites[floor % elites.length];
  }

  static String _getEliteDescription(int floor) {
    return 'A powerful political operator with dangerous connections. Defeat them to weaken the establishment.';
  }

  static String _getBossName(int floor) {
    if (floor <= 14) return 'DonaldTrump';
    if (floor <= 16) return 'VladimirPutin';
    return 'ThePuppetMaster';
  }

  static String _getBossDescription(int floor) {
    if (floor <= 14) return 'The unpredictable leader who dominates media cycles and bends reality to his will.';
    if (floor <= 16) return 'The calculating strategist who plays the long game with ice-cold precision.';
    return 'The shadowy figure who pulls strings across governments and corporations worldwide.';
  }
}