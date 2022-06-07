import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "USA", child: Text("Despido")),
    const DropdownMenuItem(value: "Canada", child: Text("Renuncia")),
  ];
  return menuItems;
}

class DropdownMenu extends StatefulWidget {
  const DropdownMenu(List<DropdownMenuItem<String>> dropdownItems, {Key? key})
      : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Tipo',
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
              // validator: (value) => value == null ? "Selecciona un tipo" : null,
              dropdownColor: Colors.white,
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems),

          // if (_dropdownFormKey.currentState!.validate()) {
          //valid flow
        ]));
  }
}
