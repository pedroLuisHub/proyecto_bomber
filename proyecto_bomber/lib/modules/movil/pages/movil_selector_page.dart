
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/movil/controller/movil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovilSelectorPage extends StatefulWidget {
  @override
  _MovilSelectorPageState createState() => _MovilSelectorPageState();
}

class _MovilSelectorPageState extends State<MovilSelectorPage> {
  final MovilController _controller = Modular.get<MovilController>();

  @override
  void initState() {
    super.initState();
    // Carga la lista cuando se abre la pantalla
    _controller.listaMovil("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Esto solo prepara un nuevo movil en el controlador, pero no agrega a la lista
          _controller.insertarMovil();
          // Si quieres agregar uno de prueba a la lista:
          // _controller.lista.add(Movil(nombre: 'Nuevo', documento: '000'));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Movils"),
      body: Observer(
        builder: (_) {
          if (_controller.lista.isEmpty) {
            return Center(child: Text('No hay moviles para mostrar.'));
          }
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final movil = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(movil.descripcion ?? ''),
                  subtitle: Text('Capacidad: ${movil.capacidad ?? ''}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Movil'),
                          content: Text(
                            'Nombre: ${movil.descripcion ?? 'Sin descripcion'}\n'
                            'Estado: ${movil.estado ?? 'Sin estado'}\n'
                            'Tutorial: ${movil.tutorial ?? 'Sin tutorial'}\n'
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
                    Navigator.pop(context, movil);
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