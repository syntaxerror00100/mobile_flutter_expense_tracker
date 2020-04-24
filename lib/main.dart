import 'package:expense_tracker/Components/TransactionFormAndListContainer.dart';
import 'package:expense_tracker/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import './Components/TransactionFormAndListContainer.dart';

void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _MyAppState createState() => _MyAppState();
// }

class MyApp extends StatelessWidget {
  // List<TransactionModel> transactions = [
  //   TransactionModel(
  //       id: "T1", title: "Tran1", amount: 1.0, date: DateTime.now()),
  //   TransactionModel(
  //       id: "T2", title: "Tran2", amount: 2.0, date: DateTime.now())
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Text("Dashboard"),
            ),
            new TransactionFormAndList()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
