import 'package:bomber/core/components/fields/date_and_time_input.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/movil/model/movil.dart';
import 'package:bomber/modules/recarga/controller/recarga_controller.dart';
import 'package:bomber/modules/recarga/model/recarga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class RecargaAbm extends StatefulWidget {
  const RecargaAbm({super.key});

  @override
  State<RecargaAbm> createState() => _RecargaAbmState();
}

class _RecargaAbmState extends State<RecargaAbm> with Loader, SnackbarManager {
  final RecargaController _controller = Modular.get();
  late final Recarga? _recargaArg;
  late ReactionDisposer _statusReactionDisposer;
  final _key = GlobalKey<FormState>();
  late final ReactionDisposer disposer;
  final _fechaEC = TextEditingController();
  final _descripcionEC = TextEditingController();
  final _cantidadLitrosEC = TextEditingController();
  Movil? _movilSeleccionado;
  Bombero? _bomberoSeleccionado;
  Deposito? _depositoSeleccionado;

  @override
  void initState() {
    super.initState();
    _initReaction();
    _recargaArg = Modular.args.data as Recarga?;
    _controller.setCurrentRecord(_recargaArg ?? Recarga.novo());
    _cargarDatosDesdeCurrentRecord();
  }

  void _cargarDatosDesdeCurrentRecord() {
    final recarga = _controller.currentRecord;
    _fechaEC.text = _controller.currentRecord.fecha_hora?.toString() ?? '';
    _descripcionEC.text = recarga.descripcion ?? '';
    _cantidadLitrosEC.text = (recarga.cantidad_litros ?? 0).toString();
    _movilSeleccionado = recarga.movil ?? _movilSeleccionado;
    _bomberoSeleccionado = recarga.bombero ?? _bomberoSeleccionado;
    _depositoSeleccionado = recarga.depositoAgua ?? _depositoSeleccionado;

    setState(() {}); // fuerza redibujado inicial
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final deposito = Modular.args.data as Deposito?;
    final recarga = _controller.currentRecord;
    return Scaffold(
      appBar: AppBarPrincipal(
        text: recarga.id == null ? "Registro de Recarga" : "Editar Recarga",
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
                      image: AssetImage('assets/images/recarga_agua.png'),
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

                    DateAndTimeInput(
                      controller: _fechaEC,
                      date: recarga?.fecha_hora,
                      selectedDate: (date) => _controller.setFecha_hora(date),
                      labelText: "Fecha Recarga",
                      validator: Validatorless.required(
                        "El campo es requerido",
                      ),
                    ),

                    SizedBox(height: 25),
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
                    SizedBox(height: 25),
                    TodoListField(
                      label: "Cantidad de litros",
                      controller: _cantidadLitrosEC,
                      onChanged: (value) {
                        final cantidad =
                            double.tryParse(_cantidadLitrosEC.text) ?? 0.0;
                        _controller.setCantidad_litros(cantidad);
                      },

                    ),
                    SizedBox(height: 25),
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

                            print(recarga.toJson());

                            if (_controller.currentRecord.id == null) {
                              _save();
                            } else {
                              _actualizar(recarga.id!);
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
        case RecargaStatusState.initial:
          hideLoader();
          break;
        case RecargaStatusState.loaded:
          hideLoader();
          break;
        case RecargaStatusState.loading:
          showLoader();
          break;
        case RecargaStatusState.success:
          recargaRegistrado();
          hideLoader();
          showSuccess(_controller.message);
          _limpiarCampos();
          break;
        case RecargaStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case RecargaStatusState.insertOrUpdate:
          hideLoader();
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    _fechaEC.dispose();
    _descripcionEC.dispose();
    _cantidadLitrosEC.dispose();
    _movilSeleccionado = null;
    _bomberoSeleccionado = null;
    _depositoSeleccionado = null;
    _statusReactionDisposer();
    super.dispose();
  }

  void _limpiarCampos() {
    _fechaEC.clear();
    _descripcionEC.clear();
    _cantidadLitrosEC.clear();
    // mientras
    setState(() {});
  }

  void recargaRegistrado() {
    hideLoader();
    showSuccess(_controller.message);
    _controller.resetCurrentRecord();
    _limpiarCampos();
  }

  void recargaActualizado() {
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
