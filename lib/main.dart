import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text(
                'Chart'.toUpperCase(),
              ),
              elevation: 5,
            ),
          ),
          Card(
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
                    // onChanged: (value) => titleInput = value,
                  ),
                  TextField(
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: 'Amount',
                    ),
                    controller: amountController,
                    // onChanged: (value) => amountInput = value,
                  ),
                  FlatButton(
                    onPressed: () {
                      // print('Title: $titleInput');
                      // print('Amount: $amountInput');

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
          ),
          TransactionList(),
        ], // Top Column children
      ),
    );
  }
}
