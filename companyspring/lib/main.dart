import 'package:companyspring/database/databaseConfig.dart';
import 'package:companyspring/pages/loginPage.dart';
import 'package:companyspring/pages/mainPage.dart';
import 'package:companyspring/pages/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:sqflite/sqflite.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Future<void> _dbInitFuture;
  MySQLConnection? _conn;

  @override
  void initState() {
    super.initState();
    _dbInitFuture = _initDb();
    WidgetsBinding.instance.addObserver(this);
  }

Future<void> _initDb() async {
  await DatabaseService().dbConnector();
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dbInitFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: '/companyspring/login',
            navigatorKey: navigatorKey,
            routes: {
              '/companyspring/login': (context) => const LoginPage(),
              '/companyspring/register': (context) => const RegisterPage(),
              '/companyspring/main': (context) => const MainPage(),
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _closeDatabaseConnection();
    }
  }

  Future<void> _closeDatabaseConnection() async {
    if (_conn != null) {
      await _conn!.close();
      print("Connection closed");
    }
  }
}