import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:geco/models/caso.dart';

class CasosService extends ChangeNotifier {
  
  final _baseUrl = 'www.gecoecuador.com';
  final _partUrl = '/servidor/servicios/appservice/';

  final storage = const FlutterSecureStorage();

  final List<Caso> casos = [];
  late Caso selectedCaso;

  bool isLoading = true;
  bool isSaving = false;

  //Seteo empresa
  String _empresa = '0';
  String get empresa => _empresa;
  
  set empresa(String value){
    _empresa = value;
    notifyListeners();
  }

  //Seteo motivo
  String _motivo = '0';
  String get motivo => _motivo;
  
  set motivo(String value){
    _motivo = value;
    notifyListeners();
  }

  //Seteo tipo de botón
  String _tipoBoton = '';
  String get tipoBoton => _tipoBoton;
  
  set tipoBoton(String value){
    _tipoBoton = value;
    notifyListeners();
  }

  //LOADCASOS
  //Funcion que trae todos los casos
  Future<List<Caso>> loadCasos(String estado) async {

    if(_empresa == '0' || estado == '') {
      return casos;
    }

    isLoading = true;
    notifyListeners();

    String token = await storage.read(key: 'token') ?? '';
    String pin = await storage.read(key: 'pin') ?? '';

    final Map<String, String> params = {
      'token': token,
      'empresa': _empresa,
      'estado': estado,
      'pin': pin
    };

    final url = Uri.https(_baseUrl, '${_partUrl}casos', params);
    final resp = await http.get(url);

    final List<dynamic> casosMap = json.decode(resp.body);

    casos.clear();

    for (var element in casosMap) { 
      final tempCaso = Caso.fromMap(element);
      casos.add(tempCaso); 
    }

    isLoading = false;
    notifyListeners();

    return casos;
  }

  //CAMBIAESTADO
  //Graba el nuevo estado en el caso seleccionado
  Future<String> cambiaEstado(String idCaso, String nuevoEstado, String motivo, int index) async {

    if(_empresa == '0' || nuevoEstado == '' || idCaso == '') {
      return '';
    }

    isSaving = true;
    notifyListeners();

    String token = await storage.read(key: 'token') ?? '';
    String pin = await storage.read(key: 'pin') ?? '';

    final Map<String, String> params = {
      'token': token,
      'empresa': _empresa,
      'idCaso': idCaso,
      'estado': nuevoEstado,
      'motivo': motivo,
      'pin': pin
    };

    final url = Uri.https(_baseUrl, '${_partUrl}cambiaestado');
    final resp = await http.post(url, body: json.encode(params));

    final info = json.decode(resp.body);

    if(info['success'] == false){
      isSaving = false;
      notifyListeners();
      return info['error'];
    }
    else
    {
      casos[index].estadoCaso = nuevoEstado;
      isSaving = false;
      notifyListeners();
      return '';
    }
  }

}