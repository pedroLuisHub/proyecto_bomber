import 'dart:typed_data';

import 'package:bomber/core/components/fields/date_formatter.dart';
import 'package:bomber/core/components/fields/date_range_picker_field.dart';
import 'package:bomber/core/components/ui/loader.dart';
import 'package:bomber/core/components/ui/pdf_preview.dart';
import 'package:bomber/core/components/ui/snack_bar_manager.dart';
import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/modules/abastecimiento/controller/abastecimiento_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ReporteAbastecimiento extends StatefulWidget {
  const ReporteAbastecimiento({super.key});

  @override
  State<ReporteAbastecimiento> createState() => _ReporteAbastecimientoState();
}

class _ReporteAbastecimientoState extends State<ReporteAbastecimiento>
    with Loader, SnackbarManager {
  final AbastecimientoController _controller = Modular.get();
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
        text: "Reporte de Abastecimiento",
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
                    SizedBox(height: 30),
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

                    SizedBox(height: 150),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              await _controller.reporteAbastecimientos(
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
                              foregroundColor: const Color.fromARGB(
                                255,
                                229,
                                194,
                                194,
                              ),
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
          hideLoader();
          reporteAbastecimientos();
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

  void reporteAbastecimientos() {
    Uint8List? resultPDF = _controller.pdfBytes;

    if (resultPDF != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PDFView(pdf: resultPDF, title: 'Reporte de Abastecimientos'),
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
      // final String condition = _generateFilterCondition(date.start, date.end);
      // _prepareAndNavigateToRelatorio(condition);

      _fechaInicial = '1000-01-01';
      _fechaFinal = '3000-12-31';
      _dateRangeController.clear();
    }
  }
}
