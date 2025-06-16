import 'dart:typed_data';

import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/pdf_preview.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/deposito/controller/deposito_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class ReporteDeposito extends StatefulWidget {
  const ReporteDeposito({super.key});

  @override
  State<ReporteDeposito> createState() => _ReporteDepositoState();
}

class _ReporteDepositoState extends State<ReporteDeposito>
    with Loader, SnackbarManager {
  final DepositoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _capacidadMinEC = TextEditingController();
  final _capacidadMaxEC = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? _estadoFiltro;
  late final ReactionDisposer disposer;

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
        text: "Reporte de Deposito",
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
                    Text(
                      "Filtrar por Capacidad",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TodoListField(
                      label: "Capacidad Minima",
                      controller: _capacidadMinEC,
                      validator: Validatorless.multiple([
                        Validatorless.number('Debe ser un número válido'),
                      ]),
                      onChanged: (value) {
                        final capacidadMin = double.tryParse(value) ?? 0.0;
                        _controller.setCapacidadMin(capacidadMin);
                      },
                    ),

                    SizedBox(height: 10),

                    TodoListField(
                      label: "Capacidad Maxima",
                      controller: _capacidadMaxEC,
                      validator: Validatorless.multiple([
                        Validatorless.number('Debe ser un número válido'),
                      ]),
                      onChanged: (value) {
                        final capacidadMax = double.tryParse(value) ?? 0.0;
                        _controller.setCapacidadMax(capacidadMax);
                      },
                    ),

                    SizedBox(height: 30),

                    // Text(
                    //   "Filtrar por Estado",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),

                    // DropdownButtonFormField<String>(
                    //   value: _estadoFiltro,
                    //   decoration: InputDecoration(
                    //     labelText: 'Estado',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   items:
                    //       ['CARGADO', 'INACTIVO', 'VACIO']
                    //           .map(
                    //             (estado) => DropdownMenuItem(
                    //               value: estado,
                    //               child: Text(estado),
                    //             ),
                    //           )
                    //           .toList(),
                    //   onChanged: (valor) {
                    //     setState(() {
                    //       _estadoFiltro = valor;
                    //     });
                    //     _controller.setEstado(valor ?? '');
                    //   },
                    // ),
                    SizedBox(height: 150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Primero validar el formulario
                              if (_key.currentState!.validate()) {
                                // Convertir los valores a double
                                final capacidadMin =
                                    double.tryParse(_capacidadMinEC.text) ??
                                    0.0;
                                final capacidadMax =
                                    double.tryParse(_capacidadMaxEC.text) ??
                                    double.maxFinite;

                                // Llamar al controlador con los valores double
                                _controller.reporteDepositos(
                                  capacidadMin,
                                  capacidadMax,
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
          hideLoader();
          reporteDepositos();
          break;
        case DepositoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case DepositoStatusState.insertOrUpdate:
          hideLoader();
          break;
        case DepositoStatusState.reportGenerated:
          hideLoader();
          reporteDepositos();
          break;
        default:
      }
    });
  }

  void reporteDepositos() {
    Uint8List? resultPDF = _controller.pdfBytes;

    if (resultPDF != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PDFView(pdf: resultPDF, title: 'Reporte de Deposito'),
        ),
      );
    }
  }
}
