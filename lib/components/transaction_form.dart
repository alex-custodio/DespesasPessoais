import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  var titleController = TextEditingController();
  void Function(String, String) onSubmit;
  var valueController = TextEditingController();
  TransactionForm({required this.onSubmit});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Título",
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor (R\$)"),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      onSubmit(titleController.text, valueController.text);
                    },
                    child: Text(
                      "Nova transação",
                      style: TextStyle(color: Colors.purple),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
