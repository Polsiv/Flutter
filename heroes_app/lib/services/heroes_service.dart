import '../core/api_config.dart';
import '../core/http_client.dart';
import '../models/heroe.dart';
import 'package:flutter/foundation.dart';

class HeroesService {
  final HttpClient client;

  HeroesService(this.client);

  Future<List<Heroe>> fetchHeroes() async {
    final data = await client.getJson(ApiConfig.heroes());
    final list = _extractList(data);

    if (list.isNotEmpty) {
      debugPrint('[Heroes] ejemplo: ${list.first}');
    }

    return list
        .map((e) => Heroe.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<Heroe> fetchHeroeById(String id) async {
    final data = await client.getJson(ApiConfig.heroeById(id));
    if (data is Map<String, dynamic>) {
     
      // el API puede devolver directamente el objeto o bajo "resp"
      final maybe = data['resp'];
      final Map<String, dynamic> obj =
          maybe is Map ? Map<String, dynamic>.from(maybe) : data;
      return Heroe.fromJson(obj);
    }
    throw Exception('Formato inesperado en /heroes/$id');
  }

  List _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map && data['resp'] is List) return data['resp'] as List;
    if (data is Map && data['heroes'] is List) return data['heroes'] as List;
    throw Exception('Formato inesperado en /heroes');
  }
}
