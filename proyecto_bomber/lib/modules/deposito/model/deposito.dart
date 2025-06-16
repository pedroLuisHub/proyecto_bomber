import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposito.g.dart';

@JsonSerializable()
class Deposito {
  @JsonKey(name: 'id_deposito_agua')
  int? id;
  String? latitud;
  String? longitud;
  double? capacidad;
  String? estado;

  Ciudadano? ciudadano;

  Deposito({
    this.id,
    this.latitud,
    this.longitud,
    this.capacidad,
    this.estado,
    this.ciudadano,
  });

  factory Deposito.fromJson(Map<String, dynamic> json) =>
      _$DepositoFromJson(json);
  Map<String, dynamic> toJson() => _$DepositoToJson(this);

  Deposito copyWith({
    int? id,
    String? latitud,
    String? longitud,
    double? capacidad,
    String? estado,
    Ciudadano? ciudadano,
  }) {
    return Deposito(
      id: id ?? this.id,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      capacidad: capacidad ?? this.capacidad,
      estado: estado ?? this.estado,
      ciudadano: ciudadano ?? this.ciudadano,
    );
  }

  factory Deposito.novo() => Deposito(
    id: null,
    latitud: null,
    longitud: null,
    capacidad: null,
    estado: null,
    ciudadano: null,
  );



  String toString() {
    return 'Deposito(id: $id, latitud: $latitud, longitud: $longitud, capacidad: $capacidad, estado: $estado, ciudadano: $ciudadano)';
  }
}
