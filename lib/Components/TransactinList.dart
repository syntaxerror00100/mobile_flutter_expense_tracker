import 'package:flutter/material.dart';

import '../Models/TransactionModel.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  TransactionList(this.transactions);

  List<Card> getTransactionList() {
    return transactions.map((tran) {
      return Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2)),
                child: Text(
                  tran.amount.toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 20),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tran.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${tran.date.year.toString()}-${tran.date.month.toString().padLeft(2, '0')}-${tran.date.day.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[...getTransactionList()],
    );
  }
}
