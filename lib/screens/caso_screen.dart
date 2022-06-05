import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:geco/models/caso.dart';
import 'package:geco/services/services.dart';

class CasoScreen extends StatelessWidget {
  
  final Caso caso;
  final int index;

  const CasoScreen({Key? key, required this.caso, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
        decoration: _cardBorders(),
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 10, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _muestraDato('Código: ', caso.idCasoCliente, 15, size, false),
              _muestraDato('', caso.nombreEmpresa, 18, size, true),
              _muestraDato('', caso.agencia, 18, size, true),
              _muestraDato('Apertura: ', caso.usuarioApertura, 15, size, false),
              _muestraDato('Supervisor: ', caso.supervisorAgencia, 15, size, false),
              _muestraDato('Estado: ', caso.estado, 15, size, false),
              (caso.estadoCaso == 'S')
              ? _muestraDato('Desde: ', caso.fechaEjecucionDesde.toString(), 15, size, false)
              : _muestraDato('Fecha estado: ', caso.fechaHoraEstado.toString(), 15, size, false),
              (caso.estadoCaso == 'S')
              ? _muestraDato('Hasta: ', caso.fechaEjecucionHasta.toString(), 15, size, false)
              : const SizedBox(height: 0),
              _muestraDato('Rubros:', '', 15, size, false),
              _muestraDato('', caso.rubros, 15, size, false),
              (caso.estadoCaso == 'S')
              ? _muestraDato('Resolución: ', caso.observacionResolucion, 15, size, false)
              : const SizedBox(height: 0),
              const Divider(),
              Row(
                children: [
                  MaterialButton(
                    child: (caso.estadoCaso == 'S')
                    ? const Text('Aprobar')
                    : (caso.estadoCaso == 'P')
                      ? const Text('Pre-cerrar')
                      : const Text('No definido'),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: (){
                      _mostrarAlert(
                        context,
                        caso.estadoCaso, 
                        caso.idCasoCliente,
                        '',
                        false
                      );
                    }
                  ),
                  const SizedBox(width: 10),
                  (caso.estadoCaso == 'S')
                  ? MaterialButton(
                    child: const Text('No aplica'),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: (){
                      _mostrarAlert(
                        context,
                        caso.estadoCaso, 
                        caso.idCasoCliente,
                        caso.motivos,
                        true
                      );
                    }
                  )
                  : const SizedBox(width: 0)
                ],
              )
            ],
          ),
        ),
      );
  }

  Widget _muestraDato(String etiqueta, String texto, double tamLetra, double size, bool isBold)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text(
          etiqueta,
          style: TextStyle(
            fontSize: tamLetra,
            color: Colors.grey,
            fontWeight: FontWeight.bold
          )
        ),
        Flexible(
          child: Text(
            texto,
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: tamLetra, 
              color: Colors.grey,
              fontWeight: isBold
              ? FontWeight.bold
              : FontWeight.normal
            )
          ),
        ),
      ],
    );
  }

  void _mostrarAlert(BuildContext context, String estado, String idCaso, String motivos, bool noaplica) {

    String titulo = '', mensaje = '', accion = '';

    if(noaplica){
       titulo = 'Escoja el motivo';
       mensaje = motivos;
       accion = 'NA';
    }
    else{
      switch (estado) {
        case 'S':
          titulo = 'Aprobar caso';
          mensaje = '¿Está seguro de que desea aprobar el caso $idCaso?';
          accion = 'APR';
          break;
        case 'P':
          titulo = 'Pre-cerrar caso';
          mensaje = '¿Está seguro de que desea pre-cerrar el caso $idCaso?';
          accion = 'PRE';
          break;
        default:
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {

        final casosService =  Provider.of<CasosService>(context);

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (accion != 'NA')
              ? Text(mensaje)
              : DropdownButton(
                  style: const TextStyle(color: Colors.black, fontSize: 12, overflow: TextOverflow.ellipsis),
                  value: casosService.motivo,
                  items: _getOpcionesDropDown(mensaje),
                  onChanged: (opt) {
                    casosService.motivo = opt.toString();
                  },
                )
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Si'),
              onPressed: () {
                switch (accion) {
                  case 'APR':
                    casosService.cambiaEstado(idCaso, 'A', '', index);
                    Navigator.of(context).pop();
                    break;
                  case 'PRE':
                    casosService.cambiaEstado(idCaso, 'B', '', index);
                    Navigator.of(context).pop();
                    break;
                  case 'NA':
                    if(casosService.motivo != '0'){
                      casosService.cambiaEstado(idCaso, 'X', casosService.motivo, index);
                      casosService.motivo = '0';
                      Navigator.of(context).pop();
                    }
                    break;
                  default:
                    
                }
              }
            ),
            TextButton(
              child: const Text('No'),
              onPressed: (){
                casosService.motivo = '0';
                Navigator.of(context).pop();
              }
            )
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<Object>> _getOpcionesDropDown(String motivos) {
    List<DropdownMenuItem<Object>> lista = [];

    List<String> temp = motivos.split('|');
    List<String> aux = [];


    for (var item in temp) {
      aux = item.split('-');
      lista.add(
        DropdownMenuItem(
          value: aux[0],
          child: Text(aux[1]),
        )
      );
    }

    return lista;
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}