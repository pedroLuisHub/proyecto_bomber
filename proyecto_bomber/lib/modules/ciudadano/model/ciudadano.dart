import 'package:json_annotation/json_annotation.dart';

part 'ciudadano.g.dart';

@JsonSerializable()
class Ciudadano {
  @JsonKey(name: 'id_ciudadano') // Coincide con el nombre del campo en el backend
  int? id;
  String? documento;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? direccion;
  String? genero;
  String? profesion;

  Ciudadano({
    this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.direccion,
    this.documento,
    this.genero,
    this.profesion,
  });


  factory Ciudadano.fromJson(Map<String, dynamic> json) =>
      _$CiudadanoFromJson(json);
  Map<String, dynamic> toJson() => _$CiudadanoToJson(this);

  Ciudadano copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? telefono,
    String? email,
    String? direccion,
    String? documento,
    String? genero,
    String? profesion,
  }) {
    return Ciudadano(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      documento: documento ?? this.documento,
      genero: genero ?? this.genero,
      profesion: profesion ?? this.profesion,
    );
  }

  factory Ciudadano.novo() => Ciudadano(
    id: null,
    nombre: null,
    apellido: null,
    telefono: null,
    email: null,
    direccion: null,
    documento: null,
    genero: null,
    profesion: null,
  );
  

@override
  String toString() {
    return 'Ciudadano(id: $id, documento: $documento, nombre: $nombre, apellido: $apellido, telefono: $telefono, email: $email, direccion: $direccion, genero: $genero, profesion: $profesion)';
  }

  //   factory Ciudadano.fromJson(Map<String, dynamic> json) =>
  //     _$CiudadanoFromJson(json);
  // Map<String, dynamic> toJson() => _$CiudadanoToJson(this);

}