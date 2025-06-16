import 'package:bomber/core/components/fields/date_and_time_input.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/abastecimiento/controller/abastecimiento_controller.dart';
import 'package:bomber/modules/abastecimiento/model/abast/abastecimiento.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class AbastecimientoAbm extends StatefulWidget {
  const AbastecimientoAbm({super.key});

  @override
  State<AbastecimientoAbm> createState() => _AbastecimientoAbmState();
}

class _AbastecimientoAbmState extends State<AbastecimientoAbm>
    with Loader, SnackbarManager {
  final AbastecimientoController _controller = Modular.get();
  late final Abastecimiento? _abastecimientoArg;
  late ReactionDisposer _statusReactionDisposer;
  final _key = GlobalKey<FormState>();
  late final ReactionDisposer disposer;
  final _fechaInicioEC = TextEditingController();
  final _fechaFinEC = TextEditingController();
  final _descripcionEC = TextEditingController();
  final _cantidadLitrosEC = TextEditingController();
  final _cantidadViajesEC = TextEditingController();
  Movil? _movilSeleccionado;
  Bombero? _bomberoSeleccionado;
  Deposito? _depositoSeleccionado;

  @override
  void initState() {
    super.initState();
    _initReaction();
    _abastecimientoArg = Modular.args.data as Abastecimiento?;
    _controller.setCurrentRecord(_abastecimientoArg ?? Abastecimiento.novo());
    _cargarDatosDesdeCurrentRecord();
  }

  void _cargarDatosDesdeCurrentRecord() {
    final abastecimiento = _controller.currentRecord;
    _fechaInicioEC.text = abastecimiento.fechaInicio?.toString() ?? '';
    _fechaFinEC.text = abastecimiento.fechaFin?.toString() ?? '';
    _descripcionEC.text = abastecimiento.descripcion ?? '';
    _cantidadLitrosEC.text = (abastecimiento.cantLitros ?? 0).toString();
    _cantidadViajesEC.text = (abastecimiento.cantViajes ?? 0).toString();
    _movilSeleccionado = abastecimiento.movil ?? _movilSeleccionado;
    _bomberoSeleccionado = abastecimiento.bombero ?? _bomberoSeleccionado;
    _depositoSeleccionado =
        abastecimiento.depositoAgua ?? _depositoSeleccionado;

    setState(() {}); // fuerza redibujado inicial
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final deposito = Modular.args.data as Deposito?;
    final abastecimiento = _controller.currentRecord;
    return Scaffold(
      appBar: AppBarPrincipal(
        text:
            abastecimiento.id == null
                ? "Registro de Abastecimiento"
                : "Editar Abastecimiento",
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
                      image: AssetImage('assets/images/abastecimiento.png'),
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
                    DateAndTimeInput(
                      controller: _fechaInicioEC,
                      date: abastecimiento?.fechaInicio,
                      selectedDate: (date) => _controller.setFechaInicio(date),
                      labelText: "Fecha Inicio",
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),

                    SizedBox(height: 15),

                    DateAndTimeInput(
                      controller: _fechaFinEC,
                      date: abastecimiento?.fechaFin,
                      selectedDate: (date) => _controller.setFechaFin(date),
                      labelText: "Fecha Finalizacion",
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),

                    SizedBox(height: 15),
                    TodoListField(
                      label: "Descripción",
                      controller: _descripcionEC,
                      onChanged: (value) {
                        _controller.setDescripcion(value);
                      },
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Cantidad de litros",
                      controller: _cantidadLitrosEC,
                      onChanged: (value) {
                        final cantidadLitros =
                            double.tryParse(_cantidadLitrosEC.text) ?? 0.0;
                        _controller.setCantLitros(cantidadLitros);
                      },
                    ),
                    SizedBox(height: 15),
                    TodoListField(
                      label: "Cantidad de viajes",
                      controller: _cantidadViajesEC,
                      onChanged: (value) {
                        final cantidadViajes =
                            int.tryParse(value) ?? 0; // Usa int.tryParse
                        _controller.setCantViajes(cantidadViajes);
                      },
                    ),

                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child:
                              _movilSeleccionado == null
                                  ? Text(
                                    'Ningún movil seleccionado',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                  : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Movil:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${_movilSeleccionado!.descripcion}',
                                      ),
                                    ],
                                  ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye), // ícono de ojo
                          onPressed: () {
                            if (_movilSeleccionado != null) {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AlertDialog(
                                      title: Text('Movil Seleccionado'),
                                      content: Text(
                                        'Descripcion: ${_movilSeleccionado!.descripcion ?? 'Sin descripcion'}\n'
                                        'Capacidad: ${_movilSeleccionado!.capacidad ?? 'Sin capacidad'}\n'
                                        'Estado: ${_movilSeleccionado!.estado ?? 'Sin estado'}\n'
                                        'Tutorial: ${_movilSeleccionado!.tutorial ?? 'Sin tutorial'}\n',
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
                            final movSeleccionado = await Modular.to
                                .pushNamed<Movil>('/movil/select');
                            if (movSeleccionado != null) {
                              setState(() {
                                _movilSeleccionado = movSeleccionado;
                              });
                              _controller.setMovil(
                                movSeleccionado,
                              ); // << ASOCIA AL MOVIL
                            }
                          },
                          child: Text('Seleccionar Movil'),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child:
                              _bomberoSeleccionado == null
                                  ? Text(
                                    'Ningún bombero seleccionado',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                  : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bombero:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${_bomberoSeleccionado!.nombre}'),
                                    ],
                                  ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye), // ícono de ojo
                          onPressed: () {
                            if (_bomberoSeleccionado != null) {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AlertDialog(
                                      title: Text('Bombero Seleccionado'),
                                      content: Text(
                                        'Nombre: ${_bomberoSeleccionado!.nombre ?? 'Sin nombre'}\n'
                                        'Apellido: ${_bomberoSeleccionado!.apellido ?? 'Sin apellido'}\n'
                                        'Direccion: ${_bomberoSeleccionado!.direccion ?? 'Sin direccion'}\n'
                                        'Telefono: ${_bomberoSeleccionado!.telefono ?? 'Sin telefono'}\n'
                                        'Email: ${_bomberoSeleccionado!.email ?? 'Sin email'}\n'
                                        'Cargo: ${_bomberoSeleccionado!.cargo ?? 'Sin cargo'}\n',
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
                            final bomSeleccionado = await Modular.to
                                .pushNamed<Bombero>('/bombero/select');
                            if (bomSeleccionado != null) {
                              setState(() {
                                _bomberoSeleccionado = bomSeleccionado;
                              });
                              _controller.setBombero(
                                bomSeleccionado,
                              ); // << ASOCIA AL bombero
                            }
                          },
                          child: Text('Seleccionar Bombero'),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child:
                              _depositoSeleccionado == null
                                  ? Text(
                                    'Ningún deposito seleccionado',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                  : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Deposito:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${_depositoSeleccionado!.latitud}'),
                                    ],
                                  ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye), // ícono de ojo
                          onPressed: () {
                            if (_depositoSeleccionado != null) {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AlertDialog(
                                      title: Text('Deposito Seleccionado'),
                                      content: Text(
                                        'Latitud: ${_depositoSeleccionado!.latitud ?? 'Sin latitud'}\n'
                                        'Longitud: ${_depositoSeleccionado!.longitud ?? 'Sin longitud'}\n'
                                        'Capacidad: ${_depositoSeleccionado!.capacidad ?? 'Sin capacidad'}\n'
                                        'Estado: ${_depositoSeleccionado!.estado ?? 'Sin estado'}\n'
                                        'Ciudadano: ${_depositoSeleccionado!.ciudadano ?? 'Sin ciudadano'}\n',
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
                            final depSeleccionado = await Modular.to
                                .pushNamed<Deposito>('/deposito/select');
                            if (depSeleccionado != null) {
                              setState(() {
                                _depositoSeleccionado = depSeleccionado;
                              });
                              _controller.setDeposito(
                                depSeleccionado,
                              ); // << ASOCIA AL MOVIL
                            }
                          },
                          child: Text('Seleccionar Deposito'),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (!_key.currentState!.validate()) return;

                            print(abastecimiento.toJson());

                            if (_controller.currentRecord.id == null) {
                              _save();
                            } else {
                              _actualizar(abastecimiento.id!);
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

  void _actualizar(int idAbastecimiento) async {
    if (_key.currentState!.validate()) {
      await _controller.actualizar(idAbastecimiento);
    }
  }

  void _initReaction() {
    //Esto hace que primero se construya la pantalla, para despues ejecutar el metodo.
    _statusReactionDisposer = reaction((_) => _controller.status, (status) {
      switch (status) {
        case AbastecimientoStatusState.initial:
          hideLoader();
          break;
        case AbastecimientoStatusState.loaded:
          hideLoader();
          break;
        case AbastecimientoStatusState.loading:
          showLoader();
          break;
        case AbastecimientoStatusState.success:
          abastecimientoRegistrado();
          hideLoader();
          showSuccess(_controller.message);
          _limpiarCampos();
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

  @override
  void dispose() {
    _fechaInicioEC.dispose();
    _fechaFinEC.dispose();
    _descripcionEC.dispose();
    _cantidadLitrosEC.dispose();
    _cantidadViajesEC.dispose();
    _movilSeleccionado = null;
    _bomberoSeleccionado = null;
    _depositoSeleccionado = null;
    _statusReactionDisposer();
    super.dispose();
  }

  void _limpiarCampos() {
    _fechaInicioEC.clear();
    _fechaFinEC.clear();
    _descripcionEC.clear();
    _cantidadLitrosEC.clear();
    _cantidadViajesEC.clear();
    // mientras
    setState(() {});
  }

  void abastecimientoRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
  }

  void abastecimientoActualizado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
    // Modular.to.pop();
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    // Seleccionar fecha primero
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate == null) return null;

    // Luego seleccionar hora
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(pickedDate),
    );

    if (pickedTime == null) return null;

    // Combinar fecha y hora
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}
