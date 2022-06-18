class Invoice {
  final InvoiceInfo info;
  final List<InvoiceItem> items;
  final InvoicePayInfo payItems;

  const Invoice({
    required this.info,
    required this.items,
    required this.payItems,
  });
}

class InvoiceInfo {
  final String motivoDeSalida;
  final String nombreCompleto;
  final String nombreEmpresa;
  final String antiguedad;
  final int preaviso;
  final double salarioPromedioMensual;
  final double salarioDiario;
  final double salarioOrdinario;
  final double salarioOrdinarioDiario;

  const InvoiceInfo({
    required this.motivoDeSalida,
    required this.nombreCompleto,
    required this.nombreEmpresa,
    required this.antiguedad,
    required this.preaviso,
    required this.salarioPromedioMensual,
    required this.salarioDiario,
    required this.salarioOrdinario,
    required this.salarioOrdinarioDiario,
  });
}

class InvoiceItem {
  final String elemento;
  final double dias;
  final double salarioDiario;
  final double pago;

  const InvoiceItem({
    required this.elemento,
    required this.dias,
    required this.salarioDiario,
    required this.pago,
  });
}

class InvoicePayInfo {
  final double totalPago;

  const InvoicePayInfo({
    required this.totalPago,
  });
}
