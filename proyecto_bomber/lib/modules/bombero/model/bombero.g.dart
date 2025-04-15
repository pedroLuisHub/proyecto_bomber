// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bombero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bombero _$BomberoFromJson(Map<String, dynamic> json) => Bombero(
      id: (json['id_bombero'] as num?)?.toInt(),
      documento: json['documento'] as String?,
      nombre: json['nombre'] as String?,
      apellido: json['apellido'] as String?,
      telefono: json['telefono'] as String?,
      email: json['email'] as String?,
      direccion: json['direccion'] as String?,
      cargo: json['cargo'] as String?,
    );

Map<String, dynamic> _$BomberoToJson(Bombero instance) => <String, dynamic>{
      'id_bombero': instance.id,
      'documento': instance.documento,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'telefono': instance.telefono,
      'email': instance.email,
      'direccion': instance.direccion,
      'cargo': instance.cargo,
    };
