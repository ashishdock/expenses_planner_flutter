import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.blue[100],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 21,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Accessories',
      amount: 26.53,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Clothes',
      amount: 10.53,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Peripherals',
      amount: 36.53,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'Toiletries',
      amount: 6.53,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't7',
      title: 'Utensils',
      amount: 12.53,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't8',
      title: 'Stationery',
      amount: 32.53,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransation(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () => null,
          // behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandsacapeContent(
      bool isLandscape, BuildContext context, AppBar appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() => _showChart = val);
            },
          )
        ],
      ),
      _showChart
          ? chartWidget(context, appBar, 0.8)
          :
          // NewTransaction(_addNewTransaction),
          txListWidget(context, appBar),
    ];
  }

  List<Widget> _buildPortraitContent(
      bool isLandscape, BuildContext context, AppBar appBar) {
    return [
      chartWidget(context, appBar, 0.3),
      txListWidget(context, appBar),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expense Log',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransation(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Expense Log',
              style: Theme.of(context).appBarTheme.textTheme.headline6,
            ),
            actions: [
              IconButton(
                onPressed: () => startAddNewTransation(context),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: SafeArea(
              child: appBody(isLandscape, context, appBar),
            ),
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody(isLandscape, context, appBar),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add_box,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => startAddNewTransation(context),
                  ),
          );
  }

  SingleChildScrollView appBody(
      bool isLandscape, BuildContext context, AppBar appBar) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isLandscape)
            ..._buildPortraitContent(isLandscape, context, appBar)
          else if (isLandscape)
            ..._buildLandsacapeContent(isLandscape, context, appBar)
          // Top Column children
        ],
      ),
    );
  }

  Container chartWidget(BuildContext context, AppBar appBar, double height) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          height,
      child: Chart(_recentTransactions),
    );
  }

  Container txListWidget(BuildContext context, AppBar appBar) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        userTransactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );
  }
}
