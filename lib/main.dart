import 'package:flutter/material.dart';
import 'package:prestaciones_app/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prestaciones App',
        initialRoute: "home",
        routes: getAplicationRoutes());
  }
}
