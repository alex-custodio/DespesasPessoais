import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  void Function(String, String, DateTime) onSubmit;
  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  var titleController = TextEditingController();
  DateTime? selectedDate;
  var valueController = TextEditingController();

  onSubmitForm() {
    var title = titleController.text;
    var value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value.toString(), selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom
          ),
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
              Container(
                  height: 70,
                  child: Row(
                    children: [
                      Text(selectedDate == null ? "Nenhuma data selecionada" :  "Data Selecionada: ${DateFormat("d/MM/y").format(selectedDate!)}"),
                      TextButton(
                        child: Text(
                          'Selecionar Data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _showDatePicker,
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onSubmitForm,
                    child: Text("Nova transação"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
