// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposito.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deposito _$DepositoFromJson(Map<String, dynamic> json) => Deposito(
      id: (json['id_deposito_agua'] as num?)?.toInt(),
      latitud: json['latitud'] as String?,
      longitud: json['longitud'] as String?,
      capacidad: (json['capacidad'] as num?)?.toDouble(),
      estado: json['estado'] as String?,
      ciudadano: json['ciudadano'] == null
          ? null
          : Ciudadano.fromJson(json['ciudadano'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DepositoToJson(Deposito instance) => <String, dynamic>{
      'id_deposito_agua': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'capacidad': instance.capacidad,
      'estado': instance.estado,
      'ciudadano': instance.ciudadano,
    };
