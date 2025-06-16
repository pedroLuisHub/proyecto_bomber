import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:bomber/modules/deposito/controller/deposito_controller.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class DepositoAbm extends StatefulWidget {
  const DepositoAbm({super.key});

  @override
  State<DepositoAbm> createState() => _DepositoAbmState();
}

class _DepositoAbmState extends State<DepositoAbm>
    with Loader, SnackbarManager {
  final DepositoController _controller = Modular.get();
  late final Deposito? _depositoArg;
  late ReactionDisposer _statusReactionDisposer;
  final _key = GlobalKey<FormState>();
  final _latitudEC = TextEditingController();
  final _longitudEC = TextEditingController();
  final _capacidadEC = TextEditingController();
  String? _estadoSeleccionado;
  late final ReactionDisposer disposer;
  Ciudadano? _ciudadanoSeleccionado;

  @override
  void initState() {
    super.initState();

    _depositoArg = Modular.args.data as Deposito?; //  ← leer una sola vez
    _controller.setCurrentRecord(_depositoArg ?? Deposito.novo());

    _cargarDatosDesdeCurrentRecord(); //  ← rellena los TextEditingController
    _initReaction();
  }

  void _cargarDatosDesdeCurrentRecord() {
    final deposito = _controller.currentRecord;
    _latitudEC.text = deposito.latitud ?? '';
    _longitudEC.text = deposito.longitud ?? '';
    _capacidadEC.text = (deposito.capacidad ?? 0).toString();
    _estadoSeleccionado = deposito.estado;
    _ciudadanoSeleccionado = deposito.ciudadano ?? _ciudadanoSeleccionado;

    setState(() {}); // fuerza redibujado inicial
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final deposito = Modular.args.data as Deposito?;
    final deposito = _controller.currentRecord;
    return Scaffold(
      appBar: AppBarPrincipal(
        text: deposito.id == null ? "Registro de Deposito" : "Editar Deposito",
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
                      image: AssetImage('assets/images/deposito_agua.png'),
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
                    SizedBox(height: 25),
                    TodoListField(
                      label: "Latitud",
                      controller: _latitudEC,
                      onChanged: (value) {
                        _controller.setLatitud(value);
                      },
                    ),
                    SizedBox(height: 25),
                    TodoListField(
                      label: "Longitud",
                      controller: _longitudEC,
                      onChanged: (value) {
                        _controller.setLongitud(value);
                      },
                    ),
                    SizedBox(height: 25),
                    TodoListField(
                      label: "Capacidad",
                      controller: _capacidadEC,
                      onChanged: (value) {
                        final capacidad =
                            double.tryParse(_capacidadEC.text) ?? 0.0;
                        _controller.setCapacidad(capacidad);
                      },
                    ),
                    SizedBox(height: 25),

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
                        print('Estado seleccionado test: $valor');
                      },
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Por favor selecciona un estado';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 25),
                    Row(
                      children: [
                        // Expanded(
                        //   child: Text(
                        //     _ciudadanoSeleccionado == null
                        //         ? 'Ningún ciudadano seleccionado'
                        //         : 'Ciudadano: ${_ciudadanoSeleccionado!.nombre}',
                        //   ),
                        // ),
                        Expanded(
                          child:
                              _ciudadanoSeleccionado == null
                                  ? Text(
                                    'Ningún ciudadano seleccionado',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                  : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ciudadano asociado:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${_ciudadanoSeleccionado!.nombre}'),
                                    ],
                                  ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye), // ícono de ojo
                          onPressed: () {
                            if (_ciudadanoSeleccionado != null) {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AlertDialog(
                                      title: Text('Ciudadano Seleccionado'),
                                      content: Text(
                                        'Nombre: ${_ciudadanoSeleccionado!.nombre ?? 'Sin nombre'}\n'
                                        'Apellido: ${_ciudadanoSeleccionado!.apellido ?? 'Sin apellido'}\n'
                                        'Cédula: ${_ciudadanoSeleccionado!.documento ?? 'Sin documento'}\n'
                                        'Teléfono: ${_ciudadanoSeleccionado!.telefono ?? 'Sin teléfono'}\n'
                                        'Email: ${_ciudadanoSeleccionado!.email ?? 'Sin email'}\n',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: Text('Cerrar'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final seleccionado = await Modular.to
                                .pushNamed<Ciudadano>('/ciudadano/select');
                            if (seleccionado != null) {
                              setState(() {
                                _ciudadanoSeleccionado = seleccionado;
                              });
                              _controller.setCiudadano(
                                seleccionado,
                              ); // << ASOCIA AL DEPÓSITO
                            }
                          },
                          child: Text('Seleccionar Ciudadano'),
                        ),
                      ],
                    ),

                    SizedBox(height: 60),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (!_key.currentState!.validate()) return;

                            print(deposito.toJson());

                            if (_controller.currentRecord.id == null) {
                              _save();
                            } else {
                              _actualizar(deposito.id!);
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
      await _controller.save();
    }
  }

  void _actualizar(int idDeposito) async {
    if (_key.currentState!.validate()) {
      await _controller.actualizar(idDeposito);
    }
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case DepositoStatusState.initial:
          hideLoader();
          break;
        case DepositoStatusState.loaded:
          hideLoader();
          break;
        case DepositoStatusState.loading:
          showLoader();
          break;
        case DepositoStatusState.success:
          depositoRegistrado();
          hideLoader();
          showSuccess(_controller.message);
          _limpiarCampos();
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

  @override
  void dispose() {
    _latitudEC.dispose();
    _longitudEC.dispose();
    _capacidadEC.dispose();
    _estadoSeleccionado = null;
    _statusReactionDisposer();
    super.dispose();
  }

  void _limpiarCampos() {
    _latitudEC.clear();
    _longitudEC.clear();
    _capacidadEC.clear();
    _estadoSeleccionado = null;
    // mientras
    setState(() {});
  }

  // void _cargarDatos() {

  //   if (_controller.currentRecord != null) {

  //     final deposito = _controller.currentRecord;
  //     _latitudEC.text = deposito.latitud ?? '';
  //     _longitudEC.text = deposito.longitud ?? '';
  //     _capacidadEC.text = (deposito.capacidad ?? 0.0).toString();
  //     _estadoSeleccionado = deposito.estado;
  //   }
  // }
  void _cargarDatos() {
    final deposito = Modular.args.data as Deposito?;
    if (deposito != null) {
      _controller.setCurrentRecord(deposito); // Establece el registro actual
      _latitudEC.text = deposito.latitud ?? '';
      _longitudEC.text = deposito.longitud ?? '';
      _capacidadEC.text = (deposito.capacidad ?? 0.0).toString();
      _estadoSeleccionado = deposito.estado;
      _ciudadanoSeleccionado = deposito.ciudadano;
    } else {
      _controller.resetCurrentRecord(); // Nuevo depósito
    }
    setState(() {}); // Asegura que la UI se actualice
  }

  void depositoRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
  }

  void depositoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
    // Modular.to.pop();
  }
}
