import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PDFView extends StatefulWidget {
  final String? title;
  final Uint8List pdf;

  const PDFView({super.key, required this.pdf, this.title});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title ?? 'Visualizar PDF',
          ),
        ),
        body: PdfPreview(
          pdfFileName: widget.title,
          maxPageWidth: 600,
          onError: (context, error) {
            debugPrint(error.toString());
            return const Center(
              child: Text(
                'Error al generar el PDF',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
          canChangeOrientation: false,
          enableScrollToPage: true,
          canDebug: false,
          canChangePageFormat: false,
          build: (format) => widget.pdf,
        ));
  }
}
