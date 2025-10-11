//flutter pub add flutter_secure_storage

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _baseUrlLocal = 'localhost:8081';

  final String _firebaseToken = 'AIzaSyBcytoCbDUARrX8eHpcR-Bdrdq0yUmSjf8';

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'x-token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> loginLocal(String correo, String password) async {


   final Map<String, dynamic> authData = {
     'correo': correo,
     'password': password,
     //'returnSecureToken': true,
   };


   final url = Uri.http(_baseUrlLocal, '/api/usuarios/login', {
     //'key': _firebaseToken,
   });


   final resp = await http.post(
     url,
     headers: {
       'Content-Type': 'application/json'
     },
     body: json.encode(authData));


   final Map<String, dynamic> decodedResp = json.decode(resp.body);


  //  print("Respuesta:");
  //  print(decodedResp);
  
  //  print(decodedResp.containsKey('token'));
  //  print(decodedResp.containsKey('ok'));



   // Caso exitoso
    if (decodedResp['ok'] == true && decodedResp.containsKey('token')) {
      await storage.write(key: 'x-token', value: decodedResp['token']);
      return null;
    } 
    // Caso de error con errors[]
    else if (decodedResp.containsKey('errors')) {
      // Extraer el primer mensaje de error
      final firstError = decodedResp['errors'][0];
      return firstError['msg'] ?? 'Error desconocido';
    } 
    // Caso genérico
    else {
      return decodedResp['msg'] ?? 'Error desconocido al iniciar sesión';
    }
  }

Future<String?> createUserLocal(String nombre, String correo, String password) async {
  final Map<String, dynamic> userData = {
    "nombre": nombre,
    "correo": correo,
    "password": password,
    "rol": "USER_ROLE",
    "img": "default.png",
    "google": false
  };

  final url = Uri.http(_baseUrlLocal, '/api/usuarios');

  try {
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print("Respuesta de creación: $decodedResp");

    if (decodedResp.containsKey('usuario')) {
      // ✅ Usuario creado exitosamente
      return null;
    }

    if (decodedResp.containsKey('msg')) {
      return decodedResp['msg'];
    }

    if (decodedResp.containsKey('errors')) {
      final List<dynamic> errors = decodedResp['errors'];
      if (errors.isNotEmpty && errors.first.containsKey('msg')) {
        return errors.first['msg'];
      }
    }

    return 'Error inesperado al crear usuario.';

  } catch (e) {
    print('Error en createUserLocal: $e');
    return 'No se pudo conectar con el servidor';
  }
}


  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }



}
