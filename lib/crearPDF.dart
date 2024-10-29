import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'db.dart';
import 'fila.dart';

class CrearPDF {
  Future<Uint8List> crearPdfDias(String dia) async {
    List<Fila> lista = await DB.listaDia(dia);

    pw.Expanded columnaFilas(List<Fila> filas) {
      return pw.Expanded(
        child: pw.Column(
          children: [
            for (var fila in filas)
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text(fila.muelle)),
                  pw.Expanded(child: pw.Text(fila.matricula)),
                  pw.Expanded(child: pw.Text(fila.observaciones))
                ],
              ),
          ],
        ),
      );
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('')),
                  pw.Expanded(child: pw.Text(dia)),
                  pw.Expanded(child: pw.Text(''))
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Muelle:')),
                  pw.Expanded(child: pw.Text('Matricula:')),
                  pw.Expanded(child: pw.Text('Observaciones:'))
                ],
              ),
              columnaFilas(lista),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> guardarPDF(String data, Uint8List byteList) async {
    String nombre = data;
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$nombre.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    OpenFile.open(filePath);
  }
}
