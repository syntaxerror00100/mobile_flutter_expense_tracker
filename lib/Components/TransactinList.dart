import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/TransactionModel.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Function fnDeleteTransactionHandler;

  TransactionList(this.transactions, this.fnDeleteTransactionHandler) {
    // if (transactions.length > 0)
    //   transactions.sort((a, b) {
    //     return a.date.compareTo(b.date);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: transactions.length > 0
          ? ListView.builder(
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
                          style: Theme.of(context).textTheme.subtitle),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(
                                      'Are you sure you want to delete the selected transaction?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        fnDeleteTransactionHandler(item.id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    ));
              })
          : Text("No transactions yet"),
    );
  }
}
