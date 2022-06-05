// To parse this JSON data, do
//
//     final casosModel = casosModelFromMap(jsonString);

import 'dart:convert';

class Caso {
    Caso({
        required this.idCasoCliente,
        required this.nombreEmpresa,
        required this.agencia,
        required this.estado,
        required this.fechaHoraEstado,
        required this.usuarioApertura,
        required this.supervisorAgencia,
        required this.fechaEjecucionDesde,
        required this.fechaEjecucionHasta,
        required this.observacionResolucion,
        required this.rubros,
        required this.estadoCaso,
        required this.motivos
    });

    String idCasoCliente;
    String nombreEmpresa;
    String agencia;
    String estado;
    String fechaHoraEstado;
    String usuarioApertura;
    String supervisorAgencia;
    DateTime fechaEjecucionDesde;
    DateTime fechaEjecucionHasta;
    String observacionResolucion;
    String rubros;
    String estadoCaso;
    String motivos;

    factory Caso.fromJson(String str) => Caso.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Caso.fromMap(Map<String, dynamic> json) => Caso(
        idCasoCliente: json["id_caso_cliente"],
        nombreEmpresa: json["nombre_empresa"],
        agencia: json["agencia"],
        estado: json["estado"],
        fechaHoraEstado: json["fecha_hora_estado"],
        usuarioApertura: json["usuario_apertura"],
        supervisorAgencia: json["supervisor_agencia"],
        fechaEjecucionDesde: DateTime.parse(json["fecha_ejecucion_desde"]),
        fechaEjecucionHasta: DateTime.parse(json["fecha_ejecucion_hasta"]),
        observacionResolucion: json["observacion_resolucion"],
        rubros: json["rubros"],
        estadoCaso: json["estado_caso"],
        motivos: json["motivos"]
    );

    Map<String, dynamic> toMap() => {
        "id_caso_cliente": idCasoCliente,
        "nombre_empresa": nombreEmpresa,
        "agencia": agencia,
        "estado": estado,
        "fecha_hora_estado": fechaHoraEstado,
        "usuario_apertura": usuarioApertura,
        "supervisor_agencia": supervisorAgencia,
        "fecha_ejecucion_desde": fechaEjecucionDesde.toIso8601String(),
        "fecha_ejecucion_hasta": fechaEjecucionHasta.toIso8601String(),
        "observacion_resolucion": observacionResolucion,
        "rubros": rubros,
        "estado_caso": estadoCaso,
        "motivos": motivos
    };
}
