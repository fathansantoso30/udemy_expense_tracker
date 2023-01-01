import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({super.key, required this.addTransaction});
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountController,
          ),
          ElevatedButton(
            onPressed: () {
              addTransaction(
                titleController.text,
                double.parse(amountController.text),
              );
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.purple),
            ),
            child: const Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
