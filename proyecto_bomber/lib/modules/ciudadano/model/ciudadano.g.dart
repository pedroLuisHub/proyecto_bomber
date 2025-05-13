// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ciudadano.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ciudadano _$CiudadanoFromJson(Map<String, dynamic> json) => Ciudadano(
      id: (json['id_ciudadano'] as num?)?.toInt(),
      nombre: json['nombre'] as String?,
      apellido: json['apellido'] as String?,
      telefono: json['telefono'] as String?,
      email: json['email'] as String?,
      direccion: json['direccion'] as String?,
      documento: json['documento'] as String?,
      genero: json['genero'] as String?,
      profesion: json['profesion'] as String?,
    );

Map<String, dynamic> _$CiudadanoToJson(Ciudadano instance) => <String, dynamic>{
      'id_ciudadano': instance.id,
      'documento': instance.documento,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'telefono': instance.telefono,
      'email': instance.email,
      'direccion': instance.direccion,
      'genero': instance.genero,
      'profesion': instance.profesion,
    };
