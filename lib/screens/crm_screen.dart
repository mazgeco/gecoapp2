import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/screens/loading_screen.dart';
import 'package:geco/services/services.dart';

class CRMScreen extends StatelessWidget {
  const CRMScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final casosService = Provider.of<CasosService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(authService.empresasAuth.isEmpty) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            casosService.empresa = '0';
            //authService.logout();
            Navigator.pushReplacementNamed(context, 'modulos');
          }
        ),
      ),
      body: _empresasForm(context, authService)
    );
  }

  Widget _empresasForm(BuildContext context, AuthService authService){

    final casosService = Provider.of<CasosService>(context);
    
    return Form(
      child: Column(
        children: [
          _crearDropDown(authService.empresasAuth, casosService),
          const SizedBox(height: 40),
          (authService.botonesAuth.contains('A'))
          ? _boton(context, 'Casos aprobar', 'S', casosService, authService)
          : const SizedBox(height: 0),
          (authService.botonesAuth.contains('P'))
          ? _boton(context, 'Casos pre-cerrar', 'P', casosService, authService)
          : const SizedBox(height: 0),
          (authService.botonesAuth.contains('R'))
          ? _boton(context, 'Rubros', 'R', casosService, authService)
          : const SizedBox(height: 0),
          (authService.botonesAuth.contains('E'))
          ? _boton(context, 'Encuesta', 'E', casosService, authService)
          : const SizedBox(height: 0)
        ],
      ),
    );
  }

  List<DropdownMenuItem<Object>> _getOpcionesDropDown(List<dynamic> empresas) {
    List<DropdownMenuItem<Object>> lista = [];

    for (var i=0; i<empresas.length; i++) {
      lista.add(
        DropdownMenuItem(
          value: empresas[i]['codigo_empresa'],
          child: Text(empresas[i]['nombre_empresa'])
        )
      );
    }

    return lista;
  }

  Widget _crearDropDown(List<dynamic> empresas, CasosService casosService) {
    
    return Row(
      children: [
        const SizedBox(width: 5),
        const Icon(Icons.account_balance),
        const SizedBox(width: 5),
        DropdownButton(
          value: casosService.empresa,
          items: _getOpcionesDropDown(empresas),
          onChanged: (opt) {
            casosService.empresa = opt.toString();
          },
        )
      ]
    );
  }

  Widget _boton(BuildContext context, String titulo, String tipoBoton, CasosService casosService, AuthService authService){
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Colors.blueAccent,
      elevation: 0
      );
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: style,
        onPressed: (){
          if(casosService.empresa == '0'){
            NotificationsService.showSnackBar('Seleccione una empresa');
          }else{
            switch (tipoBoton) {
              case 'S':
                casosService.tipoBoton = tipoBoton;
                casosService.loadCasos(tipoBoton);
                Navigator.pushReplacementNamed(context, 'casos');
                break;
              case 'P':
                casosService.tipoBoton = tipoBoton;
                casosService.loadCasos(tipoBoton);
                Navigator.pushReplacementNamed(context, 'casos');
                break;
              default:
            }
          }
        },
        child: Text(titulo)
      ),
    );
  }
}