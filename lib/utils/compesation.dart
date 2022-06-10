import 'package:intl/intl.dart';

class IPreaviso {
  int desde;
  int hasta;
  int dias;
  bool mustContinue;
  IPreaviso(
      {required this.desde,
      required this.hasta,
      required this.dias,
      this.mustContinue = false});
}

class ICesantia {
  int desde;
  int hasta;
  int dias;
  bool mustContinue;
  ICesantia(
      {required this.desde,
      required this.hasta,
      required this.dias,
      this.mustContinue = false});
}

class IVacaciones {
  int anioTrabajado;
  int dias;
  IVacaciones({required this.anioTrabajado, required this.dias});
}

class Parametros {
  static List<IPreaviso> preaviso = [
    IPreaviso(desde: 0, hasta: 90, dias: 1),
    IPreaviso(desde: 91, hasta: 180, dias: 7),
    IPreaviso(desde: 181, hasta: 360, dias: 14),
    IPreaviso(desde: 360, hasta: 720, dias: 30),
    IPreaviso(desde: 721, hasta: 360, dias: 60, mustContinue: true),
  ];
  static List<ICesantia> cesantia = [
    ICesantia(desde: 90, hasta: 180, dias: 10),
    ICesantia(desde: 181, hasta: 360, dias: 20),
    ICesantia(desde: 361, hasta: 9999, dias: 30, mustContinue: true)
  ];

  static List<IVacaciones> vacaciones = [
    IVacaciones(anioTrabajado: 1, dias: 10),
    IVacaciones(anioTrabajado: 2, dias: 12),
    IVacaciones(anioTrabajado: 3, dias: 15),
    IVacaciones(anioTrabajado: 4, dias: 20),
  ];
}

final CurrencyFormat = NumberFormat("#,##0.00", "en_US");
