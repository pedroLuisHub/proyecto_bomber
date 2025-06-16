import 'dart:typed_data';

import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/pdf_preview.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/ciudadano/controller/ciudadano_controller.dart';
import 'package:bomber/modules/ciudadano/model/ciudadano.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ReporteCiudadano extends StatefulWidget {
  const ReporteCiudadano({super.key});

  @override
  State<ReporteCiudadano> createState() => _ReporteCiudadanoState();
}

class _ReporteCiudadanoState extends State<ReporteCiudadano>
    with Loader, SnackbarManager {
  final CiudadanoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _hastaEC = TextEditingController();
  final _desdeEC = TextEditingController();
  final _key = GlobalKey<FormState>();
  late final ReactionDisposer disposer;
  Ciudadano? _ciudadanoSeleccionado;

    @observable
  Ciudadano currentRecord = Ciudadano();

  @override
  void initState() {
    super.initState();
    _initReaction();
    // _cargarDatos();
    if (_controller.estadoDeInsertar) {
      _controller.resetCurrentRecord();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBarPrincipal(
        // ignore: unnecessary_null_comparison
        text: "Reporte de Ciudadano",
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
                      image: AssetImage('assets/images/ciudadano.png'),
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
                    Text(
                      "Filtrar por Nombre",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TodoListField(
                      label: "Desde",
                      controller: _desdeEC,
                      onChanged: (value) {
                        _controller.setNombre(value);
                      },
                    ),

                    SizedBox(height: 10),

                    TodoListField(
                      label: "Hasta",
                      controller: _hastaEC,
                      onChanged: (value) {
                        _controller.setNombre(value);
                      },
                    ),
                    SizedBox(height: 25),
                    // IconButton(
                    //   icon: Icon(Icons.remove_red_eye), // ícono de ojo
                    //   onPressed: () {
                    //     if (_ciudadanoSeleccionado != null) {
                    //       showDialog(
                    //         context: context,
                    //         builder:
                    //             (_) => AlertDialog(
                    //               title: Text('Ciudadano Seleccionado'),
                    //               content: Text(
                    //                 'Nombre: ${_ciudadanoSeleccionado!.nombre ?? 'Sin nombre'}\n'
                    //                 'Apellido: ${_ciudadanoSeleccionado!.apellido ?? 'Sin apellido'}\n'
                    //                 'Cédula: ${_ciudadanoSeleccionado!.documento ?? 'Sin documento'}\n'
                    //                 'Teléfono: ${_ciudadanoSeleccionado!.telefono ?? 'Sin teléfono'}\n'
                    //                 'Email: ${_ciudadanoSeleccionado!.email ?? 'Sin email'}\n',
                    //               ),
                    //               actions: [
                    //                 TextButton(
                    //                   onPressed: () => Navigator.pop(context),
                    //                   child: Text('Cerrar'),
                    //                 ),
                    //               ],
                    //             ),
                    //       );
                    //     }
                    //   },
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final seleccionado = await Modular.to
                    //         .pushNamed<Ciudadano>('/ciudadano/select');
                    //     if (seleccionado != null) {
                    //       setState(() {
                    //         _ciudadanoSeleccionado = seleccionado;
                    //       });
                    //       _controller.setCiudadano(
                    //         seleccionado,
                    //       ); // << ASOCIA AL DEPÓSITO
                    //     }
                    //   },
                    //   child: Text('Seleccionar Ciudadano'),
                    // ),

                    SizedBox(height: 150),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              _controller.reporteCiudadanos(
                                _desdeEC.text,
                                _hastaEC.text,
                              );
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
                            child: const Text('Generar Reporte'),
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
          hideLoader();
          showSuccess(_controller.message);
          // _limpiarCampos();
          break;
        case CiudadanoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case CiudadanoStatusState.insertOrUpdate:
          hideLoader();
          break;
        case CiudadanoStatusState.reportGenerated:
          hideLoader();
          reporteCiudadanos();
          break;
        default:
      }
    });
  }

  void reporteCiudadanos() {
    Uint8List? resultPDF = _controller.pdfBytes;

    if (resultPDF != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PDFView(pdf: resultPDF, title: 'Reporte de Ciudadano'),
        ),
      );
    }
  }
}
