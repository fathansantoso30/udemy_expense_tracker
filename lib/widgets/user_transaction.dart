import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/widgets/new_transaction.dart';
import 'package:udemy_expense_tracker/widgets/transaction_list.dart';

import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transaction = [
    Transaction(
      id: '1',
      title: 'New Shoes',
      amount: 30.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Groceries',
      amount: 9.99,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String titleTx, double amountTx) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: titleTx,
      amount: amountTx,
      date: DateTime.now(),
    );

    setState(() {
      _transaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTransaction: _addTransaction),
        TransactionList(
          transaction: _transaction,
        ),
      ],
    );
  }
}
