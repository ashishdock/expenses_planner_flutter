import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount);
    titleController.clear();
    amountController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) {
                submitData();
              },

              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitData();
              },
              // onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              onPressed: () {
                // print('Title: $titleInput');
                // print('Amount: $amountInput');
                submitData();
                print('Title: ${titleController.text}');
                print('Amount: ${amountController.text}');
                // titleInput = '';
                // amountInput = '';
              },
              child: Text('Add Transaction'),
              textColor: Colors.purpleAccent,
            )
          ],
        ),
      ),
    );
  }
}
