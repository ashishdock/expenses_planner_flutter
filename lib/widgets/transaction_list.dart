import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList({@required this.userTransactions, @required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView(
            children: userTransactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx,
                    ))
                .toList());
  }
}




// Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColorLight,
//                             width: 2,
//                           ),
//                         ),
//                         padding: EdgeInsets.all(10),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         child: Text(
//                           '\$${userTransactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.deepPurple,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             userTransactions[index].title,
//                             style: Theme.of(context).textTheme.headline6,
//                             // TextStyle(
//                             //   fontWeight: FontWeight.bold,
//                             //   fontSize: 20,
//                             //   color: Colors.green[600],
//                             // ),
//                           ),
//                           Text(
//                             DateFormat.yMMMd()
//                                 .format(userTransactions[index].date),
//                             style: TextStyle(
//                               color: Colors.blueGrey[300],
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );