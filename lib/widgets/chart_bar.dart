import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {super.key,
      required this.label,
      required this.amountSpent,
      required this.amountSpentPerTotal});

  final String label;
  final double amountSpent;
  final double amountSpentPerTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('\$${amountSpent.toStringAsFixed(0)}')),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: amountSpentPerTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
