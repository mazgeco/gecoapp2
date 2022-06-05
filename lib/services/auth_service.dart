import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthService extends ChangeNotifier {
  
  final _baseUrl = 'www.gecoecuador.com';
  final _partUrl = '/servidor/servicios/appservice/';

  final storage = const FlutterSecureStorage();

  String userAuth = '';
  String pinAuth = '';
  List<dynamic> empresasAuth = [];
  String modulosAuth = '';
  String botonesAuth = '';

  bool isLoading = true;

  Future<String?> login(String usuario, String password, String pin) async {
    isLoading = true;
    final Map<String, dynamic> authDate = {
      'usuario': usuario,
      'password': password,
      'pin': pin
    };
    final url = Uri.https(_baseUrl, '${_partUrl}login');
    final resp = await http.post(url, body: json.encode(authDate));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    String error = '';

    if(decodeResp.containsKey('idToken')){
      //Hay que guardarlo en un lugar seguro
      userAuth = usuario;
      pinAuth = pin;
      empresasAuth = decodeResp['empresas'];
      botonesAuth = decodeResp['botones'];
      modulosAuth = decodeResp['modulos'];
      await storage.write(key: 'token', value: decodeResp['idToken']);
      await storage.write(key: 'pin', value: pin);
      error = '';
    }else{
      error = decodeResp['error'];
    }
    isLoading = false;
    notifyListeners();
    
    return error;
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'empresa');
    await storage.delete(key: 'pin');
    return;
  }

  Future<String> readToken() async {
    isLoading = true;
    String token = await storage.read(key: 'token') ?? '';
    String pin = await storage.read(key: 'pin') ?? '';
    if(token.isNotEmpty && pin.isNotEmpty){
      final Map<String, dynamic> authDate = {
        'token': token,
        'pin': pin
      };
      final url = Uri.https(_baseUrl, '${_partUrl}validatoken');
      final resp = await http.post(url, body: json.encode(authDate));
      final Map<String, dynamic> decodeResp = json.decode(resp.body);

      if(decodeResp.containsKey('usuario')){
        userAuth = decodeResp['usuario'];
        pinAuth = pin;
        empresasAuth = decodeResp['empresas'];
        botonesAuth = decodeResp['botones'];
        modulosAuth = decodeResp['modulos'];
      }
      
      if(userAuth.isEmpty) {
        token = '';
        await storage.delete(key: 'token');
        await storage.delete(key: 'pin');
      }
    }
    
    isLoading = false;
    notifyListeners();

    return token;
  }

}