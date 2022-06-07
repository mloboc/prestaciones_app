import 'package:flutter/material.dart';
import 'package:prestaciones_app/presentation/home/widgets/dropdown_menu.dart';
import 'package:prestaciones_app/utils/style_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              DropdownMenu(dropdownItems),
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
              const SizedBox(height: 50),
              _buildCalculateButton(),
              const SizedBox(height: 30),
            ],
          ),
        ]);
  }

  Widget _buildNameFormField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Nombre',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Nombre',
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
        decoration: InputDecoration(
          labelText: 'Salario',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Monto',
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
        decoration: InputDecoration(
          labelText: 'Empresa',
          hintStyle: hintTextStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Empresa',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker1() {
    String _date = "Fecha Ingreso";
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  _date = '${date.year} - ${date.month} - ${date.day}';
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
                                  " $_date",
                                  style: hintTextStyle,
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
    String _date = "Fecha Despido";
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  _date = '${date.year} - ${date.month} - ${date.day}';
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
                                  " $_date",
                                  style: hintTextStyle,
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
            Navigator.pushNamed(context, 'final_calculation_dismissal');
          },
          child: Text(
            'Calcular',
            style: buttonTextStyle,
          )),
    );
  }
}
