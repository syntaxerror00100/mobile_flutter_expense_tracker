import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import './Components/NewTransactionForm.dart';
import './Components/TransactinList.dart';

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
  final List<TransactionModel> _transactions = [];
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

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) => new NewtransactionForm(
            addTransactionHandler: this.addTransactionHandler));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo"),
        actions: <Widget>[
          FlatButton(
            child: Text("Add"),
            onPressed: () {
              _startAddTransaction(context);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Card(
              child: Text("Dashboard"),
            ),
            new TransactionList(this._transactions)
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddTransaction(context);
        },
      ),
    );
  }
}
