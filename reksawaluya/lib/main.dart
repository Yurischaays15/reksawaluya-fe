import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/account_info/index.dart';
import 'package:reksawaluya/routes/home/index.dart';
import 'package:reksawaluya/routes/login/index.dart';
import 'package:reksawaluya/routes/register/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'rs reksa waluya',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'rs reksa waluya'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Network network = Get.put(Network());
  Widget _theScreen = Container();

  _popScren() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool(Constant.loggedInKey);
    if (loggedIn ?? false) {
      setState(() {
        _theScreen = const HomeView();
      });
    } else {
      setState(() {
        _theScreen = const LoginView();
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _popScren();
  }

  @override
  Widget build(BuildContext context) {
    return _theScreen;
  }
}
