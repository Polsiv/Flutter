import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fl_componentes/models/hero_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class HeroesService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8081';
  final List<HeroModel> heroes = [];

  final storage = const FlutterSecureStorage();

  bool isLoading = false;

  // auxiliar para obtener el token
  Future<Map<String, String>> _headers() async {
    final token = await storage.read(key: 'x-token');
    return {
      'Content-Type': 'application/json',
      'x-token': token ?? '',
    };
  }

  Future<List<HeroModel>> getHeroes() async {
      isLoading = true;
      notifyListeners();

      final url = Uri.http(_baseUrl, '/api/heroes');
      final headers = await _headers();

      final resp = await http.get(url, headers: headers);
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      final List<dynamic> data = decodedResp['data'];

      heroes
        ..clear()
        ..addAll(data.map((h) => HeroModel.fromJson(h)).toList());

      isLoading = false;
      notifyListeners();

      return heroes;
}


  Future<HeroModel?> getHeroById(int id) async {
    final url = Uri.http(_baseUrl, '/api/heroes/$id');
    final headers = await _headers();

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode != 200) return null;

    final Map<String, dynamic> decoded = json.decode(resp.body);
    final data = decoded['data'];

    return HeroModel.fromJson(data);
}


  Future<String?> createHero(HeroModel hero) async {
    final url = Uri.http(_baseUrl, '/api/heroes');
    final headers = await _headers();

    final resp = await http.post(url,
        headers: headers, body: json.encode(hero.toJson()));

    if (resp.statusCode == 201) {
      notifyListeners();
      return null;
    } else {
      return 'Error al crear el héroe';
    }
  }

  Future<String?> updateHero(HeroModel hero) async {
    final url = Uri.http(_baseUrl, '/api/heroes/${hero.id}');
    final headers = await _headers();

    final resp = await http.put(url,
        headers: headers, body: json.encode(hero.toJson()));

    if (resp.statusCode == 200) {
      notifyListeners();
      return null;
    } else {
      return 'Error al actualizar el héroe';
    }
  }

  Future<String?> deleteHero(int id) async {
    final url = Uri.http(_baseUrl, '/api/heroes/$id');
    final headers = await _headers();

    final resp = await http.delete(url, headers: headers);

    if (resp.statusCode == 200 || resp.statusCode == 204) {
      heroes.removeWhere((h) => h.id == id);
      notifyListeners();
      return null;
    } else {
      return 'Error al eliminar el héroe';
    }
  }
}
