import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prestaciones_app/model/invoice.dart';
import 'package:prestaciones_app/pdf/pdf_api.dart';
import 'package:prestaciones_app/pdf/pdf_invoice_api.dart';
import 'package:prestaciones_app/utils/label_text.dart';
import 'package:prestaciones_app/utils/style_constants.dart';
import 'package:prestaciones_app/utils/compesation.dart';
import 'package:intl/intl.dart';

class FinalCalculationResignation extends StatefulWidget {
  String nombre, monto, empresa, tipo;
  DateTime fechaInicio, fechaFin;
  int diasPreaviso;
  FinalCalculationResignation({
    Key? key,
    required this.nombre,
    required this.monto,
    required this.empresa,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    this.diasPreaviso = 0,
  }) : super(key: key);

  @override
  State<FinalCalculationResignation> createState() =>
      _FinalCalculationResignationState();
}

class _FinalCalculationResignationState
    extends State<FinalCalculationResignation> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWages();
    calculateCompesation();
    calculateObligation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(children: [
          Center(
            child: Text(
              'Total a pagar',
              style: headingStyle2,
            ),
          ),
          const SizedBox(height: 30),
          _buildPendingPaymentChart(),
          const SizedBox(height: 40),
          _buildDataTable(),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      height: MediaQuery.of(context).size.height * 1.28,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Motivo de Salida: ',
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
                      text: 'Nombre Completo: ',
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
                      text: 'Nombre de la Empresa: ',
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
                      text: 'Antigüedad: ',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '\r${DateFormat("dd/MM/yy").format(widget.fechaInicio)} - ${DateFormat("dd/MM/yy").format(widget.fechaFin)} | ( ${tiempoTrabajado(widget.fechaInicio, widget.fechaFin)})',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Preaviso: ',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.diasPreaviso.toString()}\rdías',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Salario Promedio Mensual: ',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: formatToHNL(_Salary),
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Diario: ', amount: formatToHNL(_SalaryByDay)),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Ordinario: ',
                  amount: formatToHNL(_OrdinarySalary)),
              const SizedBox(height: 20),
              LabelTextAmount(
                  label: 'Salario Ordinario Diario: ',
                  amount: formatToHNL(_OrdinarySalaryByDay)),
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
                          DataCell(Text(
                              CurrencyFormat4Digits.format(_treceavoDias))),
                          DataCell(Text(formatToHNL(_SalaryByDay))),
                          DataCell(Text(formatToHNL(_treceavo))),
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
                          DataCell(Text(
                              CurrencyFormat4Digits.format(_catorceavoDias))),
                          DataCell(Text(formatToHNL(_SalaryByDay))),
                          DataCell(Text(formatToHNL(_catorceavo))),
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
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                          const DataCell(Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(
                            formatToHNL(_totalObligaciones),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                          const DataCell(Text(
                            'Total a Pagar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(
                            Text(
                                formatToHNL(
                                    _totalObligaciones + _totalDerechos),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildGeneratePDFButton(),
              const SizedBox(height: 30),
              _buildReCalculateButton(),
            ]),
      ),
    );
  }

  Widget _buildPendingPaymentChart() {
    final dataMap = <String, double>{
      "XIII": _treceavo,
      "XIV": _catorceavo,
      "VAC": _vacaciones,
      "PreAviso": _preaviso * -1,
      "Cesantia": _cesantia,
      "CesantiaPRO": _cesantiaProporcional
    };

    final colorList = <Color>[
      Colors.yellow.shade200,
      Colors.orange.shade400,
      Colors.pink.shade100,
      Colors.green.shade300,
      Colors.purple.shade300,
      Colors.red.shade400
    ];
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width * 0.45,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 6,
      centerText:
          'L.${CurrencyFormat.format(_totalObligaciones + _totalDerechos)}',
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
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        chartValueBackgroundColor: kPrimaryColor,
        showChartValues: true,
        chartValueStyle: edgeChartTextStyle,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 2,
      ),
    );
  }

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
    DateTime fechaInicio = widget.fechaInicio;
    DateTime fechaFin = widget.fechaFin;
    Days360 diasTrabajados360 = difference360(fechaInicio, fechaFin);
    int diasTrabajados = diasTrabajados360.totalDays();

    //si el año de inicio es el mismo con el que sale, se toma la fecha de inicio,
    //caso contrario, se toma la el primero de enero del la fecha de fin
    DateTime fechaInicioTreceavo = (fechaInicio.year == fechaFin.year)
        ? fechaInicio
        : DateTime(fechaFin.year);
    // la diferencia en dias de la fecha fin a la fecha del inicio del treceavo
    int diferenciaTreceavoDias =
        difference360(fechaInicioTreceavo, fechaFin).totalDays();
    _treceavoDias = (diferenciaTreceavoDias / 360) * 30;
    _treceavo = _treceavoDias * _SalaryByDay;
    //si ha trabajado más de un año, se calcula desde el 01/07 del año pasado
    //caso contrario, se toma desde que comenzó a trabajar.
    DateTime fechaInicioCatorceavo = diasTrabajados >= 360
        ? (fechaFin.month >= 7)
            ? DateTime(fechaFin.year, 7, 1)
            : DateTime(fechaFin.year - 1, 7, 1)
        : fechaInicio;
    // la diferencia en dias de la fecha fin a la fecha del inicio del catorceavo
    int diferenciaCatorceavoDias =
        difference360(fechaInicioCatorceavo, fechaFin).totalDays();
    _catorceavoDias = (diferenciaCatorceavoDias / 360) * 30;
    _catorceavo = _catorceavoDias * _SalaryByDay;
    //si ha trabajado más de un año, se calcula un la fecha del último periodo de vacaciones
    //caso contrario, se toma desde que comenzó a trabajar.

    int aniosTrabajados = (diasTrabajados ~/ 360).toInt() + 1;
    int diasOtorgadosVacaciones = 20;
    //si no encuentra el parametro del rango, poner el dia maximo
    Parametros.vacaciones.forEach((element) => {
          if (aniosTrabajados == element.anioTrabajado)
            {diasOtorgadosVacaciones = element.dias}
        });

    _vacacionesDias =
        (diasTrabajados360.months * 30 + diasTrabajados360.days + 1) /
            360 *
            diasOtorgadosVacaciones;
    _vacaciones = _vacacionesDias * _OrdinarySalaryByDay;
    _totalDerechos = _catorceavo + _treceavo + _vacaciones;
    setState(() {});
  }

  void calculateObligation() {
    DateTime fechaInicio = widget.fechaInicio;
    DateTime fechaFin = widget.fechaFin;
    Days360 diastrabajados360 = difference360(fechaInicio, fechaFin);
    int diasTrabajados = diastrabajados360.totalDays();
    int diasProporcionales =
        (diastrabajados360.months * 30) + diastrabajados360.days + 1;
    int aniosTrabajados = (diasTrabajados ~/ 360).toInt();

    _preavisoDias =
        ((aniosTrabajados >= 2) ? 60.0 : 99.0) - widget.diasPreaviso;

    Parametros.preaviso.forEach((e) => {
          if (!e.mustContinue)
            {
              if (diasTrabajados >= e.desde && diasTrabajados <= e.hasta)
                {_preavisoDias = e.dias.toDouble() - widget.diasPreaviso}
            }
        });
    _preaviso = _preavisoDias * _OrdinarySalaryByDay * -0.5;

    if (diasTrabajados.toDouble() > 5400) {
      _cesantiaDias = diasTrabajados.toDouble();

      Parametros.cesantia.forEach((e) => {
            if (!e.mustContinue)
              {
                if (diasTrabajados >= e.desde && diasTrabajados <= e.hasta)
                  if (_cesantiaDias > 30) {_cesantiaDias = e.dias.toDouble()}
              }
            else
              {
                if (diasTrabajados >= 9000)
                  {_cesantiaDias = 25 * 30}
                else
                  {_cesantiaDias = diastrabajados360.years * 30}
              }
          });
      _cesantia = _OrdinarySalaryByDay * _cesantiaDias;

      _cesantiaProporcionalDias = ((diasProporcionales / 360) * 30);
      _cesantiaProporcional =
          _cesantiaProporcionalDias * _OrdinarySalaryByDay * .15;
    }
    _totalObligaciones = _cesantia + _cesantiaProporcional + _preaviso;

    setState(() {});
  }

  String tiempoTrabajado(DateTime fechaInicio, DateTime fechaFin) {
    Days360 diferencia = difference360(fechaInicio, fechaFin);
    int years = diferencia.years;
    int months = diferencia.months;
    int days = diferencia.days;
    return '${years <= 0 ? '' : years == 1 ? '$years Año, ' : '$years Años,'} ${months <= 0 ? '' : months == 1 ? '$months Mes, ' : '$months Meses,'} ${days <= 0 ? '' : days == 1 ? '$days Día.' : '$days Días.'}';
  }
}
