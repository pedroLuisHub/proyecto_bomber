import 'dart:typed_data';

import 'package:bomber/core/components/fields/date_formatter.dart';
import 'package:bomber/core/components/fields/date_range_picker_field.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/pdf_preview.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/recarga/controller/recarga_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ReporteRecarga extends StatefulWidget {
  const ReporteRecarga({super.key});

  @override
  State<ReporteRecarga> createState() => _ReporteRecargaState();
}

class _ReporteRecargaState extends State<ReporteRecarga>
    with Loader, SnackbarManager {
  final RecargaController _controller = Modular.get();
  late ReactionDisposer _statusReactionDisposer;
  final _dateRangeController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late final ReactionDisposer disposer;
  String? _fechaInicial = '1000-01-01';
  String? _fechaFinal = '3000-12-31';

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
        text: "Reporte de Recarga",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 30),
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
                    SizedBox(height: 70),

                    Text(
                      "Filtrar por Fecha",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    DateRangePickerField(
                      dateRangeController: _dateRangeController,
                      onChanged: _filtroPorRange,
                    ),

                    SizedBox(height: 90),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {

                              await _controller.reporteRecargas(
                                _fechaInicial!,
                                _fechaFinal!,
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
          hideLoader();
          reporteRecargas();
          break;
        case RecargaStatusState.error:
          hideLoader();
          showError(_controller.message);
          break;
        case RecargaStatusState.insertOrUpdate:
          hideLoader();
          break;
                  case RecargaStatusState.reportGenerated:
          hideLoader();
          reporteRecargas();
          break;
        default:
      }
    });
  }

  void reporteRecargas() {
    Uint8List? resultPDF = _controller.pdfBytes;

    if (resultPDF != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PDFView(pdf: resultPDF, title: 'Reporte de Recargas'),
        ),
      );
    }
  }

  void _filtroPorRange(DateTimeRange? date) async {
    if (date != null) {
      _dateRangeController.text =
          '${DateFormatter.formatShortDate(date.start)} - ${DateFormatter.formatShortDate(date.end)}';
      _fechaInicial = DateFormatter.formatDateSql(date.start.toString());
      _fechaFinal = DateFormatter.formatDateSql(date.end.toString());
    } else {
      // Restablece a valores por defecto si se cancela la selección
      _fechaInicial = '1000-01-01';
      _fechaFinal = '3000-12-31';
      _dateRangeController.clear();
    }
  }
}
