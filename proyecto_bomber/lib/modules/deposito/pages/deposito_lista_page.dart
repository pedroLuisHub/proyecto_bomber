import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/deposito/controller/deposito_controller.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class DepositoListaPage extends StatefulWidget {
  const DepositoListaPage({super.key});

  @override
  State<DepositoListaPage> createState() => _DepositoListaPageState();
}

class _DepositoListaPageState extends State<DepositoListaPage>
    with Loader, SnackbarManager {
  final DepositoController _controller = Modular.get();
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
      appBar: AppBarPrincipal(text: "Lista de Depositos"),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final deposito = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(deposito.capacidad?.toStringAsFixed(2) ?? ''),
                  subtitle: Text(deposito.estado ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(deposito);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerDeposito(deposito.id!),
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
      _controller.listaDeposito('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case DepositoStatusState.initial:
          hideLoader();
          break;
        case DepositoStatusState.loaded:
          hideLoader();
          break;
        case DepositoStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case DepositoStatusState.loading:
          showLoader();
          break;
        case DepositoStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case DepositoStatusState.actualizado:
          Modular.to.pop();
          _depositoActualizado();
          break;
        case DepositoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case DepositoStatusState.insertOrUpdate:
          hideLoader();
          break;
        default:
      }
    });
  }

  void metodoEditar(Deposito deposito) {
    _controller.setCurrentRecord(deposito);
    Modular.to.pushNamed('abm_deposito', arguments: deposito);
  }

  void _depositoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 50), () {
      _controller.listaDeposito('');
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
            '¿Deseas eliminar este deposito? Esta acción no se puede deshacer.',
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
