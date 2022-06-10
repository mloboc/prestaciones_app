import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prestaciones_app/utils/label_text%20table.dart';
import 'package:prestaciones_app/utils/label_text.dart';
import 'package:prestaciones_app/utils/style_constants.dart';
import 'package:prestaciones_app/utils/compesation.dart';

String tiempoTrabajado(String inicio, String fin) {
  DateTime fechaInicio = DateTime.parse(inicio);
  DateTime fechaFin = DateTime.parse(fin);

  int diferencia =
      (fechaFin.difference(fechaInicio).inDays / 365 * 360).toInt() + 1;
  int years = (diferencia ~/ 360).toInt();
  int residuoMeses = diferencia % 360;
  int months = (residuoMeses ~/ 30).toInt();
  int days = (residuoMeses) % 30;
  return '${years <= 0 ? '' : years == 1 ? '$years Año, ' : '$years Años,'} ${months <= 0 ? '' : months == 1 ? '$months Mes, ' : '$months Meses,'} ${days <= 0 ? '' : days == 1 ? '$days Día.' : '$days Días.'}';
}

class FinalCalculationDismissal extends StatefulWidget {
  String nombre, monto, empresa, tipo, fechaInicio, fechaFin;
  FinalCalculationDismissal({
    Key? key,
    required this.nombre,
    required this.monto,
    required this.empresa,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
  }) : super(key: key);

  @override
  State<FinalCalculationDismissal> createState() =>
      _FinalCalculationDismissalState();
}

class _FinalCalculationDismissalState extends State<FinalCalculationDismissal> {
  double _diasTrabajados = 0;
  double _Salary = 0;
  double _SalaryByDay = 0;
  double _OrdinarySalary = 0;
  double _OrdinarySalaryByDay = 0;
  double _treceavoDias = 0;
  double _treceavo = 0;
  double _catorceavoDias = 0;
  double _catorceavo = 0;
  double _vacacionesDias = 0;
  double _vacaciones = 0;
  double _preaviso = 0;
  double _preavisoDias = 0;
  double _cesantia = 0;
  double _cesantiaDias = 0;
  double _cesantiaProporcional = 0;
  double _cesantiaProporcionalDias = 0;
  double _totalDerechos = 0;
  double _totalObligaciones = 0;
  final dataMap = <String, double>{
    "XIII": 916.67,
    "XIV": 9166.67,
    "VAC": 3226.67,
    "PreAviso": 16500,
    "Cesantia": 16500,
    "CesantiaPRO": 8066
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWages();
    calculateCompesation();
    calculateObligation();
  }

