import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/pages/bombero_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class BomberoAbm extends StatefulWidget {
  const BomberoAbm({super.key});

  @override
  State<BomberoAbm> createState() => _BomberoAbmState();
}

class _BomberoAbmState extends State<BomberoAbm> with Loader, SnackbarManager {
  final BomberoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _nombreEC = TextEditingController();
  final _apellidoEC = TextEditingController();
  final _telefonoEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _direccionEC = TextEditingController();
  final _cargoEC = TextEditingController();
  final _documentoEC = TextEditingController();
  final _key = GlobalKey<FormState>();
  late final ReactionDisposer disposer;

  @override
  void initState() {
    //_controller.setCurrentRecord(Bombero.novo());
    super.initState();
    _initReaction();
    _cargarDatos();
  }

  @override
  void dispose() {
    _nombreEC.dispose();
    _apellidoEC.dispose();
    _telefonoEC.dispose();
    _emailEC.dispose();
    _direccionEC.dispose();
    _cargoEC.dispose();
    _documentoEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final bombero = Modular.args.data as Bombero?;


    return Scaffold(
      appBar: AppBarPrincipal(
        // ignore: unnecessary_null_comparison
        text: bombero == null ? "Registro de Bombero" : "Editar Bombero",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black),
                width: width / 2,
                height: height / 4.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    TodoListField(
                      label: "Documento",
                      controller: _documentoEC,
                      onChanged: (value) {
                        _controller.setDocumento(value);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Nombre",
                      controller: _nombreEC,
                      onChanged: (value) {
                        _controller.setNombre(value);
                      },
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Apellido",
                      controller: _apellidoEC,
                      onChanged: (value) {
                        _controller.setApellido(value);
                      },
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Telefono",
                      controller: _telefonoEC,
                      onChanged: (value) {
                        _controller.setTelefono(value);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Email",
                      controller: _emailEC,
                      onChanged: (value) {
                        _controller.setEmail(value);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Direccion",
                      controller: _direccionEC,
                      onChanged: (value) {
                        _controller.setDireccion(value);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Cargo",
                      controller: _cargoEC,
                      onChanged: (value) {
                        _controller.setCargo(value);
                      },
                    ),
                    SizedBox(height: 60),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text('Datos del bombero registrados!'),
                            //   ),
                            // );
                           if(bombero == null){
                            await _save();
                            } else {
                              await _actualizar(bombero.id!);
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

  Future<void> _save() async {
    if (_key.currentState!.validate()) {
      await _controller.save();
    }
  }


  Future<void> _actualizar(int idBombero) async {
    if (_key.currentState!.validate()) {
      await _controller.actualizar(idBombero);

    }
  }

  void _limpiarCampos() {
    _nombreEC.clear();
    _apellidoEC.clear();
    _telefonoEC.clear();
    _emailEC.clear();
    _direccionEC.clear();
    _cargoEC.clear();
    _documentoEC.clear();
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
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
          bomeroRegistrado();
          hideLoader();
          // Modular.to.pop();
          showSuccess(_controller.message);
          _limpiarCampos();
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

  void bomeroRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _limpiarCampos();
  }

    void _cargarDatos() {
      if (_controller.currentRecord != null) {
        final bombero = _controller.currentRecord;
        _nombreEC.text = bombero.nombre ?? '';
        _apellidoEC.text = bombero.apellido ?? '';
        _telefonoEC.text = bombero.telefono ?? '';
        _emailEC.text = bombero.email ?? '';
        _direccionEC.text = bombero.direccion ?? '';
        _cargoEC.text = bombero.cargo ?? '';
        _documentoEC.text = bombero.documento ?? '';
      }
    }


}
