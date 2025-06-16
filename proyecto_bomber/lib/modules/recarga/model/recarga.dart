import 'package:json_annotation/json_annotation.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';

part 'recarga.g.dart';

@JsonSerializable()
class Recarga {
  @JsonKey(name: 'idRecarga')
  int? id;
  @JsonKey(name: 'fecha_hora')
  DateTime? fecha_hora;
  String? descripcion;
  @JsonKey(name: 'cantidad_litros')
  double? cantidad_litros;

  Movil? movil;
  Bombero? bombero;
  Deposito? depositoAgua;

  Recarga({
    this.id,
    this.fecha_hora,
    this.descripcion,
    this.cantidad_litros,
    this.movil,
    this.bombero,
    this.depositoAgua,
  });

  factory Recarga.fromJson(Map<String, dynamic> json) =>
      _$RecargaFromJson(json);
  Map<String, dynamic> toJson() => _$RecargaToJson(this);

  Recarga copyWith({
    int? id,
    DateTime? fecha_hora,
    String? descripcion,
    double? cantidad_litros,
    Movil? movil,
    Bombero? bombero,
    Deposito? depositoAgua,
  }) {
    return Recarga(
      id: id ?? this.id,
      fecha_hora: fecha_hora ?? this.fecha_hora,
      descripcion: descripcion ?? this.descripcion,
      cantidad_litros: cantidad_litros ?? this.cantidad_litros,
      movil: movil ?? this.movil,
      bombero: bombero ?? this.bombero,
      depositoAgua: depositoAgua ?? this.depositoAgua,
    );  
  }

  factory Recarga.novo() => Recarga(
    id: null,
    fecha_hora: null,
    descripcion: null,
    cantidad_litros: null,
    movil: null,
    bombero: null,
    depositoAgua: null,
  );

  String toString() {
    return 'Recarga(id: $id, fecha_hora: $fecha_hora, descripcion: $descripcion, cantidad_litros: $cantidad_litros, movil: $movil, bombero: $bombero, depositoAgua: $depositoAgua)';
  }


}
