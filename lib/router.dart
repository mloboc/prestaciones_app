import 'package:flutter/material.dart';
import 'package:prestaciones_app/presentation/home/screens/home_screen.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_resignation.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_dismissal.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    "home": (_) => HomeScreen(dropdownItems),
    "final_calculation_resignation": (_) => FinalCalculationResignation(
          empresa: '',
          monto: '',
          nombre: '',
          tipo: '',
          fechaInicio: '',
          fechaFin: '',
        ),
    "final_calculation_dismissal": (_) => FinalCalculationDismissal(
          empresa: '',
          monto: '',
          nombre: '',
          tipo: '',
          fechaInicio: '',
          fechaFin: '',
        ),
  };
}
