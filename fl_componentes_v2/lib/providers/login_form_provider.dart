import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LoginFormProvider extends ChangeNotifier {

 final String _baseUrl = 'localhost:8081';


  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email    = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidForm() {

    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;


  }

validarLogin() async{
    print('getOnDisplayCharacters');


    //https://rickandmortyapi.com/api/character
    var url = Uri.http(_baseUrl, 'api/usuarios/login', {
      //'page': '1'
    });

    final response = await http.post(url,
    body: jsonEncode({
      'correo': email,
      'password':password,
    }),);

    print(response);
    
    final Map<String,dynamic> decodeData = json.decode(response.body);

    //final rickyMortyResponse = RickyMortyResponse.fromJson(response.body);


    //if (response.statusCode != 200) return('error');

    print(decodeData['ok']);
    //print(rickyMortyResponse.results[0].name);

    //onDisplayCharacter = rickyMortyResponse.results;

    notifyListeners();

  }


}