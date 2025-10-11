import '../core/api_config.dart';
import '../core/http_client.dart';
import '../models/multimedia.dart';

class MultimediaService {
  final HttpClient client;

  MultimediaService(this.client);

  Future<List<Multimedia>> fetchByHeroe(String heroeId) async {
    final data = await client.getJson(ApiConfig.multimediasByHeroe(heroeId));
    final list = _extractList(data);

    return list
        .map((e) => Multimedia.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<List<Multimedia>> fetchAll() async {
    final data = await client.getJson(ApiConfig.multimedias());
    final list = _extractList(data);

    return list
        .map((e) => Multimedia.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  List _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map && data['resp'] is List) return data['resp'] as List;
    if (data is Map && data['multimedias'] is List) {
      return data['multimedias'] as List;
    }
    throw Exception('Formato inesperado en multimedias');
  }
}
