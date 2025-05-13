import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/ciudadano/controller/ciudadano_controller.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class CiudadanoAbm extends StatefulWidget {
  const CiudadanoAbm({super.key});

  @override
  State<CiudadanoAbm> createState() => _CiudadanoAmbState();
}

class _CiudadanoAmbState extends State<CiudadanoAbm>
    with Loader, SnackbarManager {
  final CiudadanoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _key = GlobalKey<FormState>();
  final _documentoEC = TextEditingController();
  final _nombreEC = TextEditingController();
  final _apellidoEC = TextEditingController();
  final _telefonoEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _direccionEC = TextEditingController();
  String? _generoEC;
  final _profesionEC = TextEditingController();
  String? _generoSeleccionado;

  @override
  void initState() {
    //_controller.setCurrentRecord(Ciudadano.novo());
    super.initState();
    _initReaction();
    _cargarDatos();
    if (_controller.estadoDeInsertar) {
      _controller.resetCurrentRecord();
    }
  }

  @override
  void dispose() {
    _documentoEC.dispose();
    _nombreEC.dispose();
    _apellidoEC.dispose();
    _telefonoEC.dispose();
    _emailEC.dispose();
    _direccionEC.dispose();
    _generoEC = null;
    _profesionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarPrincipal(
        // ignore: unnecessary_null_comparison
        text:
            _controller.currentRecord.id == null
                ? "Registro de Ciudadano"
                : "Editar Ciudadano",
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
                      image: AssetImage('assets/images/ciudadano_registro.png'),
                      fit: BoxFit.cover,
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
                    TodoListField(
                      label: "Documento",
                      controller: _documentoEC,
                      onChanged: (value) {
                        _controller.setDocumento(value);
                      },
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    TodoListField(
                      label: "Telefono",
                      controller: _telefonoEC,
                      onChanged: (value) {
                        _controller.setTelefono(value);
                      },
                    ),
                    SizedBox(height: 10),
                    TodoListField(
                      label: "Email",
                      controller: _emailEC,
                      onChanged: (value) {
                        _controller.setEmail(value);
                      },
                    ),
                    SizedBox(height: 10),
                    TodoListField(
                      label: "Direccion",
                      controller: _direccionEC,
                      onChanged: (value) {
                        _controller.setDireccion(value);
                      },
                    ),
                    SizedBox(height: 10),
                    TodoListField(
                      label: "Profesion",
                      controller: _profesionEC,
                      onChanged: (value) {
                        _controller.setProfesion(value);
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _generoSeleccionado,
                      decoration: InputDecoration(
                        labelText: 'Genero',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          ['MASCULINO', 'FEMENINO']
                              .map(
                                (genero) => DropdownMenuItem(
                                  value: genero,
                                  child: Text(genero),
                                ),
                              )
                              .toList(),
                      onChanged: (valor) {
                        setState(() {
                          _generoSeleccionado = valor;
                        });
                        _controller.setGenero(valor ?? '');
                        print('Genero seleccionado: $valor');
                      },
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Por favor selecciona un genero';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('Datos del ciudadano registrados!'),
                              //   ),
                              // );
                              if (_controller.currentRecord.id == null) {
                                await _save();
                              } else {
                                await _actualizar(
                                  _controller.currentRecord.id!,
                                );
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
                                horizontal: 30,
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
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              _limpiarCampos();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                196,
                                27,
                                27,
                              ),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
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
                            child: const Text('Cancelar'),
                          ),
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

  Future<void> _actualizar(int idCiudadano) async {
    if (_key.currentState!.validate()) {
      await _controller.actualizar(idCiudadano);
    }
  }

  void _limpiarCampos() {
    _documentoEC.clear();
    _nombreEC.clear();
    _apellidoEC.clear();
    _telefonoEC.clear();
    _emailEC.clear();
    _direccionEC.clear();
    _generoEC = null;
    _profesionEC.clear();
    _controller.resetCurrentRecord();
    // mientras
    setState(() {});
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case CiudadanoStatusState.initial:
          hideLoader();
          break;
        case CiudadanoStatusState.loaded:
          hideLoader();
          break;
        case CiudadanoStatusState.loading:
          showLoader();
          break;
        case CiudadanoStatusState.success:
          ciudadanoRegistrado();
          hideLoader();
          // Modular.to.pop();
          showSuccess(_controller.message);
          _limpiarCampos();
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

  void ciudadanoRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _limpiarCampos();
  }

  void _cargarDatos() {
    final ciudadano = Modular.args.data as Ciudadano?;
    if (ciudadano != null) {
      _controller.setCurrentRecord(ciudadano);

      final current = _controller.currentRecord;
      _nombreEC.text = ciudadano.nombre ?? '';
      _apellidoEC.text = ciudadano.apellido ?? '';
      _telefonoEC.text = ciudadano.telefono ?? '';
      _emailEC.text = ciudadano.email ?? '';
      _direccionEC.text = ciudadano.direccion ?? '';
      _generoEC = _validarGenero(current.genero);
      _profesionEC.text = ciudadano.profesion ?? '';
    }
  }

  String? _validarGenero(String? genero) {
    const estadosValidos = ['MASCULINO', 'FEMENINO'];
    if (genero != null && estadosValidos.contains(genero.toUpperCase())) {
      return genero.toUpperCase();
    }
    return null;
  }
}