  final colorList = <Color>[
    Colors.yellow.shade200,
    Colors.orange.shade400,
    Colors.pink.shade100,
    Colors.green.shade300,
    Colors.purple.shade300,
    Colors.red.shade400
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
        height: MediaQuery.of(context).size.height * 0.7,
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
                      text: 'Salario:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: CurrencyFormat.format(_Salary),
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Diario:',
                  amount: CurrencyFormat.format(_SalaryByDay)),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Ordinario:',
                  amount: CurrencyFormat.format(_OrdinarySalary)),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Ordinario Diario:',
                  amount: CurrencyFormat.format(_OrdinarySalaryByDay)),
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
                          DataCell(Text(CurrencyFormat.format(_treceavoDias))),
                          DataCell(Text(CurrencyFormat.format(_SalaryByDay))),
                          DataCell(Text(CurrencyFormat.format(_treceavo))),
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
                          DataCell(
                              Text(CurrencyFormat.format(_catorceavoDias))),
                          DataCell(Text(CurrencyFormat.format(_SalaryByDay))),
                          DataCell(Text(CurrencyFormat.format(_catorceavo))),
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
                          DataCell(
                              Text(CurrencyFormat.format(_vacacionesDias))),
                          DataCell(Text(
                              CurrencyFormat.format(_OrdinarySalaryByDay))),
                          DataCell(Text(CurrencyFormat.format(_vacaciones))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                          const DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(CurrencyFormat.format(_totalDerechos),
                              style: TextStyle(fontWeight: FontWeight.bold))),
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
                          DataCell(Text(CurrencyFormat.format(_preavisoDias))),
                          DataCell(Text(
                              CurrencyFormat.format(_OrdinarySalaryByDay))),
                          DataCell(Text(CurrencyFormat.format(_preaviso))),
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
                                const Text('\r\rCesantia'),
                              ],
                            ),
                          ),
                          DataCell(Text(CurrencyFormat.format(_cesantiaDias))),
                          DataCell(Text(
                              CurrencyFormat.format(_OrdinarySalaryByDay))),
                          DataCell(Text(CurrencyFormat.format(_cesantia))),
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
                                const Text('\r\rCesantia PRO'),
                              ],
                            ),
                          ),
                          DataCell(Text(CurrencyFormat.format(
                              _cesantiaProporcionalDias))),
                          DataCell(Text(
                              CurrencyFormat.format(_OrdinarySalaryByDay))),
                          DataCell(Text(
                              CurrencyFormat.format(_cesantiaProporcional))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(
                              Text(CurrencyFormat.format(_totalObligaciones))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(
                            Text(
                                CurrencyFormat.format(
                                    _totalObligaciones + 100000),
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
      centerText:
          'Lps. ${CurrencyFormat.format(_totalDerechos + _totalObligaciones)}',
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

  void setWages() {
    double salary = double.parse(widget.monto);

    _Salary = salary;
    _SalaryByDay = salary / 30;

    _OrdinarySalary = (salary * 14) / 12;
    _OrdinarySalaryByDay = ((salary * 14) / 12) / 30;
    setState(() {});
  }

  void calculateCompesation() {
    DateTime fechaInicio = DateTime.parse(widget.fechaInicio);
    DateTime fechaFin = DateTime.parse(widget.fechaFin);
    int diasTrabajados = fechaFin.difference(fechaInicio).inDays;
    //si ha trabajado más de un año, se calcula desde el 01/01/ del año en curso
    //caso contrario, se toma desde que comenzó a trabajar.
    DateTime fechaInicioTreceavo =
        diasTrabajados >= 360 ? DateTime(fechaFin.year) : fechaInicio;
    // la diferencia en dias de la fecha fin a la fecha del inicio del treceavo
    int diferenciaTreceavoDias =
        fechaFin.difference(fechaInicioTreceavo).inDays;
    _treceavoDias = (diferenciaTreceavoDias / 360) * 30;
    _treceavo = _treceavoDias * _SalaryByDay;
    //si ha trabajado más de un año, se calcula desde el 01/07 del año pasado
    //caso contrario, se toma desde que comenzó a trabajar.
    DateTime fechaInicioCatorceavo =
        diasTrabajados >= 360 ? DateTime(fechaFin.year - 1, 7, 1) : fechaInicio;
    // la diferencia en dias de la fecha fin a la fecha del inicio del catorceavo
    int diferenciaCatorceavoDias =
        fechaFin.difference(fechaInicioCatorceavo).inDays;
    _catorceavoDias = (diferenciaCatorceavoDias / 360) * 30;
    _catorceavo = _catorceavoDias * _SalaryByDay;
    //si ha trabajado más de un año, se calcula un la fecha del último periodo de vacaciones
    //caso contrario, se toma desde que comenzó a trabajar.

    int aniosTrabajados = (diasTrabajados ~/ 360).toInt();
    int diasOtorgadosVacaciones = 20;
    //si no encuentra el parametro del rango, poner el dia maximo
    Parametros.vacaciones.map((element) => {
          if (aniosTrabajados == element.anioTrabajado)
            {diasOtorgadosVacaciones = element.dias}
        });

    _vacacionesDias = ((diasTrabajados % 360) / diasOtorgadosVacaciones);
    _vacaciones = _vacacionesDias * _OrdinarySalaryByDay;
    _totalDerechos = _catorceavo + _treceavo + _vacaciones;
    setState(() {});
  }

  void calculateObligation() {
    DateTime fechaInicio = DateTime.parse(widget.fechaInicio);
    DateTime fechaFin = DateTime.parse(widget.fechaFin);
    int diasTrabajados = fechaFin.difference(fechaInicio).inDays;
    int aniosTrabajados = (diasTrabajados ~/ 360).toInt();

    _preavisoDias = (aniosTrabajados >= 2) ? 60.0 : 99.0;

    Parametros.preaviso.map((e) => {
          if (!e.mustContinue)
            {
              if (_preavisoDias >= e.desde && _preavisoDias <= e.hasta)
                {_preavisoDias = e.dias.toDouble()}
            }
        });
    _preaviso = _preavisoDias * _OrdinarySalaryByDay;

    _cesantiaDias = (aniosTrabajados < 25) ? aniosTrabajados.toDouble() : 25.00;

    Parametros.cesantia.map((e) => {
          if (!e.mustContinue)
            {
              if (_cesantiaDias >= e.desde && _cesantiaDias <= e.hasta)
                if (_cesantiaDias > 30)
                  {
                    {_cesantiaDias = e.dias.toDouble()}
                  }
            }
        });
    _cesantia = _OrdinarySalaryByDay * 30 * _cesantiaDias;

    _cesantiaProporcionalDias = ((diasTrabajados % 360) / 30);
    _cesantiaProporcional = _cesantiaProporcionalDias * _OrdinarySalaryByDay;
    _totalObligaciones = _cesantia + _cesantiaProporcional + _preaviso;
    setState(() {});
  }
}
