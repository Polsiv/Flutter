import 'package:flutter/foundation.dart';
import '../models/heroe.dart';
import '../services/heroes_service.dart';
import '../core/http_client.dart';

class HeroesProvider extends ChangeNotifier {
  final HeroesService _service = HeroesService(HttpClient());

  List<Heroe> _heroes = [];
  bool _loading = false;
  String? _error;

  List<Heroe> get heroes => _heroes;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadHeroes() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _heroes = await _service.fetchHeroes();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
