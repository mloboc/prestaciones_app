import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prestaciones_app/utils/label_text.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

String tiempoTrabajado(String inicio, String fin) {
  DateTime fechaInicio = DateTime.parse(inicio);
  DateTime fechaFin = DateTime.parse(fin);
  int diferencia = fechaFin.difference(fechaInicio).inDays;
  var _years = (diferencia ~/ 360).toInt();
  var residuoMeses = diferencia % 360;
  var _months = (residuoMeses ~/ 30).toInt();
  var _days = (residuoMeses - (_years * 5)) % 30;
  return ' ${_years <= 0 ? '' : _years == 1 ? '$_years Año, ' : '$_years Años,'} ${_months <= 0 ? '' : _months == 1 ? '$_months Mes, ' : '$_months Meses,'} ${_days <= 0 ? '' : _days == 1 ? '$_days Día.' : '$_days Días.'}';
}

class FinalCalculationResignation extends StatefulWidget {
  String nombre, monto, empresa, tipo, fechaInicio, fechaFin;

  FinalCalculationResignation({
    Key? key,
    required this.nombre,
    required this.monto,
    required this.empresa,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
  }) : super(key: key);

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
        padding: const EdgeInsets.only(top: 30),
        child: ListView(children: [
          Column(children: [
            Center(
              child: Text(
                'Total a pagar',
                style: headingStyle2,
              ),
            ),
            const SizedBox(height: 30),
            _buildPendingPaymentChart(),
            const SizedBox(height: 30),
            _buildDataTable(),
            const SizedBox(height: 80),
          ]),
        ]),
      ),
    );
  }

  Widget _buildDataTable() {
    double value;
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Motivo de Salida:',
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
                      text: 'Nombre Completo:',
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
                      text: 'Nombre de la Empresa:',
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
                      text: 'Antiguedad:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              ' \r ${tiempoTrabajado(widget.fechaInicio, widget.fechaFin)}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Salario Promedio Mensual:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\r${widget.monto}',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              LabelTextAmount(label: 'Salario Diario', amount: ''),
              const SizedBox(height: 20),
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
                        label: Text('Dias', style: subtitleStyle2),
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
                          const DataCell(Text('5,87')),
                          const DataCell(Text('550,00')),
                          const DataCell(Text('3.226,67')),
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
      chartRadius: MediaQuery.of(context).size.width * 0.45,
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
}
