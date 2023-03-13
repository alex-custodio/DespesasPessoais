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
  List<Transaction> _transactions = [];
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
    final appBar = AppBar(
      title: Text("Despesas Pessoais", style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),),
      actions: [
        IconButton(
            onPressed: () => onTransactionFormCalled(context),
            icon: Icon(Icons.add))
      ],
    );
    final availableheight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: availableheight * 0.3,
                child: Chart(recentTransaction: _recentTransaction)),
            Column(
              children: [
                Container(
                  height: availableheight * 0.7,
                  child: TransactionList(
                      transactions: _transactions,
                      removeTransacao: removeTransacao),
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
