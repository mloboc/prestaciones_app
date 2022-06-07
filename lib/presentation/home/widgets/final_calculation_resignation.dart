import 'package:flutter/material.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

class FinalCalculationResignation extends StatefulWidget {
  const FinalCalculationResignation({Key? key}) : super(key: key);

  @override
  State<FinalCalculationResignation> createState() =>
      _FinalCalculationResignationState();
}

class _FinalCalculationResignationState
    extends State<FinalCalculationResignation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(children: [
          Text(
            'Total a pagar',
            style: headingStyle2,
          ),
          const SizedBox(height: 20),
          Text('L. 54.376,67', style: headingStyle3),
          Expanded(child: _buildDataTable())
        ]),
      ),
    );
  }

  Widget _buildDataTable() {
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
                      text: 'Antiguedad:',
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
                          text: ' \r16.500,00',
                          style: subtitleStyle2,
                        )
                      ])),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Salario Diario:',
                      style: subtitleStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' \r550,00',
                          style: subtitleStyle2,
                        )
                      ])),
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
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('XVII')),
                          DataCell(Text('1,67')),
                          DataCell(Text('550,00')),
                          DataCell(Text('916,67')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('XIV')),
                          DataCell(Text('16,67')),
                          DataCell(Text('550,00')),
                          DataCell(Text('9.166,67')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('VAC')),
                          DataCell(Text('5,87')),
                          DataCell(Text('550,00')),
                          DataCell(Text('3.226,67')),
                        ],
                      ),
                      DataRow(
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
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Preaviso')),
                          DataCell(Text('30,00')),
                          DataCell(Text('550,00')),
                          DataCell(Text('16.500,00')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Cesantia')),
                          DataCell(Text('30,00')),
                          DataCell(Text('550,00')),
                          DataCell(Text('16.500,00')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Cesantia PRO')),
                          DataCell(Text('14,67')),
                          DataCell(Text('550,00')),
                          DataCell(Text('8.066,00')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('41.066,67')),
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
                            Text('54.376,67',
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
            Navigator.pop(context);
          },
          child: Text(
            'Recalcular',
            style: buttonTextStyle,
          )),
    );
  }
}
