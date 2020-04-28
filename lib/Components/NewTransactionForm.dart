import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  var _selectedDate = "No date choosen";

  void _addTransaction(BuildContext ctx) {
    final String amount = _amountController.text;
    final String title = _titleController.text;
    final String date = _selectedDate;

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
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Column(
        children: <Widget>[
          TextField(
              controller: _titleController,
              decoration:
                  InputDecoration(hintText: "Input Title", labelText: "Title")),
          TextField(
              onSubmitted: (_) => _addTransaction(context),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              decoration: InputDecoration(
                  hintText: "Input Amount", labelText: "Amount")),
          Row(
            children: <Widget>[
              Text(_selectedDate),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050))
                        .then((selectedDate) {
                      if (selectedDate != null)
                        setState(() {
                          _selectedDate = DateFormat.yMMMEd()
                              .format(selectedDate)
                              .toString(); // selectedDate.toString();
                        });
                    });
                  })
            ],
          ),
          RaisedButton(
            child: Text(
              "Add transaction",
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () => _addTransaction(context),
          )
        ],
      ),
    );
  }
}
