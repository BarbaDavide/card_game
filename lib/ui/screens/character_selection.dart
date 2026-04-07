// lib/ui/screens/character_selection.dart

import 'package:flutter/material.dart';
import 'run_map_screen.dart'; // ✅ IMPORT CORRETTO (stessa cartella)

class CharacterSelection extends StatelessWidget {
  const CharacterSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A15),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: const Text(
          'CHOOSE YOUR POLITICAL PATH',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildCharacterGrid(context)),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFF151525),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_search,
              size: 40,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'SELECT YOUR POLITICAL IDENTITY',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your choice defines your starting deck and political influence',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterGrid(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildCharacterCard(context, 'Corrupt Politician', '🤵‍♂️', Colors.red, 'Corrupt Politician'),
        _buildCharacterCard(context, 'Attack Journalist', '📰', Colors.blue, 'Attack Journalist'),
        _buildCharacterCard(context, 'Activist', '✊', Colors.green, 'Activist'),
        _buildCharacterCard(context, 'Bureaucrat', '📋', Colors.purple, 'Bureaucrat'),
      ],
    );
  }

  Widget _buildCharacterCard(BuildContext context, String name, String emoji, Color color, String characterName) {
    return GestureDetector(
      onTap: () => _confirmCharacterSelection(context, characterName),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCharacterSelection(BuildContext context, String characterName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('CONFIRM SELECTION', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(characterName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 10),
            const Text('Begin your political career?', style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame(context, characterName);
            },
            child: const Text('BEGIN', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ✅ CORRETTO: Rimossa la dipendenza da FighterClass (inesistente)
  void _startGame(BuildContext context, String characterName) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => RunMapScreen(
        fighterName: characterName,
        currentFloor: 0,
        currentNodeId: 'am_0',
        visitedNodeIds: [],
        region: 'america',
        fighterClass: characterName.toLowerCase().replaceAll(' ', '_'), // ✅ SOLO QUESTA RIGA AGGIUNTA
      ),
    ),
  );
}

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF121225),
      child: const Text(
        '⚠️ Your choice is permanent for this run. Choose wisely!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.amber,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}