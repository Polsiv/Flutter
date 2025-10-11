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

  Future<void> addHero(HeroModel hero) async {
    await heroesService.createHero(hero);
    await loadHeroes();
  }

  Future<void> updateHero(HeroModel hero) async {
    await heroesService.updateHero(hero);
    await loadHeroes();
  }

  Future<void> deleteHero(int id) async {
    await heroesService.deleteHero(id);
    await loadHeroes();
  }
}
