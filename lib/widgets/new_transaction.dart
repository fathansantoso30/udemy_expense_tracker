import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTransaction});
  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _addTx() {
    final valueTitleController = titleController.text;
    final valueAmountController = double.parse(amountController.text);
    if (valueTitleController.isEmpty || valueAmountController.isNegative) {
      return;
    }
    widget.addTransaction(
      valueTitleController,
      valueAmountController,
    );
  }

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
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          ElevatedButton(
            onPressed: () => _addTx(),
            child: const Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
