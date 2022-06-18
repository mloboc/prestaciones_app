import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prestaciones_app/utils/label_text.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

class FinalCalculationResignation extends StatefulWidget {
  String nombre, monto, empresa, tipo;

  FinalCalculationResignation(
      {Key? key,
      required this.nombre,
      required this.monto,
      required this.empresa,
      required this.tipo})
      : super(key: key);

  @override
  State<FinalCalculationResignation> createState() =>
      _FinalCalculationResignationState();
}

class _FinalCalculationResignationState
    extends State<FinalCalculationResignation> {
  final dataMap = <String, double>{
    "XIII": 916.67,
    "XIV": 9166.67,
    "VAC": 3226.67
  };

  final colorList = <Color>[
    Colors.yellow.shade200,
    Colors.orange.shade400,
    Colors.pink.shade100
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          Text(
            'Total a pagar',
            style: headingStyle2,
          ),
          const SizedBox(height: 40),
          _buildPendingPaymentChart(),
          const SizedBox(height: 50),
          Expanded(child: _buildDataTable())
        ]),
      ),
    );
  }

  Widget _buildDataTable() {
    double value;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: ListView(
            scrollDirection: Axis.vertical,
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
            children: [
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Tipo:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\r${widget.tipo}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Nombre:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\r${widget.nombre}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Empresa:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\r${widget.empresa}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
<<<<<<< Updated upstream
                      text: 'Antiguedad:',
=======
                      text: 'Antigüedad: ',
>>>>>>> Stashed changes
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' \r10 Dias, 0 Meses, 3 Años',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Salario:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\r${widget.monto}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Diario', amount: calcSalarioDiario()),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('Elemento', style: subtitleStyle2),
                      ),
                      DataColumn(
                        label: Text('Días', style: subtitleStyle2),
                      ),
                      DataColumn(
                        label: Text('Salario', style: subtitleStyle2),
                      ),
                      DataColumn(
                        label: Text('Pago', style: subtitleStyle2),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.yellow.shade200),
                                height: 25,
                                width: 25,
                              ),
                              const Text('\r\rXIII'),
                            ],
                          )),
                          const DataCell(Text('1,67')),
                          const DataCell(Text('550,00')),
                          const DataCell(Text('916,67')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange.shade400),
                                  height: 25,
                                  width: 25,
                                ),
                                const Text('\r\rXIV'),
                              ],
                            ),
                          ),
                          const DataCell(Text('16,67')),
                          const DataCell(Text('550,00')),
                          const DataCell(Text('9.166,67')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.pink.shade100),
                                  height: 25,
                                  width: 25,
                                ),
                                const Text('\r\rVAC'),
                              ],
                            ),
                          ),
<<<<<<< Updated upstream
                          const DataCell(Text('5,87')),
                          const DataCell(Text('550,00')),
                          const DataCell(Text('3.226,67')),
=======
                          DataCell(
                              Text(CurrencyFormat.format(_vacacionesDias))),
                          DataCell(Text(formatToHNL(_OrdinarySalaryByDay))),
                          DataCell(Text(formatToHNL(_vacaciones))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                          const DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(formatToHNL(_totalDerechos),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade300),
                                  height: 25,
                                  width: 25,
                                ),
                                const Text('\r\rPreaviso'),
                              ],
                            ),
                          ),
                          DataCell(Text(_preavisoDias.toString())),
                          DataCell(Text(formatToHNL(_OrdinarySalaryByDay))),
                          DataCell(Text(formatToHNL(_preaviso))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.purple.shade300),
                                  height: 25,
                                  width: 25,
                                ),
                                const Text('\r\rCesantía'),
                              ],
                            ),
                          ),
                          DataCell(Text(_cesantiaDias.toString())),
                          DataCell(Text(formatToHNL(_OrdinarySalaryByDay))),
                          DataCell(Text(formatToHNL(_cesantia))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.shade400),
                                  height: 25,
                                  width: 25,
                                ),
                                const Text('\r\rCesantía PRO'),
                              ],
                            ),
                          ),
                          DataCell(Text(CurrencyFormat4Digits.format(
                              _cesantiaProporcionalDias))),
                          DataCell(Text(formatToHNL(_OrdinarySalaryByDay))),
                          DataCell(Text(formatToHNL(_cesantiaProporcional))),
>>>>>>> Stashed changes
                        ],
                      ),
                      const DataRow(
                        cells: <DataCell>[
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(
                            Text('14.310,00',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildReCalculateButton(),
            ]),
      ),
    );
  }

  Widget _buildPendingPaymentChart() {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width * 0.65,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 6,
      centerText: 'L.13.310,00',
      centerTextStyle: centerChartTextStyle,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: false,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: false,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 2,
      ),
    );
  }

<<<<<<< Updated upstream
=======
  Widget _buildGeneratePDFButton() {
    double _totalAPagar = _totalDerechos + _totalObligaciones;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )),
          onPressed: () async {
            // _createPDF();
            final invoice = Invoice(
              info: InvoiceInfo(
                motivoDeSalida: widget.tipo,
                nombreCompleto: widget.nombre,
                nombreEmpresa: widget.empresa,
                antiguedad:
                    '${DateFormat("dd/MM/yy").format(widget.fechaInicio)} - ${DateFormat("dd/MM/yy").format(widget.fechaFin)} | \n( ${tiempoTrabajado(widget.fechaInicio, widget.fechaFin)})',
                preaviso: widget.diasPreaviso,
                salarioPromedioMensual: _Salary,
                salarioDiario: _SalaryByDay,
                salarioOrdinario: _OrdinarySalary,
                salarioOrdinarioDiario: _OrdinarySalaryByDay,
              ),
              items: [
                InvoiceItem(
                  elemento: 'XIII',
                  dias: _treceavoDias,
                  salarioDiario: _SalaryByDay,
                  pago: _treceavo,
                ),
                InvoiceItem(
                  elemento: 'XVI',
                  dias: _catorceavoDias,
                  salarioDiario: _SalaryByDay,
                  pago: _catorceavo,
                ),
                InvoiceItem(
                  elemento: 'VAC',
                  dias: _vacacionesDias,
                  salarioDiario: _OrdinarySalaryByDay,
                  pago: _vacaciones,
                ),
                InvoiceItem(
                  elemento: 'Preaviso',
                  dias: _preavisoDias,
                  salarioDiario: _OrdinarySalaryByDay,
                  pago: _preaviso,
                ),
                InvoiceItem(
                  elemento: 'Cesantía',
                  dias: _cesantiaDias,
                  salarioDiario: _OrdinarySalaryByDay,
                  pago: _cesantia,
                ),
                InvoiceItem(
                  elemento: 'Cesantía Pro',
                  dias: _cesantiaProporcionalDias,
                  salarioDiario: _OrdinarySalaryByDay,
                  pago: _cesantiaProporcional,
                ),
              ],
              payItems: InvoicePayInfo(totalPago: _totalAPagar),
            );

            final pdfFile = await PdfInvoiceApi.generate(invoice);

            PdfApi.openFile(pdfFile);
          },
          child: Text(
            'Generar PDF',
            style: buttonTextStyle2,
          )),
    );
  }

>>>>>>> Stashed changes
  Widget _buildReCalculateButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          child: Text(
            'Recalcular',
            style: buttonTextStyle,
          )),
    );
  }

  double calcSalarioDiario() {
    double r = 30;
    double p = double.parse(widget.monto);
    double value = (p / r);
    return value;
  }
}
