import 'package:flutter/material.dart';
import 'package:prestaciones_app/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('es', 'HN'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Prestaciones App',
        initialRoute: "home",
        routes: getAplicationRoutes());
  }
}
