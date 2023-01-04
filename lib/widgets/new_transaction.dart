import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTransaction});
  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  DateTime _datePicked = DateTime(0);

  void _addTx() {
    final valueTitleController = titleController.text;
    final valueAmountController = double.parse(amountController.text);
    final valueDateController = _datePicked;
    if (valueTitleController.isEmpty ||
        valueAmountController.isNegative ||
        valueDateController == DateTime(0)) {
      return;
    }
    widget.addTransaction(
      valueTitleController,
      valueAmountController,
      valueDateController,
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) {
      _datePicked = value!;
      setState(() {
        dateController.text = DateFormat.yMMMd().format(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.title_rounded),
              labelText: 'Title',
            ),
            controller: titleController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.attach_money_rounded),
              labelText: 'Amount',
            ),
            controller: amountController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          TextField(
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month_rounded),
                labelText: 'Date',
                hintText: 'Pick a date'),
            readOnly: true,
            controller: dateController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onTap: () => _showDatePicker(),
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
