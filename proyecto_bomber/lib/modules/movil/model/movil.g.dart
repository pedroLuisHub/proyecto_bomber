// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movil _$MovilFromJson(Map<String, dynamic> json) => Movil(
      id: (json['id_movil'] as num?)?.toInt(),
      capacidad: (json['capacidad_tanque'] as num?)?.toDouble(),
      descripcion: json['descripcion'] as String?,
      estado: json['estado'] as String?,
      tutorial: json['tutorial_abastecimiento'] as String?,
    );

Map<String, dynamic> _$MovilToJson(Movil instance) => <String, dynamic>{
      'id_movil': instance.id,
      'capacidad_tanque': instance.capacidad,
      'descripcion': instance.descripcion,
      'estado': instance.estado,
      'tutorial_abastecimiento': instance.tutorial,
    };
