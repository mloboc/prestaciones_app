import 'package:flutter/material.dart';
import 'package:prestaciones_app/utils/style_constants.dart';

class LabelTextAmount extends StatelessWidget {
  const LabelTextAmount({
    Key? key,
    required this.label,
    required this.amount,
  }) : super(key: key);

  final String label;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: subtitleStyle,
        ),
        Text('\r$amount', style: subtitleStyle2),
      ],
    );
  }
}
