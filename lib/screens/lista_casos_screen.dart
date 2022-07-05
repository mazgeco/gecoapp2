import 'package:flutter/material.dart';
import 'package:geco/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import 'package:geco/services/services.dart';
import 'package:geco/screens/caso_screen.dart';

class ListaCasosScreen extends StatelessWidget {
  const ListaCasosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final casosService = Provider.of<CasosService>(context);

    if(casosService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: (casosService.tipoBoton == 'S')
        ? const Text('Casos por aprobar')
        : (casosService.tipoBoton == 'P')
          ? const Text('Casos para pre-cerrar')
          : const Text('No definido'),
        elevation: 1,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pushReplacementNamed(context, 'crm')
        )
      ),
      body: (casosService.casos.isEmpty)
      ? const Text('No existen datos')
      : (casosService.isSaving)
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: casosService.casos.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: (casosService.casos[index].estadoCaso == casosService.tipoBoton)
              ? CasoScreen(caso: casosService.casos[index], index: index)
              : const SizedBox(height: 0)
              )
          )
    );
  }
}