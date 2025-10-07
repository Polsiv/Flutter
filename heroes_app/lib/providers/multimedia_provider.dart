import 'package:flutter/foundation.dart';
import '../models/multimedia.dart';
import '../services/multimedia_service.dart';

enum MediaState { idle, loading, error }

class MultimediaProvider extends ChangeNotifier {
  final MultimediaService _service;
  MultimediaProvider(this._service);

  // private backing fields
  MediaState _state = MediaState.idle;
  String? _errorMessage;
  List<Multimedia> items = [];

  // public/read-only API used by your widget
  MediaState get state => _state;
  bool get loading => _state == MediaState.loading;
  String? get error => _errorMessage;

  Future<void> loadByHero(String heroId) async {
    _state = MediaState.loading;
    _errorMessage = null;
    items = [];
    notifyListeners();

    try {
      items = await _service.fetchByHeroe(heroId);
      _state = MediaState.idle;
    } catch (e) {
      _state = MediaState.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
