import 'package:bomber/core/components/fields/search_app_bar_widget.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/ciudadano/controller/ciudadano_controller.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class CiudadanoListaPage extends StatefulWidget {

  final bool seleccionMode;

  const CiudadanoListaPage({super.key, this.seleccionMode = false});

  @override
  State<CiudadanoListaPage> createState() => _CiudadanoListaPageState();
}

class _CiudadanoListaPageState extends State<CiudadanoListaPage>
    with Loader, SnackbarManager {
  final CiudadanoController _controller = Modular.get();
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
      appBar: SearchAppBarWidget(hintText: "Buscar Ciudadano",onSearch: (condition) {
        _controller.listaCiudadano(condition);
      },),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final ciudadano = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(ciudadano.nombre ?? ''),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Importante para que el Row no ocupe todo el ancho
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          metodoEditar(ciudadano);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          mostrarDialogoConfirmacion(
                            context,
                            () => _controller.removerCiudadano(ciudadano.id!),
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
      _controller.listaCiudadano('');
    });
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case CiudadanoStatusState.initial:
          hideLoader();
          break;
        case CiudadanoStatusState.loaded:
          hideLoader();
          break;
        case CiudadanoStatusState.delete:
          hideLoader();
          showSuccess(_controller.message);
          break;
        case CiudadanoStatusState.loading:
          showLoader();
          break;
        case CiudadanoStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case CiudadanoStatusState.actualizado:
          _ciudadanoActualizado();
          break;
        case CiudadanoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case CiudadanoStatusState.insertOrUpdate:
          hideLoader();
          // Modular.to.pushNamed('/home/gasto/new-caixa');
          break;
        default:
      }
    });
  }

  void metodoEditar(Ciudadano ciudadano) {
    _controller.setCurrentRecord(ciudadano);
    Modular.to.pushNamed('abm_ciudadano', arguments: ciudadano);
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
            '¿Deseas eliminar este ciudadano? Esta acción no se puede deshacer.',
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

  void _ciudadanoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    Modular.to.pop();
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.listaCiudadano('');
    });
  }
}
