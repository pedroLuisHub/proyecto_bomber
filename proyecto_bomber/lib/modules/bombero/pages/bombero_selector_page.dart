import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/bombero/controller/bombero_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BomberoSelectorPage extends StatefulWidget {
  @override
  _BomberoSelectorPageState createState() => _BomberoSelectorPageState();
}

class _BomberoSelectorPageState extends State<BomberoSelectorPage> {
  final BomberoController _controller = Modular.get<BomberoController>();

  @override
  void initState() {
    super.initState();
    // Carga la lista cuando se abre la pantalla
    _controller.listaBombero("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Esto solo prepara un nuevo Bombero en el controlador, pero no agrega a la lista
          _controller.insertarBombero();
          // Si quieres agregar uno de prueba a la lista:
          // _controller.lista.add(Bombero(nombre: 'Nuevo', documento: '000'));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Bomberos"),
      body: Observer(
        builder: (_) {
          if (_controller.lista.isEmpty) {
            return Center(child: Text('No hay Bomberos para mostrar.'));
          }
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final Bombero = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(Bombero.nombre ?? ''),
                  subtitle: Text('Apellido: ${Bombero.apellido ?? ''}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Bombero'),
                          content: Text(
                            'Nombre: ${Bombero.nombre ?? 'Sin nombre'}\n'
                            'Apellido: ${Bombero.apellido ?? 'Sin estado'}\n'
                            'Documento: ${Bombero.documento ?? 'Sin documento'}\n'
                            'Telefono: ${Bombero.telefono ?? 'Sin telefono'}\n'
                            'Documento: ${Bombero.documento ?? 'Sin documento'}\n'
                            'Direccion: ${Bombero.direccion ?? 'Sin direccion'}\n'
                            'Cargo: ${Bombero.cargo ?? 'Sin cargo'}\n'
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pop(context, Bombero);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}