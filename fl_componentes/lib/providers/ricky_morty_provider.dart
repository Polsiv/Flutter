import 'package:fl_componentes/models/ricky_morty_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RickMortyProvider extends ChangeNotifier {


 final String _baseUrl = 'rickandmortyapi.com';
  List<Character> onDisplayCharacter = [];


 RickMortyProvider(){
   getOnDisplayCharacters();
 }

 getOnDisplayCharacters() async{

   var url = Uri.https(_baseUrl, 'api/character', {
     'page': '1'
   });

   final response = await http.get(url);
   final rickyMortyResponse = RickyMortyResponse.fromJson(response.body);
   onDisplayCharacter = rickyMortyResponse.results;
   notifyListeners();
 }
}




