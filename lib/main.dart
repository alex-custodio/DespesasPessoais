import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
          textTheme: tema.textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [
    Transaction(
        id: "1",
        title: "Whey Protein",
        value: 100,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: "3",
        title: "Whey Protein",
        value: 100,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: "5", title: "Creatina fake", value: 13, date: DateTime.now())
  ];
  List<Transaction> get _recentTransaction {
    return _transactions.where((element) {
      return element.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransacao(String title, String value, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: double.tryParse(value) ?? 0,
          date: date));
    });
    Navigator.of(context).pop();
  }

  void removeTransacao(String id) {
    setState(() {
      return _transactions.removeWhere((element) => element.id == id);
    });
  }

  onTransactionFormCalled(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: addTransacao);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
          IconButton(
              onPressed: () => onTransactionFormCalled(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransaction: _recentTransaction),
            Column(
              children: [
                TransactionList(
                  transactions: _transactions, removeTransacao: removeTransacao
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTransactionFormCalled(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
