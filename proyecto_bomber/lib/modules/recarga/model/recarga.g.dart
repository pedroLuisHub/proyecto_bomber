// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recarga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recarga _$RecargaFromJson(Map<String, dynamic> json) => Recarga(
      id: (json['idRecarga'] as num?)?.toInt(),
      fecha_hora: json['fecha_hora'] == null
          ? null
          : DateTime.parse(json['fecha_hora'] as String),
      descripcion: json['descripcion'] as String?,
      cantidad_litros: (json['cantidad_litros'] as num?)?.toDouble(),
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

Map<String, dynamic> _$RecargaToJson(Recarga instance) => <String, dynamic>{
      'idRecarga': instance.id,
      'fecha_hora': instance.fecha_hora?.toIso8601String(),
      'descripcion': instance.descripcion,
      'cantidad_litros': instance.cantidad_litros,
      'movil': instance.movil,
      'bombero': instance.bombero,
      'depositoAgua': instance.depositoAgua,
    };
