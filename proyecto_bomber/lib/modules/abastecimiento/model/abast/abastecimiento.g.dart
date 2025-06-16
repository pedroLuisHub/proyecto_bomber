// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abastecimiento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Abastecimiento _$AbastecimientoFromJson(Map<String, dynamic> json) =>
    Abastecimiento(
      id: (json['id_abastecimiento'] as num?)?.toInt(),
      fechaInicio: json['fecha_inicio'] == null
          ? null
          : DateTime.parse(json['fecha_inicio'] as String),
      fechaFin: json['fecha_finalizacion'] == null
          ? null
          : DateTime.parse(json['fecha_finalizacion'] as String),
      cantLitros: (json['cant_litros'] as num?)?.toDouble(),
      descripcion: json['descripcion'] as String?,
      cantViajes: (json['cant_viajes'] as num?)?.toInt(),
      movil: json['movil'] == null
          ? null
          : Movil.fromJson(json['movil'] as Map<String, dynamic>),
      bombero: json['bombero'] == null
          ? null
          : Bombero.fromJson(json['bombero'] as Map<String, dynamic>),
      depositoAgua: json['depositoAgua'] == null
          ? null
          : Deposito.fromJson(json['depositoAgua'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbastecimientoToJson(Abastecimiento instance) =>
    <String, dynamic>{
      'id_abastecimiento': instance.id,
      'fecha_inicio': instance.fechaInicio?.toIso8601String(),
      'fecha_finalizacion': instance.fechaFin?.toIso8601String(),
      'cant_litros': instance.cantLitros,
      'descripcion': instance.descripcion,
      'cant_viajes': instance.cantViajes,
      'movil': instance.movil,
      'bombero': instance.bombero,
      'depositoAgua': instance.depositoAgua,
    };
