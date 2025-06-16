import 'package:bomber/core/components/fields/search_app_bar_widget.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/movil/controller/movil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class MovilListaPage extends StatefulWidget {
  const MovilListaPage({super.key});

  @override
  State<MovilListaPage> createState() => _MovilListaPageState();
}

class _MovilListaPageState extends State<MovilListaPage>
    with Loader, SnackbarManager {
  final MovilController _controller = Modular.get();
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
      appBar: SearchAppBarWidget(hintText: "Buscar Movil",onSearch: (condition) {
        _controller.listaMovil(condition);
      },),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final movil = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(movil.descripcion ?? ''),
                  subtitle: Text(movil.estado ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(movil);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerMovil(movil.id!),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listaMovil('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case MovilStatusState.initial:
          hideLoader();
          break;
        case MovilStatusState.loaded:
          hideLoader();
          break;
        case MovilStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case MovilStatusState.loading:
          showLoader();
          break;
        case MovilStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case MovilStatusState.actualizado:
          _movilActualizado();
          break;
        case MovilStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case MovilStatusState.insertOrUpdate:
          hideLoader();
          break;
        default:
      }
    });
  }

  void metodoEditar(Movil movil) {
    _controller.setCurrentRecord(movil);
    Modular.to.pushNamed('abm_movil', arguments: movil);
  }

  void _movilActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.listaMovil('');
    });
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
            '¿Deseas eliminar este movil? Esta acción no se puede deshacer.',
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
}
