import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  var _transactions = [
    Transaction(
        id: "t1",
        title: "Novo Tênis de Corrida",
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: "t2", title: "Conta de Luz", value: 300, date: DateTime.now())
  ];

  addTransacao(String title, String value) {
    setState(() {
      _transactions.add(Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: double.tryParse(value) ?? 0,
        date: DateTime.now()
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        TransactionForm(onSubmit: addTransacao),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
