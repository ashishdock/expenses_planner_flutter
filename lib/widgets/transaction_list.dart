import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList({@required this.userTransactions, @required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: userTransactions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '                  No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(userTransactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: userTransactions.length,
            ),
    );
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