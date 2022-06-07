import 'package:flutter/material.dart';
import 'package:prestaciones_app/presentation/home/screens/home_screen.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_dismissal.dart';
import 'package:prestaciones_app/presentation/home/widgets/final_calculation_resignation.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    "home": (_) => const HomeScreen(),
    "final_calculation_resignation": (_) => const FinalCalculationResignation(),
    "final_calculation_dismissal": (_) => const FinalCalculationDismissal(),
  };
}
