//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class UsuarioFormProvider extends ChangeNotifier {
  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String correo = '';
  String password = '';
  String nombre = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$correo - $password - $nombre');

    return formKey.currentState?.validate() ?? false;
  }
}
