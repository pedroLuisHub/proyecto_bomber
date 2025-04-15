import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/pages/bombero_controller.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showSuccess('consutando.,...');
          showLoader();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBarPrincipal(text: "Lista de Bomberos",),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _controller.lista.length,
            itemBuilder: (context, index) {
              final bombero = _controller.lista[index];
              return Card(child: ListTile(title: Text(bombero.nombre ?? ''),
              trailing: IconButton(
                    icon: Icon(Icons.edit), // Ícono genérico
                    onPressed: () {
                      metodoEditar(bombero);
                    },
              )));
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
        case BomberoStatusState.loading:
          showLoader();
          break;
        case BomberoStatusState.success:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          break;
        case BomberoStatusState.actualizado:
          hideLoader();
          Modular.to.pop();
          showSuccess(_controller.message);
          Future.delayed(const Duration(seconds: 1), () {
            _controller.listaBombero('');
          });
          
          break;
        case BomberoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case BomberoStatusState.insertOrUpdate:
          hideLoader();
          // Modular.to.pushNamed('/home/gasto/new-caixa');
          break;
        default:
      }
    });
  }
  
  void metodoEditar(Bombero bombero) {
    _controller.setCurrentRecord(bombero);
    Modular.to.pushNamed('abm_bombero', arguments: bombero);
  }
}