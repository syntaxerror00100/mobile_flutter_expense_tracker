import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';

class NewtransactionForm extends StatefulWidget {
  final Function addTransactionHandler;

  NewtransactionForm({@required this.addTransactionHandler});

  @override
  _NewtransactionFormState createState() => _NewtransactionFormState();
}

class _NewtransactionFormState extends State<NewtransactionForm> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _dateController = TextEditingController();

  void _addTransaction(BuildContext ctx) {
    final String amount = _amountController.text;
    final String title = _titleController.text;
    final String date = _dateController.text;

    if (title.isEmpty || amount.isEmpty || date.isEmpty) return;

    var newTransaction = new TransactionModel(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: DateTime.parse(date));

    widget.addTransactionHandler(newTransaction, ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: TextField(
              controller: _titleController,
              decoration:
                  InputDecoration(hintText: "Input Title", labelText: "Title")),
        ),
        Card(
          child: TextField(
              onSubmitted: (_) => _addTransaction(context),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              decoration: InputDecoration(
                  hintText: "Input Amount", labelText: "Amount")),
        ),
        Card(
          child: TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050))
                    .then((selectedDate) {
                  if (selectedDate != null)
                    _dateController.text = selectedDate.toString();
                });
              },
              onSubmitted: (_) => _addTransaction(context),
              decoration:
                  InputDecoration(hintText: "Input Date", labelText: "Date")),
        ),
        RaisedButton(
          child: Text("Add transaction"),
          onPressed: () => _addTransaction(context),
        )
      ],
    );
  }
}
