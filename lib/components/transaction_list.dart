import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

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
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("R\$${tr.value}",
                                style: TextStyle(color: Colors.white)))),
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(
                    "${tr.title}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(DateFormat("d MMM y").format(tr.date!)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeTransacao(tr.id!);
                    },
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }),
          );
  }
}
