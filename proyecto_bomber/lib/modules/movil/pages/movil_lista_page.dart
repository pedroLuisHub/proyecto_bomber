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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.insertarMovil();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Moviles"),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final movil = _controller.lista[index];
              return Card(
                child: ListTile(
                  title: Text(movil.descripcion ?? ''),
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
                          await _controller.removerMovil(
                            movil.id!,
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
          // Modular.to.pushNamed('/home/gasto/new-caixa');
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
}
