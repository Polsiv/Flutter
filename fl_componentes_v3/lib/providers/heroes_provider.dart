import 'package:flutter/material.dart';
import 'package:fl_componentes/models/hero_model.dart';
import 'package:fl_componentes/services/heroes_service.dart';

class HeroesProvider extends ChangeNotifier {
  final HeroesService heroesService = HeroesService();
  List<HeroModel> heroes = [];

  Future<void> loadHeroes() async {
    heroes = await heroesService.getHeroes();
    notifyListeners();
  }

 Future<Map<String, dynamic>> addHero(HeroModel hero) async {
  return await heroesService.createHero(hero);
  }


  Future<Map<String, dynamic>> updateHero(HeroModel hero) async {
    final result = await heroesService.updateHero(hero);
    await loadHeroes();
    return result;
  }


 Future<String?> deleteHero(int id) async {
  final result = await heroesService.deleteHero(id);
  if (result == null) {
    await loadHeroes();
    }
  return result;
  }
}
