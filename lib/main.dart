import 'package:expense_tracker/Components/Chart1.dart';
import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import './Components/NewTransactionForm.dart';
import './Components/TransactinList.dart';
import './Components/Chart1.dart';

void main() => runApp(MainAppEtnry());

class MainAppEtnry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
      home: MyApp(),
    );
  }
}

// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _MyAppState createState() => _MyAppState();
// }

class MyApp extends StatefulWidget {
  // List<TransactionModel> transactions = [
  //   TransactionModel(
  //       id: "T1", title: "Tran1", amount: 1.0, date: DateTime.now()),
  //   TransactionModel(
  //       id: "T2", title: "Tran2", amount: 2.0, date: DateTime.now())
  // ];

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    //INITIALIZE DUMMY DATA
    for (int i = 0; i < 7; i++) {
      final date = new DateTime.now().subtract(Duration(days: i));
      _transactions.add(new TransactionModel(
          id: i.toString(),
          title: 'Dummy data $i',
          amount: double.parse(i.toString()),
          date: date));

      _transactions.add(new TransactionModel(
          id: i.toString(),
          title: 'Another dummy data $i',
          amount: double.parse((i * 103.23).toString()),
          date: date));
    }
  }

  final List<TransactionModel> _transactions = [];
  bool _showChart = false;

  void addTransactionHandler(TransactionModel tranObj, BuildContext ctx) {
    setState(() {
      _transactions.add(new TransactionModel(
          id: tranObj.id,
          title: tranObj.title,
          amount: tranObj.amount,
          date: tranObj.date));
    });

    Navigator.of(ctx).pop();
  }

  List<TransactionModel> get recentTransactions {
    return _transactions
        .where(
            (x) => x.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled:
            MediaQuery.of(ctx).orientation == Orientation.landscape,
        context: ctx,
        builder: (_) => new NewtransactionForm(
            addTransactionHandler: this.addTransactionHandler));
  }

  void _deleteTransactionHandler(String id) {
    setState(() {
      _transactions.removeWhere((x) => x.id == id);
    });
  }

  AppBar appBar(BuildContext ctx) {
    return AppBar(
      title: Text("Expense manager"),
      actions: <Widget>[
        FlatButton(
          child: Text("Add"),
          onPressed: () {
            _startAddTransaction(ctx);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = appBar(context);

    final double screenHeightLessShits = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        _appBar.preferredSize.height;

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: _appBar,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        if (isLandscape)
          Container(
              child: Row(
            children: <Widget>[
              Switch(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              ),
              Text('Show chart')
            ],
          )),
        if (_showChart || !isLandscape)
          Container(
              height: screenHeightLessShits * (isLandscape ? .7 : .3),
              child: new Chart1(recentTransactions)),
        if (!_showChart || !isLandscape)
          Container(
              height: screenHeightLessShits * .7,
              child: TransactionList(
                  this._transactions, _deleteTransactionHandler))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddTransaction(context);
        },
      ),
    );
  }
}
