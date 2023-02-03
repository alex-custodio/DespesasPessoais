import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  var titleController = TextEditingController();
  void Function(String, String) onSubmit;
  var valueController = TextEditingController();

  onSubmitForm() {
    var title = titleController.text;
    var value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    onSubmit(title, value.toString());
  }

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
              onSubmitted: (_) => onSubmitForm(),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor (R\$)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => onSubmitForm(),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: onSubmitForm,
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
