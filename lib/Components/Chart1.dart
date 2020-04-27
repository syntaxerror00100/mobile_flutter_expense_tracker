import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart1 extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  Chart1(this.recentTransactions);

  List<Map<String, Object>> get _getGroupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      final overallTotal = transactionsTotalAmount;
      final trans = recentTransactions
          .where((x) =>
              x.date.month == weekday.month &&
              x.date.day == weekday.day &&
              x.date.year == weekday.year)
          .toList();

      double totalAmount = 0;

      trans.forEach((i) => totalAmount += i.amount);

      final double average = (totalAmount / overallTotal) * 100;
      // print(DateFormat.E().format(weekday));
      // print(totalAmount);

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
        'percent': average
      };
    });
  }

  double get transactionsTotalAmount {
    double total = 0;
    recentTransactions.forEach((item) => total += item.amount);

    return total;
  }

  @override
  Widget build(BuildContext context) {
    print(_getGroupedTransactionValues[0]["day"]);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ..._getGroupedTransactionValues.map((item) {
            return Column(
              children: <Widget>[
                Text(item["amount"].toString()),
                Text('%0'),
                Text(item["day"])
              ],
            );
          })
        ],
      ),
    );
  }
}
