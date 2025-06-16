import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/abastecimiento/controller/abastecimiento_controller.dart';
import 'package:bomber/modules/abastecimiento/model/abast/abastecimiento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AbastecimientoListaPage extends StatefulWidget {
  const AbastecimientoListaPage({super.key});

  @override
  State<AbastecimientoListaPage> createState() => _AbastecimientoListaPageState();
}

class _AbastecimientoListaPageState extends State<AbastecimientoListaPage>
    with Loader, SnackbarManager {
  final AbastecimientoController _controller = Modular.get();
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
      appBar: AppBarPrincipal(text: "Lista de Abastecimientos"),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final abastecimiento = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(abastecimiento.descripcion ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(abastecimiento);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerAbastecimiento(abastecimiento.id!),
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
      _controller.listaAbastecimiento('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case AbastecimientoStatusState.initial:
          hideLoader();
          break;
        case AbastecimientoStatusState.loaded:
          hideLoader();
          break;
        case AbastecimientoStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case AbastecimientoStatusState.loading:
          showLoader();
          break;
        case AbastecimientoStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case AbastecimientoStatusState.actualizado:
          Modular.to.pop();
          _abastecimientoActualizado();
          break;
        case AbastecimientoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case AbastecimientoStatusState.insertOrUpdate:
          hideLoader();
          break;
        default:
      }
    });
  }

  void metodoEditar(Abastecimiento abastecimiento) {
    _controller.setCurrentRecord(abastecimiento);
    Modular.to.pushNamed('abm_abastecimiento', arguments: abastecimiento);
  }

  void _abastecimientoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 50), () {
      _controller.listaAbastecimiento('');
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
            '¿Deseas eliminar este abastecimiento? Esta acción no se puede deshacer.',
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
