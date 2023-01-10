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
  bool _showChart = false;

  final List<Transaction> _transaction = [
    // Transaction(
    //   id: '1',
    //   title: 'New Shoes',
    //   amount: 30.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Groceries',
    //   amount: 9.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transaction
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(String titleTx, double amountTx, DateTime dateTx) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: titleTx,
      amount: amountTx,
      date: dateTx,
    );

    setState(() {
      _transaction.add(newTx);
    });

    Navigator.pop(context);
  }

  void _removeTransaction(String idTx) {
    setState(
      () {
        _transaction.removeWhere((transaction) => transaction.id == idTx);
      },
    );
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
    final deviceSize = MediaQuery.of(context);
    final isLandscape = deviceSize.orientation == Orientation.landscape;
    var appBar2 = AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () => _showModalAddTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    var txList = Container(
      height: (deviceSize.size.height -
              appBar2.preferredSize.height -
              -deviceSize.padding.top) *
          0.65,
      child: TransactionList(
        transaction: _transaction,
        removeTransaction: _removeTransaction,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar2,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show Chart'),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = !_showChart;
                          });
                        }),
                  ],
                ),
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (deviceSize.size.height -
                                appBar2.preferredSize.height -
                                deviceSize.padding.top) *
                            0.7,
                        child: Chart(recentTransactions: _recentTransactions))
                    : txList,
              if (!isLandscape)
                Container(
                    height: (deviceSize.size.height -
                            appBar2.preferredSize.height -
                            deviceSize.padding.top) *
                        0.3,
                    child: Chart(recentTransactions: _recentTransactions)),
              if (!isLandscape) txList,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showModalAddTransaction(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
