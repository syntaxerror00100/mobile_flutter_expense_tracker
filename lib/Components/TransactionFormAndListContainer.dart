import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import './NewTransactionForm.dart';
import './TransactinList.dart';

class TransactionFormAndList extends StatefulWidget {
  @override
  _TransactionFormAndListState createState() => _TransactionFormAndListState();
}

class _TransactionFormAndListState extends State<TransactionFormAndList> {
  final List<TransactionModel> _transactions = [];

  void addTransactionHandler(TransactionModel tranObj) {
    setState(() {
      _transactions.add(new TransactionModel(
          id: tranObj.id,
          title: tranObj.title,
          amount: tranObj.amount,
          date: tranObj.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new NewtransactionForm(
            addTransactionHandler: this.addTransactionHandler),
        new TransactionList(this._transactions)
      ],
    );
  }
}
