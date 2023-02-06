import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction>? transactions;
  TransactionList({this.transactions});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(itemCount: transactions!.length, itemBuilder: ((context, index) {
        return Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)),
                    child: Text(
                      "R\$ " + transactions![index].value!.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions![index].title!,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat("d MMM y").format(transactions![index].date!),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            );
      }),
      ),
    );
  }
}
