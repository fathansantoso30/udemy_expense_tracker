import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/widgets/chart.dart';
import 'package:udemy_expense_tracker/widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              titleSmall: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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

  List<Transaction> get _recentTransactions {
    return _transaction
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

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

    Navigator.pop(context);
  }

  void _showModalAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTransaction: _addTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: () => _showModalAddTransaction(context),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Chart(recentTransactions: _recentTransactions),
              TransactionList(transaction: _transaction)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showModalAddTransaction(context),
        ),
      ),
    );
  }
}
