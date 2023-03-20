import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.tr,
    required this.removeTransacao,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) removeTransacao;

  @override
  Widget build(BuildContext context) {
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
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () {
                  removeTransacao(tr.id!);
                },
                icon: Icon(Icons.delete, color: Colors.red,),
                label: Text("Excluir", style: TextStyle(color: Colors.red),),)
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removeTransacao(tr.id!);
                },
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
