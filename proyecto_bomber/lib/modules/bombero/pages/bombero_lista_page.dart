import 'package:bomber/core/components/fields/search_app_bar_widget.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/controller/bombero_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class BomberoListaPage extends StatefulWidget {
  const BomberoListaPage({super.key});

  @override
  State<BomberoListaPage> createState() => _BomberoListaPageState();
}

class _BomberoListaPageState extends State<BomberoListaPage>
    with Loader, SnackbarManager {
  final BomberoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;

  @override
  void initState() {
    super.initState();
    _initReaction();
  }

  @override
  void dispose() {
    super.dispose();
    _statusReactionDisposer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        hintText: "Buscar Bombero",
        onSearch: (condition) {
          _controller.listaBombero(condition); //
        },
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final bombero = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(bombero.nombre ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(bombero);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerBombero(bombero.id!),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listaBombero('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case BomberoStatusState.initial:
          hideLoader();
          break;
        case BomberoStatusState.loaded:
          hideLoader();
          break;
        case BomberoStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case BomberoStatusState.loading:
          showLoader();
          break;
        case BomberoStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case BomberoStatusState.actualizado:
          _bomberoActualizado();
          break;
        case BomberoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case BomberoStatusState.insertOrUpdate:
          hideLoader();
          // _controller.setCurrentRecord(Bombero.novo());
          // Modular.to.pushNamed('abm_bombero');
          break;
        default:
      }
    });
  }

  void metodoEditar(Bombero bombero) {
    _controller.setCurrentRecord(bombero);
    Modular.to.pushNamed('abm_bombero', arguments: bombero);
  }

  Future<void> mostrarDialogoConfirmacion(
    BuildContext context,
    VoidCallback onConfirmar,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // No se puede cerrar tocando fuera del diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Estás seguro?'),
          content: const Text(
            '¿Deseas eliminar este bombero? Esta acción no se puede deshacer.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            ElevatedButton(
              child: const Text('Eliminar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                onConfirmar(); // Ejecuta la acción si se confirma
              },
            ),
          ],
        );
      },
    );
  }

  void _bomberoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.listaBombero('');
    });
  }
}
