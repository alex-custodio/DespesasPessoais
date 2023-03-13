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
  bool _showChart = false;
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
        bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
      actions: [
        IconButton(
            onPressed: () => onTransactionFormCalled(context),
            icon: Icon(Icons.add)),
        if (isLandscape)
        IconButton(onPressed: (){
          setState(() {
            _showChart = !_showChart;
          });
        }, icon: Icon(_showChart ? Icons.list : Icons.show_chart))],
    );
    final availableheight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
                 Container(
                    height: availableheight * (isLandscape ? 0.7: 0.35),
                    child: Chart(recentTransaction: _recentTransaction)),
            if (!_showChart || !isLandscape) Column(
                    children: [
                      Container(
                        height: availableheight * 0.65,
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
