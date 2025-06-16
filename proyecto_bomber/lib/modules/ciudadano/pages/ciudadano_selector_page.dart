import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/ciudadano/controller/ciudadano_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CiudadanoSelectorPage extends StatefulWidget {
  @override
  _CiudadanoSelectorPageState createState() => _CiudadanoSelectorPageState();
}

class _CiudadanoSelectorPageState extends State<CiudadanoSelectorPage> {
  final CiudadanoController _controller = Modular.get<CiudadanoController>();

  @override
  void initState() {
    super.initState();
    // Carga la lista cuando se abre la pantalla
    _controller.listaCiudadano("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Esto solo prepara un nuevo ciudadano en el controlador, pero no agrega a la lista
          _controller.insertarCiudadano();
          // Si quieres agregar uno de prueba a la lista:
          // _controller.lista.add(Ciudadano(nombre: 'Nuevo', documento: '000'));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Ciudadanos"),
      body: Observer(
        builder: (_) {
          if (_controller.lista.isEmpty) {
            return Center(child: Text('No hay ciudadanos para mostrar.'));
          }
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final ciudadano = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(ciudadano.nombre ?? ''),
                  subtitle: Text('Cédula: ${ciudadano.documento ?? ''}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Ciudadano'),
                          content: Text(
                            'Nombre: ${ciudadano.nombre ?? 'Sin nombre'}\n'
                            'Apellido: ${ciudadano.apellido ?? 'Sin apellido'}\n'
                            'Cédula: ${ciudadano.documento ?? 'Sin documento'}\n'
                            'Teléfono: ${ciudadano.telefono ?? 'Sin teléfono'}\n'
                            'Email: ${ciudadano.email ?? 'Sin email'}\n'

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
                    Navigator.pop(context, ciudadano);
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