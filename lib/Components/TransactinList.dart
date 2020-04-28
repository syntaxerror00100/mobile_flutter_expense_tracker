import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/TransactionModel.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  TransactionList(this.transactions) {
    transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final item = transactions[index];
            return Card(
                elevation: 5,
                child: ListTile(
                    leading: CircleAvatar(
                      child: FittedBox(
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(item.amount.toString())),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd().format(item.date),
                        style: Theme.of(context).textTheme.subtitle)));
          }),
    );
  }
}
