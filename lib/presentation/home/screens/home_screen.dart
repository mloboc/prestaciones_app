import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_resignation.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_dismissal.dart';
import 'package:prestaciones_app/utils/style_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Despido", child: Text("Despido")),
    const DropdownMenuItem(value: "Renuncia", child: Text("Renuncia")),
  ];
  return menuItems;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(List<DropdownMenuItem<String>> dropdownItems, {Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _monto = TextEditingController();
  final TextEditingController _empresa = TextEditingController();
  final TextEditingController _preaviso = TextEditingController();

  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  bool _showPreaviso = false;
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaFin = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return ListView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 30),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: 'Calculo',
                              style: headingStyle,
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' \nPrestaciones',
                                  style: headingStyle,
                                )
                              ]))),
                  Container(
                      padding: const EdgeInsets.all(5),
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/unitec_color.png',
                          filterQuality: FilterQuality.high)),
                ],
              ),
              const SizedBox(height: 30),
              _buildDropdown(),
              const SizedBox(height: 30),
              _buildNameFormField(),
              const SizedBox(height: 30),
              _buildSalaryFormField(),
              const SizedBox(height: 30),
              _buildCompanyFormField(),
              const SizedBox(height: 30),
              _buildDateTimePicker1(),
              const SizedBox(height: 30),
              _buildDateTimePicker2(),
              const SizedBox(height: 30),
              _buidlPreavisoDaysText(),
              const SizedBox(height: 30),
              _buildPreavisoDays(),
              const SizedBox(height: 30),
              _buildCalculateButton(),
              const SizedBox(height: 30),
            ],
          ),
        ]);
  }

  Widget _buildDropdown() {
    return Form(
        key: _dropdownFormKey,
        child: Column(children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Motivo de Salida',
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade500)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) => value == null ? "Selecciona un tipo" : null,
              dropdownColor: Colors.white,
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems),
        ]));
  }

  Widget _buildNameFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _nombre,
        decoration: InputDecoration(
          labelText: 'Nombre Completo',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Nombre Completo',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildSalaryFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _monto,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Salario Promedio Mensual',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'L.',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildCompanyFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _empresa,
        decoration: InputDecoration(
          labelText: 'Nombre de la Empresa',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Nombre de la Empresa',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker1() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fecha de Ingreso',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: const DatePickerTheme(
                      backgroundColor: Colors.white,
                      containerHeight: 200.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(1, 1, 1950),
                    maxTime: DateTime.now(), onConfirm: (date) {
                  _fechaInicio = date;
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.es);
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 65.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  DateFormat('EEEE, d/MMMM/y', 'es_ES')
                                      .format(_fechaInicio),
                                  style: subtitleStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.date_range,
                          size: 25.0,
                          color: kPrimaryColor,
                        )
                      ])))
        ]);
  }

  Widget _buildDateTimePicker2() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fecha de Salida',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: const DatePickerTheme(
                      backgroundColor: Colors.white,
                      containerHeight: 200.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime.now(), onConfirm: (date) {
                  _fechaFin = date;
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 65.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  DateFormat('EEEE, d/MMMM/y', 'es_ES')
                                      .format(_fechaFin),
                                  style: subtitleStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.date_range,
                          size: 25.0,
                          color: kPrimaryColor,
                        )
                      ])))
        ]);
  }

  Widget _buildPreavisoDays() {
    return Visibility(
      visible: _showPreaviso,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: _preaviso,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Días de Preaviso',
            hintStyle: hintTextStyle,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Preaviso',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  Widget _buidlPreavisoDaysText() {
    return (SwitchListTile(
      title: const Text('Preaviso'),
      subtitle: const Text(
          'Coloque los días de anticipación que se le avisó de su despido o notificó su renuncia'),
      value: _showPreaviso,
      onChanged: (bool value) {
        setState(() {
          _showPreaviso = value;
        });
      },
    ));
  }

  Widget _buildCalculateButton() {
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
            if (selectedValue == 'Despido') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FinalCalculationDismissal(
                        tipo: selectedValue.toString(),
                        nombre: _nombre.text,
                        monto: _monto.text,
                        empresa: _empresa.text,
                        fechaInicio: _fechaInicio,
                        fechaFin: _fechaFin,
                        diasPreaviso: int.tryParse(_preaviso.text) ?? 0,
                      )));
            } else if (selectedValue == 'Renuncia') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FinalCalculationResignation(
                        tipo: selectedValue.toString(),
                        nombre: _nombre.text,
                        monto: _monto.text,
                        empresa: _empresa.text,
                        fechaInicio: _fechaInicio,
                        fechaFin: _fechaFin,
                        diasPreaviso: int.tryParse(_preaviso.text) ?? 0,
                      )));
            } else {}
          },
          child: Text(
            'Calcular',
            style: buttonTextStyle,
          )),
    );
  }
}
