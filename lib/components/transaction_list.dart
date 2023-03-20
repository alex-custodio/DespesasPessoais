import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'transaction_tile.dart';

class TransactionList extends StatelessWidget {
  List<Transaction>? transactions;
  void Function(String) removeTransacao;
  TransactionList({this.transactions, required this.removeTransacao});
  @override
  Widget build(BuildContext context) {
    return transactions!.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: [
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.3,
                child: Text("Nenhuma transação adicionada",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Container(
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
                height: constraints.maxHeight * 0.6,
              )
            ]);
          })
        : ListView.builder(
            itemCount: transactions!.length,
            itemBuilder: ((context, index) {
              var tr = transactions![index];
              return TransactionTile(tr: tr, removeTransacao: removeTransacao);
            }),
          );
  }
}

