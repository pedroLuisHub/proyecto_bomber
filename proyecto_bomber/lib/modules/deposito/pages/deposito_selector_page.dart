import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/deposito/controller/deposito_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DepositoSelectorPage extends StatefulWidget {
  @override
  _DepositoSelectorPageState createState() => _DepositoSelectorPageState();
}

class _DepositoSelectorPageState extends State<DepositoSelectorPage> {
  final DepositoController _controller = Modular.get<DepositoController>();

  @override
  void initState() {
    super.initState();
    // Carga la lista cuando se abre la pantalla
    _controller.listaDeposito("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Esto solo prepara un nuevo Deposito en el controlador, pero no agrega a la lista
          _controller.insertarDeposito();
          // Si quieres agregar uno de prueba a la lista:
          // _controller.lista.add(Deposito(nombre: 'Nuevo', documento: '000'));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Depositos"),
      body: Observer(
        builder: (_) {
          if (_controller.lista.isEmpty) {
            return Center(child: Text('No hay Depositos para mostrar.'));
          }
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final Deposito = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(Deposito.latitud ?? ''),
                  subtitle: Text('Capacidad: ${Deposito.capacidad ?? ''}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Deposito'),
                          content: Text(
                            'Latitud: ${Deposito.latitud ?? 'Sin latitud'}\n'
                            'Longitud: ${Deposito.longitud ?? 'Sin longitud'}\n'
                            'Estado: ${Deposito.estado ?? 'Sin estado'}\n'
                            'Ciudadano: ${Deposito.ciudadano?.nombre ?? 'Sin ciudadano'}\n'
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
                    Navigator.pop(context, Deposito);
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