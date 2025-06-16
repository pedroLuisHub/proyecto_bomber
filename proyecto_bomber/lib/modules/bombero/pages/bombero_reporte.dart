import 'dart:typed_data';

import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/pdf_preview.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/widgets/todo_list_field.dart';
import 'package:bomber/modules/bombero/controller/bombero_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ReporteBombero extends StatefulWidget {
  const ReporteBombero({super.key});

  @override
  State<ReporteBombero> createState() => _ReporteBomberoState();
}

class _ReporteBomberoState extends State<ReporteBombero>
    with Loader, SnackbarManager {
  final BomberoController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _hastaEC = TextEditingController();
  final _desdeEC = TextEditingController();
  final _key = GlobalKey<FormState>();
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
        text: "Reporte de Bombero",
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
                      image: AssetImage('assets/images/bombero_registro.png'),
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
                    Text(
                      "Filtrar por nombre",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TodoListField(
                      label: "Desde",
                      controller: _desdeEC,
                      onChanged: (value) {
                        _controller.setDocumento(value);
                      },
                    ),

                    SizedBox(height: 10),

                    TodoListField(
                      label: "Hasta",
                      controller: _hastaEC,
                      onChanged: (value) {
                        _controller.setDocumento(value);
                      },
                    ),

                    SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              _controller.reporteBomberos(_desdeEC.text, _hastaEC.text);
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
          //bomeroRegistrado();
          hideLoader();
          showSuccess(_controller.message);
          // _limpiarCampos();
          break;
        case BomberoStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case BomberoStatusState.insertOrUpdate:
          hideLoader();
          break;
        case BomberoStatusState.reportGenerated:
          hideLoader();
          reporteBomberos();
          break;
        default:
      }
    });
  }

  void reporteBomberos() {
    Uint8List? resultPDF = _controller.pdfBytes;

    if (resultPDF != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFView(pdf: resultPDF,title: 'Reporte de Bombero',)),
      );
    }
  }

}
