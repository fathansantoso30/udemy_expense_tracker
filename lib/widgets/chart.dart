import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expense_tracker/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double sumTransactionToday = 0.0;

        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            sumTransactionToday += recentTransactions[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': sumTransactionToday,
        };
      },
    );
  }

  double get totalSpends {
    return groupedTransactionValues.fold(
      0.0,
      (sum, element) => sum + (element['amount'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'] as String,
                  amountSpent: data['amount'] as double,
                  amountSpentPerTotal: totalSpends == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpends),
            );
          }).toList(),
        ),
      ),
    );
  }
}
