import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
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

      final double average =
          overallTotal > 0 ? (totalAmount / overallTotal) * 100 : 0;
      // print(DateFormat.E().format(weekday));
      // print(totalAmount);

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
        'percent': average
      };
    }).reversed.toList();
  }

  double get transactionsTotalAmount {
    double total = 0;
    recentTransactions.forEach((item) => total += item.amount);

    return total;
  }

  @override
  Widget build(BuildContext context) {
    print('================================');
    print(_getGroupedTransactionValues[0]["day"]);

    return Container(
      height: 150,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ..._getGroupedTransactionValues.map((item) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 14,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(item["amount"].toString()),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FAProgressBar(
                        progressColor: Theme.of(context).accentColor,
                        verticalDirection: VerticalDirection.up,
                        direction: Axis.vertical,
                        currentValue:
                            double.parse(item['percent'].toString()).toInt(),
                        displayText: '%',
                      ),
                    ),
                    Text(item["day"])
                  ],
                ),
              );

              // return Column(
              //   children: <Widget>[
              //     Text(item["amount"].toString()),
              //     Text('%0'),
              //     Text(item["day"])
              //   ],
              // );
            })
          ],
        ),
      ),
    );
  }
}
