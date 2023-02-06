import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
 
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _transactions = [
    Transaction(
        id: "t1",
        title: "Novo Tênis de Corrida",
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: "t2", title: "Conta de Luz", value: 300, date: DateTime.now())
  ];

  void addTransacao(String title, String value) {
    setState(() {
      _transactions.add(Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: double.tryParse(value) ?? 0,
          date: DateTime.now()));
    });
    Navigator.of(context).pop();
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
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Gráfico"),
              ),
            ),
            Column(
              children: [
                TransactionList(
                  transactions: _transactions,
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
