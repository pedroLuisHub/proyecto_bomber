 import 'package:json_annotation/json_annotation.dart';

part 'movil.g.dart'; 

@JsonSerializable()
  class Movil {
    @JsonKey(name: 'id_movil') // Coincide con el nombre del campo en el backend
    int? id;
    @JsonKey(name: 'capacidad_tanque')
    double? capacidad;
    String? descripcion;
    String? estado;

    //Este campo seria para poner una URL como tutorial.
    @JsonKey(name: 'tutorial_abastecimiento')
    String? tutorial;


    Movil({
      this.id,
      this.capacidad,
      this.descripcion,
      this.estado,
      this.tutorial,
    });


    factory Movil.fromJson(Map<String, dynamic> json) =>
      _$MovilFromJson(json);
    Map<String, dynamic> toJson() => _$MovilToJson(this);

    Movil copyWith({
      int? id,
      double? capacidad,
      String? descripcion,
      String? estado,
      String? tutorial,
    })  {
      return Movil(
        id: id ?? this.id,
        capacidad: capacidad ?? this.capacidad,
        descripcion: descripcion ?? this.descripcion,
        estado: estado ?? this.estado,
        tutorial: tutorial ?? this.tutorial,
      );    
      }

      factory Movil.novo() => Movil(
        id: null,
        capacidad: null,
        descripcion: null,
        estado: null,
        tutorial: null,
      );

      @override
        String toString() {
          return 'Movil(id: $id, capacidad: $capacidad, descripcion: $descripcion, estado: $estado, tutorial: $tutorial)';
        }
  }
  