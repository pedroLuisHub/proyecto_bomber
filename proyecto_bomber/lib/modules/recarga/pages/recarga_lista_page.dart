import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/recarga/controller/recarga_controller.dart';
import 'package:bomber/modules/recarga/model/recarga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class RecargaListaPage extends StatefulWidget {
  const RecargaListaPage({super.key});

  @override
  State<RecargaListaPage> createState() => _RecargaListaPageState();
}

class _RecargaListaPageState extends State<RecargaListaPage>
    with Loader, SnackbarManager {
  final RecargaController _controller = Modular.get();
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
      appBar: AppBarPrincipal(text: "Lista de Recargas"),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final recarga = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(recarga.descripcion ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(recarga);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerRecarga(recarga.id!),
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
      _controller.listaRecarga('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case RecargaStatusState.initial:
          hideLoader();
          break;
        case RecargaStatusState.loaded:
          hideLoader();
          break;
        case RecargaStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case RecargaStatusState.loading:
          showLoader();
          break;
        case RecargaStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case RecargaStatusState.actualizado:
          Modular.to.pop();
          _recargaActualizado();
          break;
        case RecargaStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case RecargaStatusState.insertOrUpdate:
          hideLoader();
          break;
        default:
      }
    });
  }

  void metodoEditar(Recarga recarga) {
    _controller.setCurrentRecord(recarga);
    Modular.to.pushNamed('abm_recarga', arguments: recarga);
  }

  void _recargaActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 50), () {
      _controller.listaRecarga('');
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
            '¿Deseas eliminar este recarga? Esta acción no se puede deshacer.',
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
