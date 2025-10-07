import 'package:flutter/material.dart';
import '../screens/heroes_list_screen.dart';
import '../screens/heroe_detail_screen.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const heroeDetail = '/heroe';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => const HeroesListScreen(),
        );

      case heroeDetail:
        final args = settings.arguments as Map<String, dynamic>;
        final String heroeId = args['id'] as String;

        return MaterialPageRoute(
          builder: (_) => HeroeDetailScreen(heroeId: heroeId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HeroesListScreen(),
        );
    }
  }
}
