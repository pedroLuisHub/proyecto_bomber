import 'package:json_annotation/json_annotation.dart';

import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';

part 'abastecimiento.g.dart';

@JsonSerializable()
class Abastecimiento {
  @JsonKey(name: 'id_abastecimiento')
  int? id;
  @JsonKey(name: 'fecha_inicio')
  DateTime? fechaInicio;
  @JsonKey(name: 'fecha_finalizacion')
  DateTime? fechaFin;
  @JsonKey(name: 'cant_litros')
  double? cantLitros;
  
  String? descripcion;
  @JsonKey(name: 'cant_viajes')
  int? cantViajes;

  Movil? movil;
  Bombero? bombero;
  Deposito? depositoAgua;

  Abastecimiento({
    this.id,
    this.fechaInicio,
    this.fechaFin,
    this.cantLitros,
    this.descripcion,
    this.cantViajes,
    this.movil,
    this.bombero,
    this.depositoAgua,
  });

  factory Abastecimiento.fromJson(Map<String, dynamic> json) =>
      _$AbastecimientoFromJson(json);
  Map<String, dynamic> toJson() => _$AbastecimientoToJson(this);

  Abastecimiento copyWith({
    int? id,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    double? cantLitros,
    String? descripcion,
    int? cantViajes,
    Movil? movil,
    Bombero? bombero,
    Deposito? depositoAgua,
  }) {
    return Abastecimiento(
      id: id ?? this.id,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      cantLitros: cantLitros ?? this.cantLitros,
      descripcion: descripcion ?? this.descripcion,
      cantViajes: cantViajes ?? this.cantViajes,
      movil: movil ?? this.movil,
      bombero: bombero ?? this.bombero,
      depositoAgua: depositoAgua ?? this.depositoAgua,
    );
  }

  factory Abastecimiento.novo() => Abastecimiento(
    id: null,
    fechaInicio: null,
    fechaFin: null,
    cantLitros: null,
    descripcion: null,
    cantViajes: null,
    movil: null,
    bombero: null,
    depositoAgua: null,
  );

  String toString() {
    return 'Abastecimiento(id: $id, fechaInicio: $fechaInicio, fechaFin: $fechaFin, cantLitros: $cantLitros, descripcion: $descripcion, cantViajes: $cantViajes, movil: $movil, bombero: $bombero, depositoAgua: $depositoAgua)';
  }
}
