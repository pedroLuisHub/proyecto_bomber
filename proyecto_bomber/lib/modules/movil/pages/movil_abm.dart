import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/movil/controller/movil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class MovilAbm extends StatefulWidget {
  const MovilAbm({super.key});

  @override
  State<MovilAbm> createState() => _MovilAbmState();
}

class _MovilAbmState extends State<MovilAbm> with Loader, SnackbarManager {
  final MovilController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _key = GlobalKey<FormState>();
  final _capacidadEC = TextEditingController();
  final _descripcionEC = TextEditingController();
  String? _estadoSeleccionado;
  final _tutorialEC = TextEditingController();
  late final ReactionDisposer disposer;

  get estadoSeleccionado => null;

  @override
  void initState() {
    super.initState();
    // _controller.setCurrentRecord(Movil.novo());
    _initReaction();
    _cargarDatos();
    // if (_controller.estadoDeInsertar) {
    //   _controller.resetCurrentRecord();
    // }
  }

  @override
  void dispose() {
    _capacidadEC.dispose();
    _descripcionEC.dispose();
    _estadoSeleccionado = null;
    _tutorialEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final movil = Modular.args.data as Movil?;

    return Scaffold(
      appBar: AppBarPrincipal(
        text:
            _controller.currentRecord.id == null
                ? "Registro de Movil"
                : "Editar Movil",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: width / 2,
                  height: height / 4.5,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(1, 5),
                      ),
                    ],

                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/movil_bombero.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Capacidad",
                      controller: _capacidadEC,
                      onChanged: (value) {
                        final capacidad =
                            double.tryParse(_capacidadEC.text) ?? 0.0;
                        _controller.setCapacidad(capacidad);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Descripcion",
                      controller: _descripcionEC,
                      onChanged: (value) {
                        _controller.setDescripcion(value);
                      },
                    ),
                    SizedBox(height: 15),

                    // TodoListField(
                    //   label: "Estado",
                    //   controller: _estadoEC,
                    //   onChanged: (value) {
                    //     _controller.setEstado(value);
                    //   },
                    // ),
                    DropdownButtonFormField<String>(
                      value: _estadoSeleccionado,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          ['CARGADO', 'INACTIVO', 'VACIO']
                              .map(
                                (estado) => DropdownMenuItem(
                                  value: estado,
                                  child: Text(estado),
                                ),
                              )
                              .toList(),
                      onChanged: (valor) {
                        setState(() {
                          _estadoSeleccionado = valor;
                        });
                        _controller.setEstado(valor ?? '');
                        print('Estado seleccionado: $valor');
                      },
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Por favor selecciona un estado';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),
                    TodoListField(
                      label: "Tutorial",
                      controller: _tutorialEC,
                      onChanged: (value) {
                        _controller.setTutorial(value);
                      },
                    ),
                    SizedBox(height: 60),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (movil == null) {
                              _save();
                            } else {
                              _actualizar(movil.id!);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              68,
                              149,
                              1,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 90,
                              vertical: 22,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Guardar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    if (_key.currentState!.validate()) {
      print('Guardando estado: $_estadoSeleccionado');
      await _controller.save();
    }
  }

  void _actualizar(int idMovil) async {
    if (_key.currentState!.validate()) {
      await _controller.actualizar(idMovil);
    }
  }

  void _limpiarCampos() {
    _capacidadEC.clear();
    _descripcionEC.clear();
    _estadoSeleccionado = null;
    _tutorialEC.clear();
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case MovilStatusState.initial:
          hideLoader();
          _limpiarCampos();
          break;
        case MovilStatusState.loaded:
          hideLoader();
          break;
        case MovilStatusState.loading:
          showLoader();
          break;
        case MovilStatusState.success:
          movilRegistrado();

          hideLoader();

          // Modular.to.pop();
          showSuccess(_controller.message);
          _limpiarCampos();
          break;
        case MovilStatusState.actualizado:
          movilActualizado();
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

  void movilRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
  }

  void movilActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
    // Modular.to.pop();
  }

  void _cargarDatos() {
    final movil = Modular.args.data as Movil?;
    if (movil != null) {
      _controller.setCurrentRecord(movil);

      final current = _controller.currentRecord;
      _capacidadEC.text = (movil.capacidad ?? 0.0).toString();
      _descripcionEC.text = movil.descripcion ?? '';
      _estadoSeleccionado = _validarEstado(current.estado);
      _tutorialEC.text = movil.tutorial ?? '';
    }
  }

  String? _validarEstado(String? estado) {
    const estadosValidos = ['CARGADO', 'INACTIVO', 'VACIO'];
    if (estado != null && estadosValidos.contains(estado.toUpperCase())) {
      return estado.toUpperCase();
    }
    return null;
  }
}
