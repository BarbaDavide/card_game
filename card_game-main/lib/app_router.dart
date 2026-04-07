// lib/app_router.dart

import 'package:flutter/material.dart';

class AppRouter {
  // Definizione costanti per i nomi delle route
  static const String home = '/';
  static const String collection = '/collection';
  static const String merchant = '/merchant';
  static const String map = '/map';
  static const String battle = '/battle';

  // Generatore di route - completamente autonomo senza import di screen esterni
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen('🏠 HOME', 'Main Menu', Colors.blue),
        );
      
      case collection:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen('📚 COLLECTION', 'Card Collection', Colors.purple),
        );
      
      case merchant:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen('🏪 MERCHANT', 'Shop Screen', Colors.amber),
        );
      
      case map:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen('🗺️ MAP', 'Path Selection', Colors.green),
        );
      
      case battle:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen('⚔️ BATTLE', 'Combat Screen', Colors.red),
        );
      
      default:
        return _buildRoute(
          settings,
          _buildPlaceholderScreen(
            '❌ NOT FOUND',
            'Route: ${settings.name}',
            Colors.grey,
          ),
        );
    }
  }

  Route _buildRoute(RouteSettings settings, Widget child) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => child,
    );
  }

  Widget _buildPlaceholderScreen(String title, String subtitle, Color color) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final context = _navigatorKey.currentContext;
            if (context != null) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForTitle(title),
                size: 50,
                color: color,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Screen under development',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final context = _navigatorKey.currentContext;
                if (context != null) {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('BACK TO MENU'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    if (title.contains('HOME')) return Icons.home;
    if (title.contains('COLLECTION')) return Icons.collections_bookmark;
    if (title.contains('MERCHANT')) return Icons.store;
    if (title.contains('MAP')) return Icons.map;
    if (title.contains('BATTLE')) return Icons.flash_on; // Icona valida per combattimento
    return Icons.error;
  }

  // Chiave globale per navigazione sicura
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}