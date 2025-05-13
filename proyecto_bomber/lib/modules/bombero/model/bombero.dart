// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'bombero.g.dart';

@JsonSerializable()
class Bombero {
  @JsonKey(name: 'id_bombero') // Coincide con el nombre del campo en el backend
  int? id;
  String? documento;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? direccion;
  String? cargo;

  Bombero({
    this.id,
    this.documento,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.direccion,
    this.cargo,
  });

  factory Bombero.fromJson(Map<String, dynamic> json) =>
      _$BomberoFromJson(json);
  Map<String, dynamic> toJson() => _$BomberoToJson(this);

  Bombero copyWith({
    int? id,
    String? documento,
    String? nombre,
    String? apellido,
    String? telefono,
    String? email,
    String? direccion,
    String? cargo,
  }) {
    return Bombero(
      id: id ?? this.id,
      documento: documento ?? this.documento,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      cargo: cargo ?? this.cargo,
      direccion: direccion ?? this.direccion,
    );
  }

  factory Bombero.novo() => Bombero(
    id: null,
    documento: null,
    nombre: null,
    apellido: null,
    telefono: null,
    email: null,
    direccion: null,
    cargo: null,
  );

  @override
  String toString() {
    return 'Bombero(id: $id, documento: $documento, nombre: $nombre, apellido: $apellido, telefono: $telefono, email: $email, direccion: $direccion, cargo: $cargo)';
  }
}
