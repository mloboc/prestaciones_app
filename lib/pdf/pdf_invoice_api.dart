import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:prestaciones_app/pdf/pdf_api.dart';
import 'package:prestaciones_app/model/invoice.dart';
import 'package:prestaciones_app/utils/compesation.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(invoice),
        buildHeader(invoice),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildInvoice(invoice),
        Divider(),
        buildPayInfo(invoice.payItems),
      ],
    ));

    return PdfApi.saveDocument(name: 'calculo_prestaciones.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          buildInvoiceInfo(invoice.info),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Motivo de Salida:',
      'Nombre Completo:',
      'Nombre de la Empresa:',
      'Antiguedad:',
      'Preaviso:',
      'Salario Promedio Mensual:',
      'Salario Diario:',
      'Salario Ordinario:',
      'Salario Ordinario Diario',
    ];
    final data = <String>[
      info.motivoDeSalida,
      info.nombreCompleto,
      info.nombreEmpresa,
      info.antiguedad,
      '${info.preaviso.toString()} días',
      'L.${CurrencyFormat.format(info.salarioPromedioMensual)}',
      'L.${CurrencyFormat.format(info.salarioDiario)}',
      'L.${CurrencyFormat.format(info.salarioOrdinario)}',
      'L.${CurrencyFormat.format(info.salarioOrdinarioDiario)}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calculo Prestaciones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Elemento',
      'Dias',
      'Salario Diario',
      'Pago',
    ];
    final data = invoice.items.map((item) {
      return [
        item.elemento,
        item.dias.toStringAsFixed(2),
        'L.${CurrencyFormat.format(item.salarioDiario)}',
        'L.${CurrencyFormat.format(item.pago)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildPayInfo(InvoicePayInfo payInfo) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total a Pagar', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'L.${CurrencyFormat.format(payInfo.totalPago)}',
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
