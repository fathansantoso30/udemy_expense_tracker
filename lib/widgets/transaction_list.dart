import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/widgets/transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transaction, required this.removeTransaction});

  final List<Transaction> transaction;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  const Text('No transactions added yet!'),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transaction[index],
                  removeTransaction: removeTransaction);
            },
          );
  }
}
