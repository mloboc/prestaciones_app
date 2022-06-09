import 'package:flutter/material.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

class LabelTextAmountTable extends StatelessWidget {
  const LabelTextAmountTable({
    Key? key,
    required this.amount,
  }) : super(key: key);
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '\r$amount',
        ),
      ],
    );
  }
}
