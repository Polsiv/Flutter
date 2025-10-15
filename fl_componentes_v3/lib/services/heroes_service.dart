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


  Future<Map<String, dynamic>> createHero(HeroModel hero) async {
  final url = Uri.http(_baseUrl, '/api/heroes');
    final headers = await _headers();

    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(hero.toJson()),
    );

    print(resp.body);

    try {
      final data = json.decode(resp.body);

      if (resp.statusCode == 201 || data['ok'] == true) {
        notifyListeners();
      }

      return data; // <-- devolvemos la respuesta completa del backend
    } catch (e) {
      return {
        'ok': false,
        'msg': 'Error al procesar la respuesta del servidor',
        'error': e.toString(),
      };
    }
  }


  Future<Map<String, dynamic>> updateHero(HeroModel hero) async {
    final url = Uri.http(_baseUrl, '/api/heroes/${hero.id}');
    final headers = await _headers();

    final resp = await http.put(
      url,
      headers: headers,
      body: json.encode(hero.toJson()),
    );

    try {
      final data = json.decode(resp.body);

      if (resp.statusCode == 200 || data['ok'] == true) {
        notifyListeners();
      }

      return data; // 🔹 devolvemos la respuesta completa del backend
    } catch (e) {
      return {
        'ok': false,
        'msg': 'Error al procesar la respuesta del servidor',
        'error': e.toString(),
      };
    }
  }



  Future<String?> deleteHero(int id) async {
    final url = Uri.http(_baseUrl, '/api/heroes/$id');
    final headers = await _headers();

    final resp = await http.delete(url, headers: headers);

    if (resp.statusCode == 200 || resp.statusCode == 204) {
      return null; // éxito
    } else {
      return 'Error al eliminar héroe';
    }
  }
}
