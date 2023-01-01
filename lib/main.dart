import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/widgets/user_transaction.dart';

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
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.purple,
                child: Text('CHART'),
              ),
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
