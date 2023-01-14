import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _userTransactions
          .map(
            (tx) => Card(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      '\$${tx.amount}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green[600],
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(tx.date),
                        style: TextStyle(
                          color: Colors.blueGrey[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
