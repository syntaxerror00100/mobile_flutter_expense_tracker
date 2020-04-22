import 'package:flutter/material.dart';

import '../Models/TransactionModel.dart';

class TransactionRow extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionRow({Key key, @required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2)),
              child: Text(
                transactionModel.amount.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontSize: 20),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                transactionModel.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "${transactionModel.date.year.toString()}-${transactionModel.date.month.toString().padLeft(2, '0')}-${transactionModel.date.day.toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
